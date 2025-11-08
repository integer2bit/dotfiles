return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.cmd([[
    function OpenMarkdownPreview (url)
      execute "silent ! google-chrome-stable --new-window --app=" . a:url
    endfunction
]])
		vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		vim.keymap.set("n", "<leader>op", ":MarkdownPreviewToggle<cr>", { desc = "toggle markdown preview" })
		-- vim.keymap.set("n", "<leader>oP", ":MarkdownPreviewStop<cr>", { desc = "close markdown preview" })
	end,
	ft = { "markdown" },
}
