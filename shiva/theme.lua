-------------------------------
--  "Shiva" awesome theme  --
-------------------------------

local themes_path = require("gears.filesystem").get_themes_dir()
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/shiva"
theme.wallpaper = theme.confdir .. "/ShivaPython.jpg"
-- }}}

-- {{{ Styles
--theme.font      = "monospace"
--theme.font      = "Bitstream Vera Sans Mono"
--theme.font      = "DejaVu Sans Mono 13"
theme.font      = "Ubuntu Mono 12"

-- {{{ Colors
theme.fg_normal  = "#898445"
theme.fg_focus   = "#a18c4f"
theme.fg_urgent  = "#ea6868"
theme.bg_normal  = "#171F48AA"
theme.bg_focus   = "#17204393"
theme.bg_urgent  = "#2E497B99"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(5)	--option 1
theme.border_width  = dpi(1)
theme.border_normal = "#313131"
theme.border_focus  = "#141f37"
theme.border_marked = "#d4af37"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#ad8109"
theme.titlebar_bg_normal = "#574103"
-- }}}


-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(22)
theme.menu_width  = dpi(142)
-- theme.menu_submenu_width = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme.confdir .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = theme.confdir .. "/taglist/squarez.png"
theme.taglist_fg_focus    = "#8C5A13"
theme.taglist_fg_occupied = "#c29721"
theme.taglist_fg_urgent   = "#ED7572"
theme.taglist_fg_empty    = "#c29721"
theme.taglist_spacing     = 5
theme.taglist_font        = "Ubuntu Mono 22"
-- }}}

-- {{{ Misc
theme.awesome_icon           = theme.confdir .. "/trident.jpg"
-- theme.menu_submenu_icon      = theme.confdir .. "/default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme.confdir .. "/layouts/tile.png"
theme.layout_tileleft   = theme.confdir .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/layouts/fairv.png"
theme.layout_fairh      = theme.confdir .. "/layouts/fairh.png"
theme.layout_spiral     = theme.confdir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/layouts/dwindle.png"
theme.layout_max        = theme.confdir .. "/layouts/max.png"
theme.layout_magnifier  = theme.confdir .. "/layouts/magnifier.png"
theme.layout_floating   = theme.confdir .. "/layouts/floating.png"
theme.layout_centerwork   = theme.confdir .. "/layouts/centered.png"
-- }}}

return theme

