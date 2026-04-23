-- Refernce:https://vieitesss.github.io/posts/Neovim-custom-status-line/#full-implementation
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

local function get_diagnostics()
	if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
		return ""
	end

	local count = {
		errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
		warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
	}

	local result = {}
	if count.errors > 0 then
		table.insert(result, "" .. count.errors)
	end
	if count.warnings > 0 then
		table.insert(result, "" .. count.warnings)
	end

	return #result > 0 and (table.concat(result, " ") .. " ") or ""
end

local M = {}
function M.active()
	local keys = " %S "
	-- macro recording
	local reg = vim.fn.reg_recording()
	local macro = reg ~= "" and ("Macro @" .. reg .. " ") or ""
	-- filepath
	local filepath = "[%f] %m%r "
	-- align
	local align_right = "%="
	-- filetype
	local filetype = "%Y"
	-- lsp diagnostics
	local diagnostics = get_diagnostics()
	-- percentage and the current line and column of the cursor
	local percentage = "%p%%"
	local position = "%l:%c"

	local left_section = keys .. macro .. filepath .. diagnostics
	local right_section = filetype .. " │ " .. percentage .. " │ " .. position .. " "
	return left_section .. align_right .. right_section
end

function M.inactive()
	return "[%f] %m"
end

vim.api.nvim_set_hl(0, "StatusLine", { bg = "#14161b", fg = "#d8dee9" })

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = group,
	desc = "Update statusline on diagnostic change",
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	desc = "Activate statusline on focus",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.require('opt.statusline').active()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = group,
	desc = "Deactivate statusline when unfocused",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.require('opt.statusline').inactive()"
	end,
})

return M
