return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"folke/noice.nvim",
	},
	config = function()
		require("lualine").setup({
			config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					theme = "",
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "vim.fn.expand('%:p')", "selectioncount" },
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#c6d0f5" },
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#c6d0f5" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#c6d0f5" },
					},
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
