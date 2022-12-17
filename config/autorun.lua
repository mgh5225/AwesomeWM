local awful = require("awful")
local helpers = require("helpers")

local _types = {
    PS = 1,
    PGREP = 2,
    GREP = 3,
    RUNNING = 4
}
local _run = function(app_name, app_cmd, type)
    if type == _types.RUNNING then
        helpers.run.check_if_running(app_name, nil, function()
            awful.spawn(app_cmd, false)
        end)
    elseif type == _types.PGREP then
        helpers.run.run_once_pgrep(app_cmd)
    elseif type == _types.PS then
        helpers.run.run_once_ps(app_name, app_cmd)
    elseif type == _types.GREP then
        helpers.run.run_once_grep(app_cmd)
    end
end


_run("picom", "picom", _types.RUNNING)
_run("lxpolkit", "lxpolkit", _types.PS)
_run("nm-applet", "nm-applet", _types.PGREP)
_run("polychromatic-tray-applet", "polychromatic-tray-applet", _types.PGREP)
_run("pasystray", "pasystray", _types.PGREP)
_run("playerctld", "playerctld daemon", _types.GREP)
_run("greenclip", "greenclip daemon", _types.GREP)
