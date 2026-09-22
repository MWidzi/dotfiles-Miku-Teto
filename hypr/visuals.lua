require("colors")

hl.config({
    dwindle = {
        force_split = 0,
        smart_split = true,
    },

    scrolling = {
        column_width = 0.333,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        font_family = "Hack Nerd Font",
    },

    ---------------------
    --- LOOK AND FEEL ---
    ---------------------

    general = {
        gaps_in                       = 5,
        gaps_out                      = { bottom = 10, left = 5, top = 10, right = 5 },

        border_size                   = 2,

        ["col.active_border"]         = border_active,
        ["col.inactive_border"]       = border_inactive,
        ["col.nogroup_border_active"] = border_active,

        layout                        = "scrolling",

        resize_on_border              = true,
        extend_border_grab_area       = 30,
        hover_icon_on_border          = true,

        allow_tearing                 = false,
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,

        active_opacity = 0.87,
        inactive_opacity = 0.7,
        fullscreen_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.1,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            noise = 0.0200,
            contrast = 1,
            xray = true,

            vibrancy = 0.1796,
            vibrancy_darkness = 1,

            new_optimizations = true,

            popups = true,
            popups_ignorealpha = 0.2,
        },
    },
})
