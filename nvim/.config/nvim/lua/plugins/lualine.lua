return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	opts = function()
		local custom_gruvbox = require("lualine.themes.gruvbox")
		custom_gruvbox.normal = {
			a = { fg = "#d6d9e0", bg = "#14161b" },
			b = { fg = "#d6d9e0", bg = "#14161b" },
			c = { fg = "#d6d9e0", bg = "#14161b" },
		}
		custom_gruvbox.insert = {}
		custom_gruvbox.visual = {}
		custom_gruvbox.replace = {}
		custom_gruvbox.command = {}
		custom_gruvbox.terminal = {}
		custom_gruvbox.inactive = {}

		require("lualine").setup({
			options = {
				theme = "gruvbox",
			},
			sections = {
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"vim.fn.expand('%:p')",
						"selectioncount",
						-- color = { fg = "#d6d9e0", bg = "#14161b" },
						max_length = vim.o.columns,
						-- color = function(section)
						-- 	return {
						-- 		fg = vim.bo.modified and "#d6d9e0" or "#14161b",
						-- 	}
						-- end,
					},
				},
				lualine_x = {
					{
						"encoding",
						"fileformat",
						"filetype",
						draw_empty = true,
						-- color = { fg = "#d6d9e0", bg = "#14161b" },
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
