-- PDF link opener and URL handler for gx mapping
-- Supports:
--   [display text](pdf:path/to/file.pdf#page_number)  (markdown syntax)
--   pdf:path/to/file.pdf#page_number
--   https://..., [text](url) -> opens with system default

local function open_with_gx()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-indexed byte offset

	-- Try markdown PDF link: [text](pdf:path#page)
	local md_search = 1
	while true do
		local md_s, md_e, _, md_path, md_pg = line:find("%[(.-)%]%(pdf:([^)#]+)#(%d+)%)", md_search)
		if not md_s then
			break
		end
		if col >= md_s - 1 and col <= md_e then
			local abs_path = md_path
			if abs_path:match("^~/") then
				abs_path = vim.fn.expand(abs_path)
			elseif not abs_path:match("^/") then
				abs_path = vim.fn.fnamemodify(abs_path, ":p")
			end
			if vim.fn.filereadable(abs_path) == 0 then
				vim.notify("File not found: " .. abs_path, vim.log.levels.ERROR)
				return
			end
			vim.fn.jobstart({ "zathura", "--page", md_pg, abs_path }, { detach = true })
			vim.notify("Opening " .. vim.fn.fnamemodify(abs_path, ":t") .. " page " .. md_pg)
			return
		end
		md_search = md_e + 1
	end

	-- Try bare PDF link: pdf:path#page
	local best_path, best_page, best_s, best_e
	local search_start = 1
	while true do
		local s, e, p, pg = line:find("pdf:([^#]+)#(%d+)", search_start)
		if not s then
			break
		end
		p = p:gsub("%s+$", "")
		if col >= s - 1 and col <= e then
			best_path, best_page, best_s, best_e = p, pg, s, e
			break
		end
		if not best_path or math.abs(col - (s + e) / 2) < math.abs(col - (best_s + best_e) / 2) then
			best_path, best_page, best_s, best_e = p, pg, s, e
		end
		search_start = e + 1
	end

	if best_path then
		local abs_path = best_path
		if abs_path:match("^~/") then
			abs_path = vim.fn.expand(abs_path)
		elseif not abs_path:match("^/") then
			abs_path = vim.fn.fnamemodify(abs_path, ":p")
		end
		if vim.fn.filereadable(abs_path) == 0 then
			vim.notify("File not found: " .. abs_path, vim.log.levels.ERROR)
			return
		end
		vim.fn.jobstart({ "zathura", "--page", best_page, abs_path }, { detach = true })
		vim.notify("Opening " .. vim.fn.fnamemodify(abs_path, ":t") .. " page " .. best_page)
		return
	end

	-- fallback: extract URL from line, check cursor position (like gx.nvim)
	local search = 1
	local first_url
	while true do
		local s, e, u = line:find("(https?://[^)%s]+)", search)
		if not s then
			break
		end
		if not first_url then
			first_url = u
		end
		if col >= s - 1 and col <= e then
			vim.ui.open(u)
			return
		end
		search = e + 1
	end
	-- try markdown URL: [text](url)
	local md_url_s, md_url_e, md_url = line:find("%[.-%]%((https?://[^)%s]+)%)")
	if md_url and col >= md_url_s - 1 and col <= md_url_e then
		vim.ui.open(md_url)
		return
	end
	-- use first URL found, or <cfile> as last resort
	local url = first_url or vim.fn.expand("<cfile>")
	if url and url ~= "" then
		vim.ui.open(url)
	end
end

vim.keymap.set(
	"n",
	"gx",
	open_with_gx,
	{ noremap = true, silent = true, desc = "Open link (PDF in zathura, others with system default)" }
)

-- Query zathura via D-Bus for current file and page number
local function query_zathura()
	local names_raw = vim.fn.system({
		"dbus-send",
		"--session",
		"--dest=org.freedesktop.DBus",
		"--type=method_call",
		"--print-reply",
		"/org/freedesktop/DBus",
		"org.freedesktop.DBus.ListNames",
	})
	if vim.v.shell_error ~= 0 or names_raw == "" then
		return nil, nil
	end

	local zathura_names = {}
	for name in names_raw:gmatch('org%.pwmt%.zathura[^"]*') do
		table.insert(zathura_names, name)
	end
	if #zathura_names == 0 then
		return nil, nil
	end

	local bus = zathura_names[1]

	local filename_raw = vim.fn.system({
		"dbus-send",
		"--session",
		"--dest=" .. bus,
		"--type=method_call",
		"--print-reply",
		"/org/pwmt/zathura",
		"org.freedesktop.DBus.Properties.Get",
		"string:org.pwmt.zathura",
		"string:filename",
	})
	local filename = filename_raw:match('string "(.-)"')
	if not filename or filename == "" then
		return nil, nil
	end

	local pagenum_raw = vim.fn.system({
		"dbus-send",
		"--session",
		"--dest=" .. bus,
		"--type=method_call",
		"--print-reply",
		"/org/pwmt/zathura",
		"org.freedesktop.DBus.Properties.Get",
		"string:org.pwmt.zathura",
		"string:pagenumber",
	})
	local pagenum = tonumber(pagenum_raw:match("uint32 (%d+)")) or 0

	local home = vim.fn.expand("$HOME")
	filename = filename:gsub("^" .. home:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1"), "~")

	return filename, pagenum + 1
end

-- Paste PDF link from zathura in markdown format: [text](pdf:path#page)
local function paste_pdf_link()
	local filepath, page = query_zathura()
	if not filepath then
		vim.notify("No running zathura instance found", vim.log.levels.WARN)
		return
	end
	local path = filepath
	if path:match("^~/") then
		path = vim.fn.expand(path)
	elseif not path:match("^/") then
		path = vim.fn.fnamemodify(path, ":p")
	end
	local link = "[text](pdf:" .. path .. "#" .. page .. ")"
	vim.api.nvim_put({ link }, "c", true, true)
	-- place cursor on "text" for easy editing: position after [ and before ]
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] - #link + 1 })
	vim.notify("Inserted: " .. link)
end

vim.keymap.set("n", "<leader>lp", paste_pdf_link, {
	noremap = true,
	silent = true,
	desc = "Insert PDF link from running zathura",
})

-- Open PDF link with search: [text](pdf:path#page) -> zathura --page N --find text
local function open_pdf_with_search()
	local line = vim.api.nvim_get_current_line()
	local text, path, page = line:match("%[(.-)%]%(pdf:([^)#]+)#(%d+)%)")
	if not text or text == "" then
		vim.notify("No PDF link found on this line", vim.log.levels.WARN)
		return
	end
	local abs_path = path
	if abs_path:match("^~/") then
		abs_path = vim.fn.expand(abs_path)
	elseif not abs_path:match("^/") then
		abs_path = vim.fn.fnamemodify(abs_path, ":p")
	end
	if vim.fn.filereadable(abs_path) == 0 then
		vim.notify("File not found: " .. abs_path, vim.log.levels.ERROR)
		return
	end
	vim.fn.jobstart({ "zathura", "--page", page, "--find", text, abs_path }, { detach = true })
	vim.notify("Opening " .. vim.fn.fnamemodify(abs_path, ":t") .. " page " .. page .. ' search "' .. text .. '"')
end

vim.keymap.set("n", "<leader>gx", open_pdf_with_search, {
	noremap = true,
	silent = true,
	desc = "Open PDF link and search display text in zathura",
})

-- Conceal for markdown PDF links
-- [text](pdf:path#page) -> shows only "text", cursor line reveals full syntax
local group = vim.api.nvim_create_augroup("PdfLinkConceal", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "FileType" }, {
	group = group,
	pattern = { "markdown", "md" },
	callback = function()
		-- set conceal options for this window
		vim.wo.conceallevel = 2
		vim.wo.concealcursor = "i"

		-- conceal "(pdf:path#page)" entirely, hiding the URL and page
		-- this works with the built-in markdown conceal that already hides []
		-- result: [text](pdf:path#page) -> shows only "text"
		vim.fn.matchadd("Conceal", "(pdf:[^)]*)", 11, -1, { conceal = "" })
	end,
})
