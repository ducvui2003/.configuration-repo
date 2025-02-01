local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_tab_bar = true
config.window_decorations = "RESIZE"

config.default_prog = { "/home/linuxbrew/.linuxbrew/bin/zsh" }

-- For example, changing the color scheme:
config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.font = wezterm.font("JetBrains Mono", {
	weight = "Medium",
})
config.font_size = 18

-- Background
config.window_background_opacity = 0.75
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

local user_home = os.getenv("HOME")

config.window_background_image_hsb = {
	hue = 1.0,
	saturation = 0.9,
	brightness = 0.1,
}

local background_folder = user_home .. "/.config/bg"
config.window_background_image = background_folder .. "/1358894.png"
local function pick_random_background(folder)
	local handle = io.popen('ls "' .. folder .. '"')
	local files = handle:read("*a")
	handle:close()

	local images = {}
	for file in string.gmatch(files, "[^\n]+") do
		table.insert(images, file)
	end

	if #images > 0 then
		return folder .. "/" .. images[math.random(#images)]
	else
		return nil
	end
end

-- Clock
local function get_clock()
	return os.date("%H:%M:%S") -- Current time in "HH:MM:SS" format
end

wezterm.on("update-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Text = get_clock() },
	}))
end)
wezterm.on("window-created", function(window, pane)
	local new_background = pick_random_background(background_folder)
	if new_background then
		window:set_config_overrides({
			window_background_image = new_background,
		})
		wezterm.log_info("New bg:" .. new_background)
	else
		wezterm.log_error("Could not find bg image")
	end
end)

config.status_update_interval = 1

-- Keys
config.keys = {
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		key = "B",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local new_background = pick_random_background(background_folder)
			if new_background then
				window:set_config_overrides({
					window_background_image = new_background,
				})
				wezterm.log_info("New bg:" .. new_background)
			else
				wezterm.log_error("Could not find bg image")
			end
		end),
	},
}

return config
