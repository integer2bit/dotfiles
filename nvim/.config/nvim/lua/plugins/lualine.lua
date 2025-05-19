return {
	"nvim-lualine/lualine.nvim",
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	dependencies = { "echasnovski/mini.icons" },
	opts = function()
		require("mini.icons").setup()
		require("mini.icons").mock_nvim_web_devicons()
		require("lualine").setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "vim.fn.expand('%:p')", "selectioncount" },
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
