return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufWinEnter" },
	opts = function(_, opts)
		local actions = require("fzf-lua").actions
		vim.cmd("FzfLua register_ui_select")
		return {
			winopts = {
				fullscreen = true,
				preview = {
					wrap = true,
				},
			},
			keymap = {
				builtin = {
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
					["<c-d>"] = "preview-page-down",
					["<c-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-f"] = "half-page-down",
					["ctrl-b"] = "half-page-up",
				},
			},
			actions = {
				files = {
					["enter"] = actions.file_edit_or_qf,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["ctrl-q"] = actions.file_sel_to_qf,
					["ctrl-Q"] = actions.file_sel_to_ll,
					["ctrl-h"] = actions.toggle_hidden,
				},
			},
			files = {
				fd_opts = [[--color=never --hidden --type f --type l --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,.cache,.ghcup,.conda,.rustup,.cargo,.local,.obsidian} --strip-cwd-prefix]],
			},
			oldfiles = {
				prompt = "History❯ ",
				cwd_only = true,
				stat_file = true, -- verify files exist on disk
				include_current_session = false, -- include bufs from current session
			},
			buffers = {
				prompt = "Buffers❯ ",
				-- winopts = {
				-- 	fullscreen = false,
				-- 	preview = { hidden = true },
				-- },
			},
		}
	end,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Fuzzy Find files" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Fuzzy find Oldfiles files" },
		{ "<leader>fR", "<cmd>FzfLua resume<cr>", desc = "Fuzzy Resume" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Find Help tags" },
		{ "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Find String in cwd" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find Buffer" },
		{ "<leader>fc", "<cmd>FzfLua grep_cword<cr>", desc = "Find string under Cursor in cwd" },
		{ '<leader>f"', "<cmd>FzfLua registers<cr>", desc = "register list" },
		{ "<leader>f'", "<cmd>FzfLua marks<cr>", desc = "mark list" },
		{ "<leader>fn", "<cmd>NoiceFzf<cr>", desc = "notify list" },
		-- lsp
		{ "<leader>gr", "<cmd>FzfLua lsp_references<CR>", desc = "Show LSP references" },
		{ "<leader>gd", "<cmd>FzfLua lsp_definitions<CR>", desc = "Show LSP definitions" },
		{ "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", desc = "Show LSP type definitions" },
		{ "<leader>gs", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "Show LSP docuemnt symbols" },
		{ "<leader>D", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Show workspace diagnostics" },
	},
}
