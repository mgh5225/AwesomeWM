local awful = require("awful")
local wibox = require("wibox")

local mywibar = require("widgets.wibar")

-- {{{ Wibar

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create the wibox
    s.mywibox = mywibar(s)
end)

-- }}}
