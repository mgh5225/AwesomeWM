local awful = require("awful")
local keyboard_layout = require("config.keyboard_layout")
local keyboard = keyboard_layout({ type = "tui" })
keyboard.add_primary_layout("English", "US", "us")
keyboard.add_primary_layout("Persian", "IR", "ir")
keyboard.bind()
keyboard.widget:buttons(
    awful.util.table.join(awful.button({}, 1, function() keyboard.switch_next() end),
        awful.button({}, 3, function() keyboard.menu:toggle() end))
)

return keyboard
