hl.monitor({
  output = "",
  mode = "1920x1080@60.00100",
  position = "0x0",
  scale = 1.2,
})

local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local keybinds = "rofi -dmenu -i -p \"Keybinds\" < ~/.config/hypr/keybinds.txt"
local browser = "brave"

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl eval 'hl.config({ xwayland = { force_zero_scaling = true } })'")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("swayosd-server &")
end)

hl.env("XCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_SIZE", "18")

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 0,
    border_size = 2,
    col = {
      active_border = "#268bd2",
      inactive_border = "#002b36",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "scrolling",
  },
  decoration = {
    rounding = 0,
    active_opacity = 1.0,
    inactive_opacity = 0.7,
    shadow = { enabled = false, },
    blur = {
      enabled = true,
      size = 4,
      passes = 0,
      vibrancy = 0.2,
    },
  },
  animations = {
    enabled = true,
  },
})

hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
  master = {
    new_status = "master",
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

hl.config({
  misc = {
    force_default_wallpaper = 1, 
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
})

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 1.0,
    touchpad = {
      natural_scroll = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = 1.0,
})

local mainMod = "SUPER"

hl.bind("Print", hl.dsp.exec_cmd("grim $HOME/pictures/shot_$(date +%s).png"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" $HOME/pictures/shot_$(date +%s).png"))

hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(keybinds))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("shutdown now"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
  mainMod .. " + SHIFT + E", 
  hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
  )
)
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + O", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(
  mainMod .. " + CTRL + up", 
  hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true }
)
hl.bind(
  mainMod .. " + CTRL + down", 
  hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true }
)
hl.bind(
  mainMod .. " + CTRL + right", 
  hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true }
)
hl.bind(
  mainMod .. " + CTRL + left", 
  hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true }
)

hl.bind("F1", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))
hl.bind("F2", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))
hl.bind("F3", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))
hl.bind("F4", hl.dsp.exec_cmd("swayosd-client --brightness lower"))
hl.bind("F5", hl.dsp.exec_cmd("swayosd-client --brightness raise"))
hl.bind("F9", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"))

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local suppressMaximizeRule = hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.bind(mainMod .. "+ SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move = "20 monitor_h-120",
  float = true,
})

