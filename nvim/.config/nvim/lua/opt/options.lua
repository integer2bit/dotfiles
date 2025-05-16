vim.cmd("let g:netrw_liststyle = 3")
local opt = vim.opt
-- true color
opt.termguicolors = true
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.swapfile = false
vim.g.markdown_recommended_style = 0 -- set default tabstop in markdown file
-- vim number
opt.number = true
opt.relativenumber = true
-- scrolloff, keep the cursor at the middle of screen
-- opt.scrolloff = 999
-- jumpoptions
opt.jumpoptions = "stack,view"
-- set vim spell check
-- opt.spelllang = "en_us,cjk"
-- opt.spell = true
-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
-- set cursorline
opt.cursorline = true
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
-- substitute preview in split
opt.inccommand = "split"
-- default split
opt.splitbelow = true
opt.splitright = true
-- set undodir
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.undo//")
-- built-in indent blank line
opt.list = true
opt.listchars = { leadmultispace = "│ ", multispace = "│ ", tab = "│ " }

-- auto create file folders
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*",
	callback = function()
		vim.fn.mkdir(vim.fn.expand("%:h"), "p")
	end,
})

-- set folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

-- fold column and fillchars option
opt.foldenable = true
opt.foldlevelstart = 99
-- opt.foldcolumn = "1"
-- opt.fillchars = "fold: ,foldopen:,foldsep: ,foldclose:"

-- shada file
opt.shada = "'100,<1000,s100,h"

-- clipboard settings
opt.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
-- conseal leavel for markdown
vim.opt.conceallevel = 2
