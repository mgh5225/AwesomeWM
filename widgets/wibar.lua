local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local menu = require("widgets.menu")


Mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
    menu = menu.mymainmenu })

-- Keyboard map indicator and switcher
local keyboard = require("widgets.keyboard")

-- Create a textclock widget
Mytextclock = wibox.widget.textclock()

return function(s)
    awful.wibar {
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                Mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                keyboard.widget,
                wibox.widget.systray(),
                Mytextclock,
                s.mylayoutbox,
            },
        }
    }
end
