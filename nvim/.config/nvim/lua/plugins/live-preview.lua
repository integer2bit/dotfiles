return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"ibhagwan/fzf-lua",
	},
	keys = {
		{ "<leader>op", "<cmd>LivePreview start<cr>", desc = "Markdown Preview start" },
		{ "<leader>oP", "<cmd>LivePreview close<cr>", desc = "Markdown Preview close" },
	},
}
