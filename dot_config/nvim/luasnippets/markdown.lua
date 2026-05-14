---@diagnostic disable: undefined-global
local snippets = {}

local function iso_date()
	return os.date("%Y-%m-%d")
end

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

# {}
]],
			{
				f(function(_, snip)
					return snip.env.TM_FILENAME_BASE or ""
				end),
				f(function()
					return iso_date()
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
		"blog",
		fmt(
			[[
---
title: "{}"
description: ""
date: {}
---

# {}
]],
			{
				f(function(_, snip)
					return snip.env.TM_FILENAME_BASE or ""
				end),
				f(function()
					return iso_date()
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
					return iso_date()
				end),
			}
		)
	)
)
return snippets
