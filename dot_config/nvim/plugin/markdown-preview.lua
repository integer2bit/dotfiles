vim.g.mkdp_filetypes = { "markdown" }
vim.cmd([[
    function OpenMarkdownPreview (url)
      execute "silent ! firefox --new-window --app=" . a:url
    endfunction
]])
vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
vim.keymap.set("n", "<leader>op", ":MarkdownPreviewToggle<cr>", { desc = "toggle markdown preview" })
-- vim.keymap.set("n", "<leader>oP", ":MarkdownPreviewStop<cr>", { desc = "close markdown preview" })
