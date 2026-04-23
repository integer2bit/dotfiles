require("luasnip.loaders.from_lua").load({
  paths = { vim.fn.stdpath("config") .. "/luasnippets" },
})
require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/snippets" },
})
