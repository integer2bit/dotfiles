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
		"today",
		{ f(function()
			return os.date("%Y-%m-%d-%A")
		end) },
		{ description = "Today's date (YYYY-MM-DD-Weekday)" }
	)
)

table.insert(
	snippets,
	s("yesterday", {
		f(function()
			local yesterday_timestamp = os.time() - 24 * 60 * 60
			return os.date("%Y-%m-%d-%A", yesterday_timestamp)
		end),
	}, { description = "Yesterday's date (YYYY-MM-DD-Weekday)" })
)

table.insert(
	snippets,
	s("tomorrow", {
		f(function()
			local tomorrow_timestamp = os.time() + 24 * 60 * 60
			return os.date("%Y-%m-%d-%A", tomorrow_timestamp)
		end),
	}, { description = "Tomorrow's date (YYYY-MM-DD-Weekday)" })
)

return snippets
