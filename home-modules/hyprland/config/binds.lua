---@module 'hl'

local defs = require("definitions")

local mod = defs.mod
local modShift = defs.modShift

for _, app in ipairs(defs.apps) do
	hl.bind(mod(app.key), hl.dsp.exec_cmd(app.cmd))
end

for _, d in ipairs(defs.focusDirections) do
	hl.bind(mod(d.key), hl.dsp.focus({ direction = d.direction }))
end

for _, m in ipairs(defs.mediaBinds) do
	hl.bind(m.key, hl.dsp.exec_cmd(m.cmd), { locked = true })
end

hl.bind(mod("Space"), hl.dsp.layout("swapwithmaster")) -- Just for master layout

-- Window management
hl.bind(mod("Q"), hl.dsp.window.close())
hl.bind(mod("S"), hl.dsp.window.float())
hl.bind(mod("F"), hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(modShift("F"), hl.dsp.window.float({ action = "toggle" }))
hl.bind("F11", hl.dsp.window.fullscreen())

-- Move between monitors
hl.bind(modShift("K"), hl.dsp.window.move({ monitor = "+1" }))
hl.bind(modShift("J"), hl.dsp.window.move({ monitor = "-1" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mod("N"), hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod("P"), hl.dsp.focus({ workspace = "r-1" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(modShift("N"), hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(modShift("P"), hl.dsp.window.move({ workspace = "r-1" }))

for i = 1, 9 do
	hl.bind(mod(tostring(i)), hl.dsp.focus({ workspace = i }))
	hl.bind(modShift(tostring(i)), hl.dsp.window.move({ workspace = i }))
end

-- 0 goes back to the previous workspace; SHIFT + 0 sends the window to workspace 10
hl.bind(mod("0"), hl.dsp.focus({ workspace = "prev" }))
hl.bind(modShift("0"), hl.dsp.window.move({ workspace = 10 }))

hl.bind(mod("Tab"), hl.dsp.layout("cyclenext"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot --clipboard-only -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(mod("mouse:273"), hl.dsp.window.resize(), { mouse = true })
