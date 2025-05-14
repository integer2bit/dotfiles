-- keymap
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" }) -- show diagnostics for line
-- vim.lsp.diagnostic settings
vim.diagnostic.config({
	float = {
		source = true,
	},
	virtual_lines = {
		current_line = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰠠",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
-- Enable LSP servers
local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
	local name = vim.fn.fnamemodify(v, ":t:r")
	lsp_configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(lsp_configs))
