-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local beautiful = require("beautiful")

require("awful.autofocus")



-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/default.lua")

-- This is used later as the default terminal and editor to run.
Terminal = "kitty"
Editor = os.getenv("EDITOR") or "nvim"
Editor_cmd = Terminal .. " -e " .. Editor
FileManager = "thunar"

Rofi_luancher = os.getenv("HOME") .. "/.config/rofi/launchers/type-6/launcher.sh"
Rofi_powermenu = os.getenv("HOME") .. "/.config/rofi/powermenu/type-6/powermenu.sh"
Rofi_clipboard = "rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'"

Screenshot_selection = "scrot -s $HOME/Pictures/%Y-%m-%d_%H%M%S.png"
Screenshot_whole = "scrot $HOME/Pictures/%Y-%m-%d_%H%M%S.png"
Screenshot_selection_clipboard = "scrot -s /tmp/%Y-%m-%d_%H%M%S.png -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"
Screenshot_whole_clipboard = "scrot /tmp/%Y-%m-%d_%H%M%S.png -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
Modkey = "Mod4"
-- }}}

require("widgets")
require("config")
