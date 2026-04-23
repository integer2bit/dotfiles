-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/folke/lazydev.nvim",
	-- fzf
	"https://github.com/ibhagwan/fzf-lua",
	-- git
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/lewis6991/gitsigns.nvim",
	-- auto completion and snippets
	"https://github.com/saghen/blink.compat",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") },
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/romus204/tree-sitter-manager.nvim",
	"https://github.com/folke/which-key.nvim",
	-- "https://github.com/psliwka/termcolors.nvim",
})

-- "Register" plugin, but not load it right away
vim.pack.add({
	"https://github.com/Olical/conjure",
	"https://github.com/lervag/vimtex",
	-- Run ::call mkdp#util#install()call mkdp#util#install() to download compiled binary
	"https://github.com/iamcco/markdown-preview.nvim",
	"https://github.com/3rd/image.nvim",
	"https://github.com/HakonHarnes/img-clip.nvim",
}, { load = function() end })
require("nvim-autopairs").setup()

-- Loading plugins with FileType
vim.api.nvim_create_autocmd("FileType", {
	pattern = "scheme",
	callback = function()
		vim.cmd.packadd("conjure")
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.cmd.packadd("vimtex")
	end,
})
vim.filetype.add({
	extension = {
		png = "image",
		jpg = "image",
		jpeg = "image",
		gif = "image",
		webp = "image",
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "image" },
	callback = function()
		vim.cmd.packadd({ "markdown-preview.nvim" })
		vim.cmd.packadd({ "image.nvim" })
		vim.cmd.packadd({ "img-clip.nvim" })
		require("image").setup()
		vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "Paste image from system clipboard" })
	end,
})

vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
