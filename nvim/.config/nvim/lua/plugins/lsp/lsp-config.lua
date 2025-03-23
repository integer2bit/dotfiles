return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{
			"folke/lazydev.nvim",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	opts = {
		servers = {
			lua_ls = {},
			bashls = {},
			pyright = {},
		},
	},
	config = function(_, opts)
		local on_attach = function(_, bufnr)
			opts.buffer = bufnr
			-- set keybinds
			vim.keymap.set(
				"n",
				"gr",
				"<cmd>Telescope lsp_references<CR>",
				{ desc = "Show LSP references", noremap = true, silent = true, buffer = bufnr }
			) -- show definition, references
			vim.keymap.set(
				"n",
				"gD",
				vim.lsp.buf.declaration,
				{ desc = "Go to declaration", noremap = true, silent = true, buffer = bufnr }
			) -- go to declaration
			vim.keymap.set(
				"n",
				"gd",
				"<cmd>Telescope lsp_definitions<CR>",
				{ desc = "Show LSP definitions", noremap = true, silent = true, buffer = bufnr }
			) -- show lsp definitions
			vim.keymap.set(
				"n",
				"gi",
				"<cmd>Telescope lsp_implementations<CR>",
				{ desc = "Show LSP implementations", noremap = true, silent = true, buffer = bufnr }
			) -- show lsp implementations
			vim.keymap.set(
				"n",
				"gt",
				"<cmd>Telescope lsp_type_definitions<CR>",
				{ desc = "Show LSP type definitions", noremap = true, silent = true, buffer = bufnr }
			) -- show lsp type definitions
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ desc = "See available code actions", noremap = true, silent = true, buffer = bufnr }
			) -- see available code actions, in visual mode will apply to selection
			vim.keymap.set(
				"n",
				"<leader>rn",
				vim.lsp.buf.rename,
				{ desc = "Smart rename", noremap = true, silent = true, buffer = bufnr }
			) -- smart rename

			vim.keymap.set(
				"n",
				"<leader>D",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ desc = "Show buffer diagnostics", noremap = true, silent = true, buffer = bufnr }
			) -- show  diagnostics for file
			vim.keymap.set(
				"n",
				"<leader>d",
				vim.diagnostic.open_float,
				{ desc = "Show line diagnostics", noremap = true, silent = true, buffer = bufnr }
			) -- show diagnostics for line

			-- neovim v0.10 default keymap
			-- keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true }) -- jump to previous diagnostic in buffer
			-- keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true }) -- jump to next diagnostic in buffer
			-- keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true }) -- show documentation for what is under cursor
			vim.keymap.set(
				"n",
				"<leader>rs",
				":LspRestart<CR>",
				{ desc = "Restart LSP", noremap = true, silent = true, buffer = bufnr }
			) -- mapping to restart lsp if necessary
		end
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			config.on_attach = on_attach
			lspconfig[server].setup(config)
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
	end,
}
