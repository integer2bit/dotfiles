return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"ibhagwan/fzf-lua",
	},
	opts = function(_, opts)
		vim.keymap.set("n", "<leader>op", "<cmd>LivePreview start<cr>", { desc = "Markdown Preview" })
		vim.keymap.set("n", "<leader>oP", "<cmd>LivePreview close<cr>", { desc = "Markdown Preview" })
	end,
}
