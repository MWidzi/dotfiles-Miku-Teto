--------------------------------------------------------------------------------
-- HATSUNE MIKU & KASANE TETO (初音ミク & 重音テト) THEMED HYPRLAND ANIMATIONS
--
-- Inspired by upbeat synth-pop rhythm, Teto's playful twin-drill bounce,
-- Miku's silky cybernetic digital flow, and crisp EDM beat-drops.
-- Tuned for scrolling layout column glides, bouncy popins, and snappy dismissals.
--------------------------------------------------------------------------------

-- Custom Bézier Curves
-- 1. twinDrill: Teto's energetic chimera drill bounce - snappy attack with a lively ~15% spring overshoot
hl.curve("twinDrill",    { type = "bezier", points = { {0.18, 1.15}, {0.30, 1.02} } })

-- 2. synthWave: Miku's sleek digital flow - buttery smooth ease-out with zero overshoot for workspaces & scrolling columns
hl.curve("synthWave",    { type = "bezier", points = { {0.22, 1.00}, {0.36, 1.00} } })

-- 3. mesmerizer: Hypnotic, crisp pop with a tight micro-bounce for floating dialogs & menus
hl.curve("mesmerizer",   { type = "bezier", points = { {0.12, 1.12}, {0.24, 1.00} } })

-- 4. drillCut: Sharp, instantaneous closure so dismissals never linger or slow you down
hl.curve("drillCut",     { type = "bezier", points = { {0.20, 0.00}, {0.05, 1.00} } })

-- 5. vocalPulse: Atmospheric synth fade for smooth opacity, shadow, and dimming transitions
hl.curve("vocalPulse",   { type = "bezier", points = { {0.25, 0.10}, {0.25, 1.00} } })

-- Compatibility / Standard Curves
hl.curve("linear",       { type = "bezier", points = { {0.00, 0.00}, {1.00, 1.00} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.50, 0.50}, {0.75, 1.00} } })
hl.curve("quick",        { type = "bezier", points = { {0.15, 0.00}, {0.10, 1.00} } })
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1.00}, {0.32, 1.00} } })

--------------------------------------------------------------------------------
-- Animation Tree
--------------------------------------------------------------------------------

-- Global base
hl.animation({ leaf = "global", enabled = true, speed = 3.8, bezier = "synthWave" })

-- Windows (Teto's drill-spring launch on open, razor-sharp drillCut on close, silky column move)
hl.animation({ leaf = "windows",     enabled = true, speed = 3.8, bezier = "synthWave" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 3.4, bezier = "twinDrill", style = "popin 82%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2.0, bezier = "drillCut",  style = "popin 88%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.8, bezier = "synthWave" })

-- Fading (Soft, dynamic digital synth transitions)
hl.animation({ leaf = "fade",        enabled = true, speed = 2.8, bezier = "vocalPulse" })
hl.animation({ leaf = "fadeIn",      enabled = true, speed = 2.4, bezier = "vocalPulse" })
hl.animation({ leaf = "fadeOut",     enabled = true, speed = 1.8, bezier = "drillCut" })
hl.animation({ leaf = "fadeSwitch",  enabled = true, speed = 2.6, bezier = "vocalPulse" })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 2.8, bezier = "vocalPulse" })
hl.animation({ leaf = "fadeShadow",  enabled = true, speed = 3.0, bezier = "vocalPulse" })

-- Layers (Rofi, SwayNC, Waybar, popups)
hl.animation({ leaf = "layers",        enabled = true, speed = 3.4, bezier = "synthWave" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 3.0, bezier = "mesmerizer", style = "popin 85%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.8, bezier = "drillCut",   style = "popin 85%" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 2.4, bezier = "vocalPulse" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.8, bezier = "drillCut" })

-- Workspaces (Sleek cybernetic slidefade transitions)
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3.6, bezier = "synthWave", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 3.6, bezier = "synthWave", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.6, bezier = "synthWave", style = "slidefade 20%" })

-- Special Workspaces (Pyprland scratchpads: terminal, btop, bluetooth)
hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 3.2, bezier = "synthWave", style = "slidefadevert 20%" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 3.2, bezier = "twinDrill", style = "slidefadevert 20%" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2.0, bezier = "drillCut",  style = "slidefadevert 20%" })

-- Borders & Zoom (Dynamic gradient rotation & zoom)
hl.animation({ leaf = "border",      enabled = true, speed = 3.2,  bezier = "synthWave" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 10.0, bezier = "linear" })
hl.animation({ leaf = "zoomFactor",  enabled = true, speed = 3.5,  bezier = "synthWave" })

