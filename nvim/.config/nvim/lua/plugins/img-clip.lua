return {
	"HakonHarnes/img-clip.nvim",
	dependencies = { -- note how they're inverted to above example
		"stevearc/oil.nvim",
	},
	opts = {
		filetypes = {
			markdown = {
				url_encode_path = true, ---@type boolean
				template = "![$CURSOR]($FILE_PATH)", ---@type string
				download_images = false, ---@type boolean
			},
		},
	},
	keys = {
		-- suggested keymap
		{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
	},
}
