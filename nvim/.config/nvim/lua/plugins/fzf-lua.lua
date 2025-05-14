return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	event = { "BufWinEnter" },
	opts = function(_, opts)
		local actions = require("fzf-lua").actions
		return {
			keymap = {
				builtin = {
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
			oldfiles = {
				prompt = "History❯ ",
				cwd_only = true,
				stat_file = true, -- verify files exist on disk
				include_current_session = false, -- include bufs from current session
			},
		}
	end,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files hidden=false<cr>", desc = "Fuzzy find files" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Fuzzy find recent files" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Find Help Tags" },
		{ "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Find string in cwd" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "buffer list" },
		{ "<leader>fc", "<cmd>FzfLua grep_cword<cr>", desc = "Find string under cursor in cwd" },
		{ '<leader>f"', "<cmd>FzfLua registers<cr>", desc = "register list" },
		{ "<leader>f'", "<cmd>FzfLua marks<cr>", desc = "mark list" },
		{ "<leader>fn", "<cmd>NoicePick<cr>", desc = "notify list" },
		-- lsp
		{ "<leader>gr", "<cmd>FzfLua lsp_references<CR>", desc = "Show LSP references" },
		{ "<leader>gd", "<cmd>FzfLua lsp_definitions<CR>", desc = "Show LSP definitions" },
		{ "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", desc = "Show LSP type definitions" },
		{ "<leader>D", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Show workspace diagnostics" },
	},
}
