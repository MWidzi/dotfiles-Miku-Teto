-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("playerctld daemon &")
    hl.exec_cmd("swaync")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar  & udiskie")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img ~/.config/wallpapers/teto_miku_wallpaper_1.webp --transition-fps 255 --transition-step 5")
    hl.exec_cmd("awww img ~/.config/wallpapers/teto_miku_wallpaper_2.png  --transition-fps 255 --transition-step 5 -o DP-3")
    hl.exec_cmd("awww img ~/.config/wallpapers/teto_miku_wallpaper_3.webp --transition-fps 255 --transition-step 5 -o HDMI-A-1")
    hl.exec_cmd("hyprctl dispatch workspace 1")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'  - GTK3 apps")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' - GTK4 apps")
    hl.exec_cmd("pypr & hyprsunset & hypridle")
    hl.exec_cmd("systemctl --user start mpd")
    hl.exec_cmd("sleep 3 && mpd-mpris")
end)
