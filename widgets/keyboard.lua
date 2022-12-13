local awful = require("awful")
local helpers = require("helpers")
local _keyboard = helpers.keyboard_layout({ type = "tui" })
_keyboard.add_primary_layout("English", "US", "us")
_keyboard.add_primary_layout("Persian", "IR", "ir")
_keyboard.bind()
_keyboard.widget:buttons(
    awful.util.table.join(awful.button({}, 1, function() _keyboard.switch_next() end),
        awful.button({}, 3, function() _keyboard.menu:toggle() end))
)

return _keyboard
