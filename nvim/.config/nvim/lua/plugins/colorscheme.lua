return {
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	version = false,
	-- 	lazy = false,
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	-- Optional; default configuration will be used if setup isn't called.
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			background = "soft",
	-- 		})
	-- 		vim.cmd([[colorscheme everforest]])
	-- 	end,
	-- },

	-- "catppuccin/nvim", name = "catppuccin", priority = 1000,
	--     config = function()
	--     vim.cmd.colorscheme "catppuccin-frappe"
	--   end,
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "dark",
			})
			vim.cmd.colorscheme("onedark")
		end,
	},
}
