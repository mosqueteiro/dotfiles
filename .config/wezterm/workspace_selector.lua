--------------------------------------------------------------------------------
-- Workspace
--------------------------------------------------------------------------------
local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

-- TODO: store last workspace and assign `LEADER L` to switch to last workspace

--- Workspace selector callback function. Use with as an action.
---@param window wezterm.Window The current window
---@param pane wezterm.Pane The current pane
function module.workspace_selector_callback(window, pane)
	local choices = {}

	-- Add active workspaces
	for _, ws in ipairs(wezterm.mux.get_workspace_names()) do
		table.insert(choices, { label = " " .. ws, id = "workspace:" .. ws })
	end

	-- Add zoxide paths
	local success, stdout, stderr =
		wezterm.run_child_process({ wezterm.home_dir .. "/.pixi/bin/zoxide", "query", "--list" })
	if success then
		for path in stdout:gmatch("[^\r\n]+") do
			local label = path:gsub(wezterm.home_dir, "~")
			table.insert(choices, { label = " " .. label, id = "path:" .. path })
		end
	elseif stderr then
		wezterm.log_error("zoxide error: " .. stderr)
	end

	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
				if not id and not label then
					wezterm.log_info("cancelled")
				else
					wezterm.log_info("id = " .. id)
					wezterm.log_info("label = " .. label)

					local workspace_type, identifier = id:match("([^:]+):(.+)")
					local workspace_name

					if workspace_type == "workspace" then
						workspace_name = identifier
					elseif workspace_type == "path" then
						workspace_name = identifier:match("([^/]+)$")
					else
						wezterm.log_error("Unknown ID format: " .. id)
						return
					end

					inner_window:perform_action(
						act.SwitchToWorkspace({
							name = workspace_name,
							spawn = { cwd = identifier },
						}),
						inner_pane
					)
				end
			end),
			title = "Select Workspace",
			choices = choices,
			fuzzy = true,
			fuzzy_description = " ",
		}),
		pane
	)
end

return module
