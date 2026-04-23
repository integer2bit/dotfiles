---@diagnostic disable: undefined-global
local snippets = {}
table.insert(
	snippets,
	s(
		"daily",
		fmt(
			[[
---
title: "{}"
date: {}
---
]],
			{
				f(function(_, snip)
					return snip.env.TM_FILENAME_BASE or ""
				end),
				f(function()
					return os.date("%Y-%m-%d %H:%M")
				end),
			}
		)
	)
)

table.insert(
	snippets,
	s(
		"blog",
		fmt(
			[[
---
title: "{}"
description: ""
tags: []
date: {}
---

# {}
]],
			{
				f(function(_, snip)
					return snip.env.TM_FILENAME_BASE or ""
				end),
				f(function()
					return os.date("%Y-%m-%d %H:%M")
				end),
				f(function(_, snip)
					return snip.env.TM_FILENAME_BASE or ""
				end),
			}
		)
	)
)

table.insert(
	snippets,
	s(
		"last modified",
		fmt(
			[[
last modified: {}
]],
			{
				f(function()
					return os.date("%Y-%m-%d %H:%M")
				end),
			}
		)
	)
)
return snippets
