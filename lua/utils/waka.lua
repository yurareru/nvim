---@diagnostic disable: unused-local
local M = {}

local cache = {
	value = " loading...",
	last_update = 0,
	updating = false,
}

local cache_file = vim.fn.stdpath("cache") .. "/waka_today.json"

local function read_api_key()
	local cfg_path = vim.fn.expand("~/.wakatime.cfg")
	local file = io.open(cfg_path, "r")
	if not file then
		return nil
	end
	for line in file:lines() do
		local key = line:match("api_key%s*=%s*(.+)")
		if key then
			file:close()
			return key
		end
	end
	file:close()
	return nil
end

local function save_cache()
	local file = io.open(cache_file, "w")
	if file then
		file:write(vim.json.encode(cache))
		file:close()
	end
end

local function load_cache()
	local file = io.open(cache_file, "r")
	if not file then
		return
	end
	local ok, data = pcall(vim.fn.json_decode, file:read("*a"))
	file:close()
	if ok and data then
		cache = data
	end
end

load_cache()

-- "wakatime-cli --today" is buggy
local function fetch_today(callback)
	local api_key = read_api_key()
	if not api_key then
		callback(" N/A")
		return
	end

	local auth = vim.fn.system({ "printf", "%s:", api_key })
	local encoded = vim.fn.system({ "base64" }, auth):gsub("%s+", "")
	-- /api/v1/users/current/status_bar/today is cached
	local url = "https://wakatime.com/api/v1/users/current/summaries?range=Today"

	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)

	local handle
	local result = {}

	handle = vim.loop.spawn("curl", {
		args = { "-s", "-H", "Authorization: Basic " .. encoded, url },
		stdio = { nil, stdout, stderr },
	}, function(code, signal)
		stdout:close()
		stderr:close()
		handle:close()

		local ok, data = pcall(vim.json.decode, table.concat(result))
		if ok and data and data.data and data.data[1] and data.data[1].grand_total then
			local total = data.data[1].grand_total
			callback(" " .. total.text)
		else
			callback(" N/A")
		end
		cache.updating = false
		cache.last_update = os.time()
	end)

	stdout:read_start(function(err, chunk)
		if chunk then
			table.insert(result, chunk)
		end
	end)
	stderr:read_start(function() end)
end

function M.today_time()
	local now = os.time()
	if now - cache.last_update > 30 and not cache.updating then
		cache.updating = true
		fetch_today(function(val)
			cache.value = val
			save_cache()
		end)
	end
	return cache.value
end

fetch_today(function(val)
	cache.value = val
	save_cache()
end)

return M
