-- keymap

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- https://www.reddit.com/r/vim/comments/3k4cbr/problem_with_gj_and_gk/
vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
-- window operation
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
-- quit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
-- change directory into current file path
vim.keymap.set("n", "<leader>cd", function()
	local cwd = vim.fn.expand("%:h")
	vim.cmd("cd " .. cwd)
	print("Changed directory to " .. cwd)
end, { desc = "Set current buffer directory as working directory" })
-- black hole register keymap
vim.keymap.set("n", '<leader>"', '"_', { noremap = true, silent = true, desc = "black hole register" })
vim.keymap.set("v", '<leader>"', '"_', { noremap = true, silent = true, desc = "black hole register" })
-- window management
vim.keymap.set("n", "<C-w>h", "<C-w>s", { desc = "Horizontal split window" }) -- open new tab
-- buffer management
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next buffer" }) -- open new tab
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Previous buffer" }) -- open new tab
vim.keymap.set("n", "<leader>bl", "<cmd>blast<CR>", { desc = "Last buffer" }) -- open new tab
vim.keymap.set("n", "<leader>bd", "<cmd>bd!<CR>", { desc = "Delete current buffer" }) --  move current buffer to new tab
-- Disable bufferline
vim.opt.showtabline = 0
-- tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
