return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					vertical = {
						width_padding = 0.05,
						height_padding = 1,
						preview_height = 0.5,
					},
					horizontal = {
						width_padding = 0.1,
						height_padding = 0.1,
						preview_height = 0.5,
						preview_width = 0.5,
					},
				},
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-f>"] = "to_fuzzy_refine",
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"-H",
						"-I",
						"--exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,.cache,.ghcup,.conda,.rustup,.cargo,.local,.obsidian}",
						"--strip-cwd-prefix",
					},
				},
				buffers = {
					theme = "dropdown",
					path_display = { "smart" },
					ignore_current_buffer = true,
					previewer = false,
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer + actions.move_to_top,
						},
						n = {
							["<C-d>"] = actions.delete_buffer + actions.move_to_top,
							["dd"] = actions.delete_buffer + actions.move_to_top,
						},
					},
					initial_mode = "normal",
				},
			},
		})

		-- Wrap lines in previewer
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function(args)
				vim.wo.wrap = true
				-- vim.wo.number = true
			end,
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles only_cwd=true<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help Tags" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "buffers list" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks list" })
		keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", { desc = "notify list" })
	end,
}
