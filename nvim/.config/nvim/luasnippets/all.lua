---@diagnostic disable: undefined-global
local function get_future_time_offset_by_minutes(minutes_to_add)
	local current_time_seconds = os.time()
	-- Ensure minutes_to_add is a number, as it might come from a string context if parsed
	local offset_seconds = tonumber(minutes_to_add) * 60
	local future_time_seconds = current_time_seconds + offset_seconds
	return { os.date("%Y-%m-%d %H:%M", future_time_seconds) }
end
local function get_future_time_offset_by_hours(hours_to_add)
	local current_time_seconds = os.time()
	-- Ensure hours_to_add is a number
	local offset_seconds = tonumber(hours_to_add) * 60 * 60 -- hours * 60 min/hr * 60 sec/min
	local future_time_seconds = current_time_seconds + offset_seconds
	return { os.date("%Y-%m-%d %H:%M", future_time_seconds) }
end
local function get_offset_date_time(days_offset)
	local current_time_seconds = os.time()
	local day_in_seconds = 24 * 60 * 60
	local target_time_seconds = current_time_seconds + (days_offset * day_in_seconds)
	return { os.date("%Y-%m-%d %H:%M", target_time_seconds) }
end

local snippets = {}
for i = 1, 60 do
	local trigger_key = "afm" .. i -- after how many minutes
	table.insert(
		snippets,
		s(
			trigger_key, -- The trigger for this specific snippet
			{
				f(function()
					return get_future_time_offset_by_minutes(i)
				end),
			},
			{
				description = fmt("Date & Time + {} minutes (YYYY-MM-DD HH:MM)", { i }),
			}
		)
	)
end
for i = 1, 12 do
	local trigger_key = "afh" .. i -- after how many hours
	table.insert(
		snippets,
		s(
			trigger_key, -- The trigger for this specific snippet
			{
				f(function()
					-- This anonymous function captures the current value of 'i' for this snippet
					return get_future_time_offset_by_hours(i)
				end),
			},
			{
				description = fmt("Date & Time + {} hours (YYYY-MM-DD HH:MM)", { i }),
			}
		)
	)
end
table.insert(
	snippets,
	s(
		"tomorrow",
		{ f(function()
			return get_offset_date_time(1)
		end) },
		{ description = "Tomorrow's date & current time (YYYY-MM-DD HH:MM)" }
	)
)
table.insert(
	snippets,
	s(
		"yesterday",
		{ f(function()
			return get_offset_date_time(-1)
		end) },
		{ description = "Yesterday's date & current time (YYYY-MM-DD HH:MM)" }
	)
)
return snippets
