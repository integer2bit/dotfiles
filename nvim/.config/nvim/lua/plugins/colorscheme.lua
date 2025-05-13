return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	opts = function(_, opts)
		vim.cmd.colorscheme("onedark")
	end,
}
