return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonToolsInstall", "MasonToolsUpdate" },
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
		opts = {
			ensure_installed = {
				-- language server
				"lua-language-server",
				"bash-language-server",
				"marksman",
				"ruff",
				"html-lsp",
				"typescript-language-server",
				"css-lsp",
				-- formatter and linter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"shfmt", -- bash shell formatter
				"jsonlint", --json linter
			},
		},
	},
}
