return {
	"lervag/vimtex",
	lazy = true, -- we don't want to lazy load VimTeX
	ft = { "plaintex", "tex" },
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		vim.g.vimtex_syntax_enabled = true
		vim.g.vimtex_view_general_viewer = "okular"
		-- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
		-- vim.g.Tex_CompileRule_pdf = "xelatex -synctex=1 --interaction=nonstopmode $*"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk_engines = {
			["_"] = "-xelatex",
			-- ["_"] = "-pdflatex",
		}
	end,
}
