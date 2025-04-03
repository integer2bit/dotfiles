-- checkhealth vim.lsp in v0.11 instead LspInfo
local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- set keybinds
	vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", opts }) -- show definition, references
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", opts }) -- go to declaration
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions", opts }) -- show lsp definitions
	vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions", opts }) -- show lsp type definitions
	vim.keymap.set(
		"n",
		"<leader>D",
		"<cmd>Telescope diagnostics bufnr=0<CR>",
		{ desc = "Show buffer diagnostics", opts }
	) -- show  diagnostics for file
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics", opts }) -- show diagnostics for line
	vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", opts }) -- mapping to restart lsp if necessary
end
-- default diagnostic settings
vim.diagnostic.enable(false)
-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- Enable LSP servers
local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
	local name = vim.fn.fnamemodify(v, ":t:r")
	lsp_configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(lsp_configs))
