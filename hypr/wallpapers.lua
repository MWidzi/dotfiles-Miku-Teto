------------------
--- WALLPAPERS ---
------------------

local system = require("system")

if system.is_laptop then
    wallp_1 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_1.webp --transition-fps 255 --transition-step 5"
    wallp_2 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_2.png  --transition-fps 255 --transition-step 5"
    wallp_3 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_3.webp --transition-fps 255 --transition-step 5"
    wallp_4 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_4.png  --transition-fps 255 --transition-step 5"
    wallp_5 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_5.jpg  --transition-fps 255 --transition-step 5"
    wallp_6 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_6.jpg  --transition-fps 255 --transition-step 5"
else 
    wallp_1 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_1.webp --transition-fps 255 --transition-step 5 -o DP-1"
    wallp_2 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_2.png  --transition-fps 255 --transition-step 5 -o DP-3"
    wallp_3 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_3.webp --transition-fps 255 --transition-step 5 -o HDMI-A-1"
    wallp_4 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_4.png  --transition-fps 255 --transition-step 5 -o DP-1"
    wallp_5 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_5.jpg  --transition-fps 255 --transition-step 5 -o HDMI-A-1"
    wallp_6 = "awww img ~/.config/wallpapers/teto_miku_wallpaper_6.jpg  --transition-fps 255 --transition-step 5 -o DP-3"
end
