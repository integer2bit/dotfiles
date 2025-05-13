return {
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		init = function()
			vim.g.undotree_WindowLayout = 2
		end,
		keys = {
			{
				"<leader>u",
				"<cmd>UndotreeToggle<CR>",
				noremap = true,
				silent = true,
				desc = "Toggle Undotree",
			},
		},
	},
}
