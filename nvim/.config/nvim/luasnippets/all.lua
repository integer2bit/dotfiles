---@diagnostic disable: undefined-global
return {
	s({ trig = "date" }, {
		f(function()
			return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
		end, {}),
	}),
}
