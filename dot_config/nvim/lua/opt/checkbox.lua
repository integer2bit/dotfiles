-- Markdown checkbox toggler
-- Toggle between unchecked [ ] and checked [x].
-- Works in normal mode on the current line and in visual mode on selected lines.

local M = {}

M.config = {
	-- Checkbox state cycle: [ ] -> [x] -> [ ]
	order = { " ", "x" },

	-- If true, normal text becomes "- [ ] text".
	create_new = true,

	-- Skip blank lines when toggling a visual selection.
	skip_blank_lines = true,
}

---@param current string|nil
---@return string
local function next_checkbox_state(current)
	if current == " " then
		return "x"
	end
	return " "
end

---@param line string
---@return string|nil prefix
---@return string|nil rest
local function parse_list_prefix(line)
	-- Unordered lists: - item, * item, + item
	local indent, bullet, spaces, rest = line:match("^(%s*)([-+*])(%s+)(.*)$")
	if bullet then
		return indent .. bullet .. spaces, rest
	end

	-- Ordered lists: 1. item, 1) item
	local indent2, number, delimiter, spaces2, rest2 = line:match("^(%s*)(%d+)([%.%)])(%s+)(.*)$")
	if number then
		return indent2 .. number .. delimiter .. spaces2, rest2
	end

	return nil, nil
end

---@param rest string
---@return string|nil state
---@return string|nil whitespace
---@return string|nil body
local function parse_checkbox_rest(rest)
	local state, whitespace, body = rest:match("^%[(.)%](%s*)(.*)$")
	if state ~= nil then
		return state, whitespace, body
	end
	return nil, nil, nil
end

---@param lnum integer
---@param opts? { skip_blank?: boolean }
local function toggle_line(lnum, opts)
	opts = opts or {}
	local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
	if not line then
		return
	end

	-- In visual mode, skip blank lines if configured.
	-- In normal mode, a blank line should still become "- [ ] ".
	if opts.skip_blank and M.config.skip_blank_lines and not line:match("%S") then
		return
	end

	local prefix, rest = parse_list_prefix(line)

	if prefix and rest then
		local current_state, whitespace, body = parse_checkbox_rest(rest)

		if current_state then
			-- Existing checkbox: - [ ] task <-> - [x] task
			local next_state = next_checkbox_state(current_state)
			if whitespace == "" and body ~= "" then
				whitespace = " "
			end
			line = prefix .. "[" .. next_state .. "]" .. whitespace .. body
		else
			-- Plain list item: - task -> - [ ] task
			line = prefix .. "[ ] " .. rest
		end
	elseif M.config.create_new then
		-- Normal paragraph: task -> - [ ] task
		local indent = line:match("^(%s*)") or ""
		local after_indent = line:sub(#indent + 1)
		line = indent .. "- [ ] " .. after_indent
	else
		return
	end

	vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, true, { line })
end

function M.toggle_checkbox()
	local mode = vim.fn.mode()

	if mode == "v" or mode == "V" or mode == "\22" then
		local start_pos = vim.fn.getpos("v")
		local end_pos = vim.fn.getpos(".")
		local start_line = start_pos[2]
		local end_line = end_pos[2]

		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end

		for lnum = start_line, end_line do
			toggle_line(lnum, { skip_blank = true })
		end

		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	else
		local lnum = vim.api.nvim_win_get_cursor(0)[1]
		toggle_line(lnum, { skip_blank = false })
	end
end

vim.keymap.set({ "n", "v" }, "<leader>oc", function()
	M.toggle_checkbox()
end, {
	desc = "Toggle/create markdown checkbox",
	silent = true,
})

return M
