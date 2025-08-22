return {
	"obsidian-nvim/obsidian.nvim",
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
	},
	opts = {
		workspaces = {
			{
				name = "",
				path = vim.fn.expand("~/Documents/obsidian"),
			},
		},
		-- Optional, customize how wiki link are generated
		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_path_only(opts)
		end,
		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp (YYYY-MM-DD-HH-MM-SS) and a suffix.
			-- For example, a note with the title 'My new note' will be given an ID like '2024-12-29-14-30-45-my-new-note'.
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into a valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			end

			-- Get the current timestamp in the desired format.
			local timestamp = os.date("%Y-%m-%d-%A")

			return timestamp .. (suffix ~= "" and "-" .. suffix or "")
		end,
		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Set to false to disable completion.
			-- nvim_cmp = true,
			blink = true,
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
			date_format = "%Y-%m-%d %A",
			alias_format = "%B %-d, %Y",
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "fzf-lua",
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
		checkbox = {
			order = { " ", "x" },
		},

		ui = {
			enable = true, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			-- Define how various check-boxes are displayed
			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
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
		legacy_commands = false,
		vim.api.nvim_create_autocmd("User", {
			pattern = "ObsidianNoteEnter",
			callback = function(ev)
				vim.keymap.set("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", {
					buffer = ev.buf,
					desc = "Toggle checkbox",
				})
			end,
		}),
		vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<cr>", { desc = "Obsidian daily note" }),
		vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<cr>", { desc = "Search tags" }),
		vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Search Obsidian" }),
		vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<cr>", { desc = "Open in Obsidian App" }),
		vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Show ObsidianBacklinks" }),
		vim.keymap.set("v", "<leader>oL", "<cmd>Obsidian link<cr>", { desc = "Link visual text to a note" }),
		vim.keymap.set("v", "<leader>ol", "<cmd>Obsidian linkNew<cr>", { desc = "Create link to a new note" }),
		vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<cr>", { desc = "ObsidianLinks in current file" }),
		vim.keymap.set("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "Obsidian rename" }),
		vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Create New Note" }),
	},
}
