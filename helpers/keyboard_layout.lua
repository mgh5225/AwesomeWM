local awful = require("awful")
local wibox = require("wibox")
local keyboard = {}

-- Function to change current layout to the next available layout
function keyboard.switch_next()
    keyboard.current = keyboard.current % #(keyboard.layouts) + 1
    keyboard.switch(keyboard.layouts[keyboard.current])
end

-- Function to find layout in list and set current index
local function find_current_layout(name)
    for index, layout in ipairs(keyboard.additional_layouts) do
        if layout.name == name then
            return index, layout
        end
    end
    return nil, nil
end

-- Function to change current layout based on the name
function keyboard.switch_by_name(name)
    local index, layout = find_current_layout(name)
    keyboard.switch(layout)
end

-- Function to change layout
function keyboard.switch(layout)
    local index = find_current_layout(layout.name)
    keyboard.current = index

    if client.focus then
        local layout = keyboard.additional_layouts[keyboard.current]
        client.focus.kbd_layout = layout.name
    end

    if keyboard.type == "tui" then
        keyboard.widget:set_text(keyboard.tui_wrap_left .. layout.label .. keyboard.tui_wrap_right)
    else
        keyboard.widget.image = layout.label
    end

    os.execute(keyboard.cmd .. " \"" .. layout.subcmd .. "\"")
end

-- Function to add primary layouts
function keyboard.add_primary_layout(name, label, subcmd)
    local layout = { name = name,
        label  = label,
        subcmd = subcmd };

    table.insert(keyboard.layouts, layout)
    table.insert(keyboard.additional_layouts, layout)
end

-- Function to add additional layouts
function keyboard.add_additional_layout(name, label, subcmd)
    local layout = { name = name,
        label  = label,
        subcmd = subcmd };

    table.insert(keyboard.additional_layouts, layout)
end

-- Bind function. Applies all settings to the widget
function keyboard.bind()
    -- Menu for choose additional keyboard layouts
    local menu_items = {}

    for i = 1, #keyboard.additional_layouts do
        local layout = keyboard.additional_layouts[i]
        table.insert(menu_items, {
            layout.name,
            function() keyboard.switch(layout) end,
            -- show a fancy image in gui mode
            keyboard.type == "gui" and layout.label or nil
        })
    end

    keyboard.menu = awful.menu({ items = menu_items })

    if keyboard.type == "tui" then
        keyboard.widget = wibox.widget.textbox()
    else
        keyboard.widget = wibox.widget.imagebox()
    end

    if keyboard.default_layout_index > #keyboard.layouts then
        keyboard.default_layout_index = 1;
        keyboard.current = keyboard.default_layout_index;
    end

    if keyboard.remember_layout then
        client.connect_signal("focus", Kbd_client_update)
    end

    local current_layout = keyboard.layouts[keyboard.current]
    if current_layout then
        keyboard.switch(current_layout)
    end
end

-- Callback function for set remembering layout for windows
function Kbd_client_update(c)
    if not c then
        return
    end

    if not c.kbd_layout then
        c.kbd_layout = keyboard.layouts[keyboard.default_layout_index].name
    end

    keyboard.switch_by_name(c.kbd_layout)
end

-- Factory function. Creates the widget.
local function factory(args)
    local args                    = args or {}
    keyboard.cmd                  = args.cmd or "setxkbmap"
    keyboard.layouts              = args.layouts or {}
    keyboard.additional_layouts   = args.additional_layouts or {}
    keyboard.default_layout_index = args.default_layout_index or 1
    keyboard.current              = args.current or keyboard.default_layout_index
    keyboard.menu                 = nil
    keyboard.type                 = args.type or "tui"
    keyboard.tui_wrap_left        = args.tui_wrap_left or " "
    keyboard.tui_wrap_right       = args.tui_wrap_right or " "
    keyboard.remember_layout      = args.remember_layout or false

    for i = 1, #keyboard.layouts do
        table.insert(keyboard.additional_layouts, keyboard.layouts[i])
    end

    return keyboard
end

setmetatable(keyboard, { __call = function(_, ...) return factory(...) end })

return keyboard
