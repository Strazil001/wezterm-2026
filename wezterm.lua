local wezterm = require("wezterm")
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
local keymaps = require("keymaps")

local config = wezterm.config_builder()
-- Optional: adds default keybindings and plugin configuration
sessions.apply_to_config(config, {
	-- Auto-save interval in seconds (default: 30)
	--auto_save_interval_s = 30,
	-- Warn when git branches changed on restore (default: true)
	git_branch_warn = true,
})

-- keymaps
keymaps.apply_to_config(config)

-- Powershell Core as default
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
config.default_cwd = wezterm.home_dir
config.initial_cols = 140
config.initial_rows = 40

config.font_size = 11
config.color_scheme = "rose-pine"

-- UI
config.window_decorations = "RESIZE"
config.custom_block_glyphs = true

-- Custom styles for the Command Palette to match One Dark
config.command_palette_bg_color = "#282c34" -- One Dark background color
config.command_palette_fg_color = "#abb2bf" -- One Dark foreground color

-- Optional extra customization to match the launcher look:
config.command_palette_rows = 12 -- Controls the maximum heights/visible rows
config.command_palette_font_size = 11.0 -- Matches text scale to your preferences

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	separator = {
		space = 1,
		left_icon = "",
		right_icon = "",
	},
	modules = {
		username = {
			enabled = false,
		},
		hostname = {
			enabled = false,
		},
	},
})

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 10.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#282C34",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#282C34",
}

config.colors = {
	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#c4a7e7",
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "#191724",
}
-- Finally, return the configuration to wezterm:
return config
