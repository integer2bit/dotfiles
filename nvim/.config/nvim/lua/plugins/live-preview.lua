return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = function(_, opts)
		vim.keymap.set("n", "<leader>op", "<cmd>LivePreview start<cr>", { desc = "Markdown Preview" })
	end,
}
