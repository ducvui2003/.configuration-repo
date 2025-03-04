local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local theme = "Catppuccin Macchiato"

-- Basic configuration
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.color_scheme = theme
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 18

-- Transparency & padding
config.window_background_opacity = 1
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Background Image Config
local user_home = os.getenv("HOME")
local background_folder = user_home .. "/.config/bg"
local background_default = background_folder .. "/zero2.png"
config.window_background_image = background_default

-- HSB for images
config.window_background_image_hsb = {
	hue = 1.0,
	saturation = 0.9,
	brightness = 0.1,
}

-- Function to pick a random background image
local function pick_random_background(folder)
	local handle = io.popen('ls "' .. folder .. '"') -- Won't work on Windows
	local files = handle and handle:read("*a") or ""
	if handle then handle:close() end

	local images = {}
	for file in string.gmatch(files, "[^\n]+") do
		table.insert(images, folder .. "/" .. file)
	end

	if #images > 0 then
		return images[math.random(#images)]
	else
		return nil
	end
end

-- Toggle Background Image State
local use_bg_image = true -- Start with background image enabled

wezterm.on("toggle-bg-image", function(window, pane)
	local overrides = window:get_config_overrides() or {}

	if use_bg_image then
		-- Remove the background image and apply the theme's default background
		overrides.window_background_image = "" -- Ensures no image is used
		overrides.color_scheme = "Catppuccin Macchiato" -- Reapply theme background
		use_bg_image = false
		config.window_background_opacity = 1
	else
		-- Restore the background image
		overrides.window_background_image = background_default
		use_bg_image = true
		config.window_background_opacity = 0.75
	end

	window:set_config_overrides(overrides)
end)

-- Set a random background image on window creation
wezterm.on("window-created", function(window)
	local new_background = pick_random_background(background_folder)
	if new_background then
		background_default = new_background
		window:set_config_overrides({ window_background_image = new_background })
		wezterm.log_info("New bg: " .. new_background)
	else
		wezterm.log_error("Could not find bg image")
	end
end)

-- Keybindings
config.keys = {
	-- Reload configuration
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},

	-- Toggle background image on/off
	{
		key = "i",
		mods = "CTRL|SHIFT",
		action = wezterm.action.EmitEvent("toggle-bg-image"),
	},

	-- Pick a new random background
	{
		key = "B",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local new_background = pick_random_background(background_folder)
			if new_background then
				window:set_config_overrides({ window_background_image = new_background })
				wezterm.log_info("New bg: " .. new_background)
			else
				wezterm.log_error("Could not find bg image")
			end
		end),
	},
}

return config
