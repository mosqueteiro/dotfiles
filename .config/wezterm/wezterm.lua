local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

local workspace_selector = require("workspace_selector")
local which_key = require("which_key")

-- TODO: Keep track of last workspace and assign `LEADER L` to switch to last workspace
-- TODO: Can InputSelector be inverted?
-- TODO: Investigate if there is a way to have a smaller window for Input selector (like command palette)
-- TODO: Fix which-key group assignment
--
-- Skip:
-- TODO: Make a few pre-configured workspaces (e.g. dotfiles, neovim config, home)

--------------------------------------------------------------------------------
-- Visuals settings
--------------------------------------------------------------------------------
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.colors = {
	cursor_bg = "white",
	-- cursor_border = "white",
}
config.font = wezterm.font("DaddyTimeMono Nerd Font")

--- Display workspace name
wezterm.on("update-status", function(window, pane)
	local cws = wezterm.mux.get_active_workspace()
	-- wezterm.log_info("current workspace: " .. cws)
	window:set_left_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = "[" .. cws .. "]" },
	}))
end)

--------------------------------------------------------------------------------
-- Keybindings
--------------------------------------------------------------------------------
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	-- {	-- Not working, yet
	-- 	key = "Space",
	-- 	mods = "LEADER",
	-- 	action = act.ShowLauncherArgs({ flags = "FUZZY|KEY_ASSIGNMENTS", title = "Keys" }),
	-- },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- Navigate Panes
	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	-- Resize Panes
	{ key = "H", mods = "ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "LeftArrow", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "DownArrow", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "UpArrow", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- Tabs
	{ key = "n", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "X", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },
	{ key = "C", mods = "LEADER", action = act.SpawnWindow },

	-- Launcher
	{
		key = "S",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
			title = "launcher",
		}),
	},
	{
		key = "K",
		mods = "LEADER",
		action = wezterm.action_callback(workspace_selector.workspace_selector_callback),
	},
	{
		key = "?",
		mods = "LEADER|SHIFT",
		action = wezterm.action_callback(which_key.which_key_callback),
	},
}

return config
