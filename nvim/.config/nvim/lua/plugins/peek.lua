return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	-- need install deno on OS
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup()
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		vim.keymap.set("n", "<leader>op", ":PeekOpen<cr>", { desc = "open markdown preview" })
		vim.keymap.set("n", "<leader>oP", ":PeekClose<cr>", { desc = "close markdown preview" })

		require("peek").setup({
			auto_load = true, -- whether to automatically load preview when
			-- entering another markdown buffer
			close_on_bdelete = true, -- close preview window on buffer delete

			syntax = true, -- enable syntax highlighting, affects performance

			theme = "light", -- 'dark' or 'light'

			update_on_change = true,

			app = "webview", -- 'webview', 'browser', string or a table of strings
			filetype = { "markdown" }, -- list of filetypes to recognize as markdown

			-- relevant if update_on_change is true
			throttle_at = 200000, -- start throttling when file exceeds this
			-- amount of bytes in size
			throttle_time = "auto", -- minimum amount of time in milliseconds
		})
	end,
}
