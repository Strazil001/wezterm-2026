local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- Creates my personal workspace
local function spawn_personal_workspace(window, pane)
	local existing = false
	for _, name in ipairs(mux.get_workspace_names()) do
		if name == "Personal" then
			existing = true
			break
		end
	end

	if existing then
		window:perform_action(act.SwitchToWorkspace({ name = "Personal" }), pane)
		return
	end

	local tab, pane1, mux_window = mux.spawn_window({
		workspace = "Personal",
		cwd = "F:/S/notes/",
	})
	tab:set_title("Notes")
	pane1:send_text("nvim\r")

	local tab2, pane2 = mux_window:spawn_tab({
		cwd = "F:/S/projects/",
	})
	tab2:set_title("Nvim")

	window:perform_action(act.SwitchToWorkspace({ name = "Personal" }), pane)
end

-- Run on cold startup
-- wezterm.on("gui-startup", function(cmd)
-- 	spawn_personal_workspace()
-- end)

local config = wezterm.config_builder()
-- Powershell Core as default
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
config.default_cwd = wezterm.home_dir
config.initial_cols = 140
config.initial_rows = 40

config.font_size = 11
config.color_scheme = "OneHalfDark"

-- UI
config.window_decorations = "RESIZE"
config.custom_block_glyphs = true

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
	ansi = {
		"#282c34", -- color0 (black)
		"#e06c75", -- color1 (red)
		"#98c379", -- color2 (green)
		"#e5c07b", -- color3 (yellow)
		"#61afef", -- color4 (blue)
		"#c678dd", -- color5 (magenta)
		"#56b6c2", -- color6 (cyan)
		"#abb2bf", -- color7 (white)
	},
	brights = {
		"#5c6370", -- color8 (bright black / gray - often used for parameters/comments)
		"#e06c75",
		"#98c379",
		"#e5c07b",
		"#61afef",
		"#c678dd",
		"#56b6c2",
		"#ffffff",
	},
	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#e5c07b",
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "#282c34",
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#282C34",

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#282C34",
			-- The color of the text for the tab
			fg_color = "#c0c0c0",

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Bold",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "Single",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = true,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#282C34",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some winernate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#282C34",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#282C34",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some winernate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}
-- Keybindings
config.keys = {
	-- Turn off the default Shift Ctrl K
	{
		key = "k",
		mods = "SHIFT|CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "n",
		mods = "ALT",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "1",
		mods = "ALT",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "2",
		mods = "ALT",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "3",
		mods = "ALT",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "4",
		mods = "ALT",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "5",
		mods = "ALT",
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = "6",
		mods = "ALT",
		action = wezterm.action.ActivateTab(5),
	},
	{
		key = "7",
		mods = "ALT",
		action = wezterm.action.ActivateTab(6),
	},
	{
		key = "8",
		mods = "ALT",
		action = wezterm.action.ActivateTab(7),
	},
	{
		key = "9",
		mods = "ALT",
		action = wezterm.action.ActivateTab(-1),
	},
	{
		key = "[",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "u",
		mods = "ALT",
		action = wezterm.action.ScrollByPage(-1),
	},
	{
		key = "d",
		mods = "ALT",
		action = wezterm.action.ScrollByPage(1),
	},
	{
		key = "r",
		mods = "ALT",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action.ClearScrollback("ScrollbackOnly"),
	},
	{
		key = "f",
		mods = "ALT",
		action = wezterm.action.Search("CurrentSelectionOrEmptyString"),
	},
	{
		key = "x",
		mods = "ALT",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "-",
		mods = "ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "/",
		mods = "ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "l",
		mods = "SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
	},
	{
		key = "k",
		mods = "SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "j",
		mods = "SHIFT|ALT",
		action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
	},
	-- Rename tabs
	{
		key = "R",
		mods = "SHIFT|ALT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Pull up my personal workspace
	{
		key = "P",
		mods = "SHIFT|ALT",
		action = wezterm.action_callback(function(window, pane)
			spawn_personal_workspace(window, pane)
		end),
	},
	{
		key = "z",
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},
}

-- Finally, return the configuration to wezterm:
return config
