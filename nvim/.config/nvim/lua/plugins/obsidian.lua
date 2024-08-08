return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	-- event = {
	-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	-- 	-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	-- 	"BufReadPre "
	-- 		.. vim.fn.expand("~")
	-- 		.. "/Documents/obsidian/**.md",
	-- 	"BufNewFile " .. vim.fn.expand("~") .. "/Documents/obsidian/**.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "",
					path = "/home/world/Documents/obsidian",
				},
			},
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>oc"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true },
				},
			},
			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},
			-- Optional, for templates (see below).
			-- templates = {
			-- 	subdir = "templates",
			-- 	date_format = "%Y-%m-%d",
			-- 	time_format = "%H:%M",
			-- 	-- A map for custom variables, the key should be the variable and the value a function
			-- 	substitutions = {},
			-- },
			daily_notes = {
				folder = "dailies",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
			},
			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
				name = "telescope.nvim",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				mappings = {
					-- Create a new note from your query.
					new = "<C-n>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
			},
			-- Optional, alternatively you can customize the frontmatter data.
			---@return table
			note_frontmatter_func = function(note)
				-- Add the title of the note as an alias.
				if note.title then
					note:add_alias(note.title)
				end

				local out = {
					id = note.id,
					aliases = note.aliases,
					tags = note.tags,
					-- ["links"] = "",
					-- ["backlins"] = "",
					["Date"] = os.date("%Y-%m-%d %H:%M:%S"),
					["Last modified"] = os.date("%Y-%m-%d %H:%M:%S"),
				}

				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end

				return out
			end,
			ui = {
				enable = true, -- set to false to disable all additional syntax features
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				-- Define how various check-boxes are displayed
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				},
				-- Use bullet marks for non-checkbox lists.
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				-- Replace the above with this if you don't have a patched font:
				-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#61afef" },
					ObsidianExtLinkIcon = { fg = "#61afef" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianBlockID = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				},
			},
			-- Specify how to handle attachments.
			attachments = {
				img_folder = "assets",
			},
			--keymaps
			vim.keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<cr>", { desc = "Obsidian daily note" }),
			vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<cr>", { desc = "Search tags" }),
			vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian" }),
			vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian App" }),
			vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" }),
			vim.keymap.set("v", "<leader>oL", "<cmd>ObsidianLink<cr>", { desc = "Link visual text to a note" }),
			vim.keymap.set("v", "<leader>ol", "<cmd>ObsidianLinkNew<cr>", { desc = "Create link to a new note" }),
			vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "ObsidianLinks in current file" }),
			vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Obsidian rename" }),
			vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" }),
		})
	end,
}
