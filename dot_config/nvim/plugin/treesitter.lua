require("tree-sitter-manager").setup({
	ensure_installed = { "regex", "markdown", "markdown_inline", "vim" },
	auto_install = true,
	-- Optional: custom paths
	-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
	-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
})
