local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local M = {}

-- Run on cold startup
-- wezterm.on("gui-startup", function(cmd)
-- 	spawn_personal_workspace()
-- end)
function M.apply_to_config(config)
	-- Define your leader key if you use one
	config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 1000 }

	-- Define your keybindings
	config.keys = {
		-- Turn off the default Shift Ctrl K
		{
			key = "k",
			mods = "SHIFT|CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "n",
			mods = "LEADER",
			action = wezterm.action.SpawnWindow,
		},
		{
			key = "t",
			mods = "LEADER",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
			}),
		},
		{
			key = "w",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		{
			key = "1",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(0),
		},
		{
			key = "2",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(1),
		},
		{
			key = "3",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(2),
		},
		{
			key = "4",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(3),
		},
		{
			key = "5",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(4),
		},
		{
			key = "6",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(5),
		},
		{
			key = "7",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(6),
		},
		{
			key = "8",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(7),
		},
		{
			key = "9",
			mods = "LEADER",
			action = wezterm.action.ActivateTab(-1),
		},
		{
			key = "i",
			mods = "LEADER",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "o",
			mods = "LEADER",
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
			key = "PageUp",
			mods = "ALT",
			action = wezterm.action.ScrollByPage(-1),
		},
		{
			key = "PageDown",
			mods = "ALT",
			action = wezterm.action.ScrollByPage(1),
		},
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action.ClearScrollback("ScrollbackOnly"),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},
		{
			key = "m",
			mods = "LEADER",
			action = wezterm.action.ShowLauncher,
		},
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action.ActivateCommandPalette,
		},
		{
			key = "g",
			mods = "LEADER",
			action = wezterm.action.Search("CurrentSelectionOrEmptyString"),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "/",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "LeftArrow",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
		},
		{
			key = "RightArrow",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
		},
		{
			key = "UpArrow",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "DownArrow",
			mods = "SHIFT|ALT",
			action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
		},
		-- Sessions
		{
			key = "s",
			mods = "LEADER",
			action = act({ EmitEvent = "save_session" }),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act({ EmitEvent = "load_session" }),
		},
		{
			key = "r",
			mods = "LEADER",
			action = act({ EmitEvent = "restore_session" }),
		},
		{
			key = "d",
			mods = "LEADER",
			action = act({ EmitEvent = "delete_session" }),
		},
		{
			key = "e",
			mods = "LEADER",
			action = act({ EmitEvent = "edit_session" }),
		},
		{
			key = "a",
			mods = "LEADER",
			action = act({ EmitEvent = "toggle_autosave" }),
		},
		{
			key = "f",
			mods = "LEADER",
			action = act({ EmitEvent = "fork_session" }),
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
		-- Rename current workspace
		{
			key = "$",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = "Enter new workspace name",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		-- Prompt for a name to use for a new workspace and switch to it.
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	}

	-- Define separate key tables if needed
	config.key_tables = {
		-- resize_pane = { ... }
	}
end

return M
