local spec = {
    "ficcdaf/ashen.nvim",
    tag = "*",
    lazy = false,
    priority = 1000,
    opts = {
        colors = {
            red_flame = "#c24b57",
            red_glowing = "#b8586f",
            red_ember = "#923852",

            orange_glow = "#d496a5",
            orange_blaze = "#c76e82",
            orange_smolder = "#b58872",
            orange_golden = "#a88554",

            red_kindling = "#BD4C4C",
            red_burnt_crimson = "#A84848",
            red_brick = "#853D3D",
            red_deep_ember = "#7A2E2E",
            red_ashen = "#6F2929",

            blue = "#1184a3",
            blue_dark = "#358fa2",
            green_light = "#5db0c2",
            green = "#439fb5",

            background = "#131229",
            g_0 = "#c8c2d6",
            g_1 = "#c8c2d6",
            g_2 = "#c8c2d6",
            g_3 = "#aba2c0",
            g_4 = "#988fae",
            g_5 = "#887d9f",
            g_6 = "#6d6288",
            g_7 = "#4d426d",
            g_8 = "#3a3356",
            g_9 = "#2e294e",
            g_10 = "#1f1e38",
            g_11 = "#18172d",
            g_12 = "#0e0d1c",
        },
    },
}

spec.config = function(_, opts)
    opts = opts or spec.opts
    require("ashen").setup(opts)

    _G.lualine_theme = {
        normal = {
            a = { fg = "#131229", bg = "#1184a3", gui = "bold" },
            b = { fg = "#c8c2d6", bg = "#1f1e38" },
            c = { fg = "#988fae", bg = "#18172d" },
        },
        insert = {
            a = { fg = "#131229", bg = "#5db0c2", gui = "bold" },
            b = { fg = "#c8c2d6", bg = "#1f1e38" },
            c = { fg = "#988fae", bg = "#18172d" },
        },
        visual = {
            a = { fg = "#131229", bg = "#b8586f", gui = "bold" },
            b = { fg = "#c8c2d6", bg = "#1f1e38" },
            c = { fg = "#988fae", bg = "#18172d" },
        },
        replace = {
            a = { fg = "#131229", bg = "#c24b57", gui = "bold" },
            b = { fg = "#c8c2d6", bg = "#1f1e38" },
            c = { fg = "#988fae", bg = "#18172d" },
        },
        command = {
            a = { fg = "#131229", bg = "#a88554", gui = "bold" },
            b = { fg = "#c8c2d6", bg = "#1f1e38" },
            c = { fg = "#988fae", bg = "#18172d" },
        },
        inactive = {
            a = { fg = "#6d6288", bg = "#18172d", gui = "bold" },
            b = { fg = "#6d6288", bg = "#18172d" },
            c = { fg = "#4d426d", bg = "#131229" },
        },
    }

    if _G.theme == "ashen" then
        vim.cmd.colorscheme "ashen"
    end
end

return spec
