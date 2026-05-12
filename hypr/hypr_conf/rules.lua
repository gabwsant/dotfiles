local suppressMaximizeRule = hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

-- Thunar
hl.window_rule({
  float = true,
  match = {
    class = "thunar",
    title = "File Operation Progress"
  }
})

hl.window_rule({
  float = true,
  center = true,
  match = {
    class = "thunar",
    title = "Confirm to replace files"
  }
})

-- Network manager
hl.window_rule({
  float = true,
  center = true,
  size = { 600, 500 },
  pin = true,
  animation = "slide",
  match = {
    class = "nm-connection-editor"
  }
})

-- Steam fixes
hl.window_rule({
  float = true,
  match = {
    class = "^(steam)$",
    title = "^(Friends List)$"
  }
})

hl.window_rule({
  float = true,
  match = {
    class = "^(steam)$",
    title = "^(Steam - News)$"
  }
})

hl.window_rule({
  center = true,
  match = {
    class = "^(steam)$",
    title = "^(Setup)$"
  }
})

-- Steam games
hl.window_rule({
  immediate = true,
  match = {
    class = "^(steam_app_.*)$"
  }
})

-- Gamescope
hl.window_rule({
  immediate = true,
  fullscreen = true,
  match = {
    class = "^(gamescope)$"
  }
})

-- ======================================================
-- Workspaces Rules
-- ======================================================

for i = 1, 5 do
  hl.workspace_rule({
    workspace = i,
    monitor = "eDP-1"
  })
end

for i = 6, 10 do
  hl.workspace_rule({
    workspace = i,
    monitor = "DP-1"
  })
end