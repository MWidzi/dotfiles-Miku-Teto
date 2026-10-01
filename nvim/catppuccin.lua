return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup {
            flavour = 'mocha',
            transparent_background = false,
            show_end_of_buffer = false,
            term_colors = true,
            dim_inactive = {
                enabled = false,
                shade = 'dark',
                percentage = 0.15,
            },
            styles = {
                comments = { 'italic' },
                conditionals = { 'italic' },
                loops = {},
                functions = {},
                keywords = { 'bold' },
                strings = {},
                variables = {},
                numbers = {},
                booleans = { 'bold' },
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {
                mocha = {
                    -- Base / Backgrounds (from hypr/colors.lua and waybar)
                    base = '#131229',
                    mantle = '#18172d',
                    crust = '#0e0d1c',

                    -- Surfaces / Highlights (subtle, non-distracting)
                    surface0 = '#1f1e38', -- cursorline
                    surface1 = '#2e294e', -- visual selection (kitty selection_background)
                    surface2 = '#3a3356', -- search highlights / active borders

                    -- Overlays & Text hierarchy (muted lavender-greys)
                    overlay0 = '#4d426d', -- inactive borders / indent guides
                    overlay1 = '#6d6288', -- comments (soft, low-contrast, legible)
                    overlay2 = '#887d9f', -- delimiters / punctuation
                    subtext0 = '#988fae', -- secondary parameters
                    subtext1 = '#aba2c0', -- secondary text / identifiers
                    text = '#c8c2d6', -- main code text (calm, warm lavender-white, zero glare)

                    -- Miku Theme Accents (softened teals, cyans, blues)
                    teal = '#1184a3', -- main1 (deep cyan-teal, signature Miku)
                    sapphire = '#358fa2', -- muted cyan-accent (methods / secondary calls)
                    blue = '#439fb5', -- Miku cyan-blue (kitty color6 - functions)
                    sky = '#5db0c2', -- calm sky blue (operators / tags)

                    -- Teto Theme Accents (softened roses, maroons, reds)
                    pink = '#b8586f', -- Teto dusty rose (strings - legible, warm, no eye strain)
                    maroon = '#923852', -- main2 (deep Teto berry from hypr/colors.lua)
                    red = '#c24b57', -- soft crimson (urgent2 / errors / booleans)
                    flamingo = '#c76e82', -- Teto soft rose (regex / special characters)
                    rosewater = '#d496a5', -- muted pastel rose

                    -- Muted Syntax Contrast Accents (darkened & toned down to remove brightness/glare)
                    peach = '#b58872', -- muted terracotta / warm sand (numbers / constants)
                    yellow = '#a88554', -- deep warm amber / antique ochre (types / classes - used sparingly, NOT bright)
                    green = '#5db0c2', -- Miku cyan (replaces green)
                    mauve = '#826c9f', -- dusty amethyst / slate violet (keywords / control flow - calm, dark)
                    lavender = '#7b8da6', -- muted slate blue (properties / members)
                },
            },
            highlight_overrides = {
                mocha = function(c)
                    return {
                        -- Base UI
                        Normal = { bg = c.base, fg = c.text },
                        NormalFloat = { bg = c.mantle, fg = c.text },
                        FloatBorder = { bg = c.mantle, fg = c.overlay0 },
                        CursorLine = { bg = c.surface0 },
                        CursorLineNr = { fg = c.teal, bold = true },
                        LineNr = { fg = c.overlay0 },
                        Visual = { bg = c.surface1 },
                        Search = { bg = c.surface2, fg = c.sky },
                        IncSearch = { bg = c.teal, fg = c.crust, bold = true },
                        ColorColumn = { bg = c.surface0 },
                        WinSeparator = { fg = c.overlay0 },

                        -- Comments (calm and unobtrusive)
                        Comment = { fg = c.overlay1, italic = true },
                        ['@comment'] = { fg = c.overlay1, italic = true },

                        -- Keywords (signature Miku teal for standard keywords, muted slate-violet for conditionals)
                        Keyword = { fg = c.teal, bold = true },
                        ['@keyword'] = { fg = c.teal, bold = true },
                        ['@keyword.function'] = { fg = c.teal, bold = true },
                        ['@keyword.conditional'] = { fg = c.mauve, italic = true },
                        ['@keyword.repeat'] = { fg = c.mauve, italic = true },
                        ['@keyword.return'] = { fg = c.maroon, bold = true },
                        ['@keyword.operator'] = { fg = c.sky },

                        -- Functions & Methods (Miku cyan & blue)
                        Function = { fg = c.blue },
                        ['@function'] = { fg = c.blue },
                        ['@function.builtin'] = { fg = c.sapphire },
                        ['@function.call'] = { fg = c.blue },
                        ['@function.method'] = { fg = c.sapphire },
                        ['@function.method.call'] = { fg = c.sapphire },
                        ['@constructor'] = { fg = c.blue },

                        -- Strings (Teto warm dusty rose - pleasant and low-glare)
                        String = { fg = c.pink },
                        ['@string'] = { fg = c.pink },
                        ['@string.escape'] = { fg = c.flamingo, bold = true },
                        ['@string.special'] = { fg = c.flamingo },

                        -- Literals & Constants
                        Character = { fg = c.pink },
                        Number = { fg = c.peach },
                        ['@number'] = { fg = c.peach },
                        ['@number.float'] = { fg = c.peach },
                        Boolean = { fg = c.maroon, bold = true },
                        ['@boolean'] = { fg = c.maroon, bold = true },
                        Constant = { fg = c.peach },
                        ['@constant'] = { fg = c.peach },
                        ['@constant.builtin'] = { fg = c.maroon },

                        -- Types & Classes (Muted warm amber/ochre - non-bold, dark and sparingly used)
                        Type = { fg = c.yellow },
                        ['@type'] = { fg = c.yellow },
                        ['@type.builtin'] = { fg = c.yellow },
                        ['@type.definition'] = { fg = c.yellow },

                        -- Variables & Identifiers (soft readable lavender-white)
                        Identifier = { fg = c.text },
                        ['@variable'] = { fg = c.text },
                        ['@variable.builtin'] = { fg = c.maroon },
                        ['@variable.parameter'] = { fg = c.subtext1 },
                        ['@variable.member'] = { fg = c.lavender },
                        ['@property'] = { fg = c.lavender },

                        -- Operators & Delimiters
                        Operator = { fg = c.sky },
                        ['@operator'] = { fg = c.sky },
                        Delimiter = { fg = c.overlay2 },
                        ['@punctuation.delimiter'] = { fg = c.overlay2 },
                        ['@punctuation.bracket'] = { fg = c.subtext0 },

                        -- Completion menu
                        Pmenu = { bg = c.mantle, fg = c.text },
                        PmenuSel = { bg = c.surface1, fg = c.sky, bold = true },
                        PmenuBorder = { bg = c.mantle, fg = c.overlay0 },
                        PmenuSbar = { bg = c.mantle },
                        PmenuThumb = { bg = c.surface2 },

                        -- Diagnostics (softened indicators)
                        DiagnosticError = { fg = c.red },
                        DiagnosticWarn = { fg = c.yellow },
                        DiagnosticInfo = { fg = c.sapphire },
                        DiagnosticHint = { fg = c.sky },
                        DiagnosticVirtualTextError = { bg = c.surface0, fg = c.red },
                        DiagnosticVirtualTextWarn = { bg = c.surface0, fg = c.yellow },
                        DiagnosticVirtualTextInfo = { bg = c.surface0, fg = c.sapphire },
                        DiagnosticVirtualTextHint = { bg = c.surface0, fg = c.sky },

                        -- Git
                        GitSignsAdd = { fg = c.green },
                        GitSignsChange = { fg = c.yellow },
                        GitSignsDelete = { fg = c.red },
                        DiffAdd = { bg = '#143038', fg = 'NONE' },
                        DiffChange = { bg = '#20263b', fg = 'NONE' },
                        DiffDelete = { bg = '#35161f', fg = 'NONE' },
                        DiffText = { bg = '#2c3e56', fg = 'NONE' },
                    }
                end,
            },
            integrations = {
                treesitter = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { 'italic' },
                        hints = { 'italic' },
                        warnings = { 'italic' },
                        information = { 'italic' },
                    },
                    underlines = {
                        errors = { 'underline' },
                        hints = { 'underline' },
                        warnings = { 'underline' },
                        information = { 'underline' },
                    },
                },
                blink_cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = { enabled = true },
                notify = true,
                noice = true,
                which_key = true,
                indent_blankline = { enabled = true },
                mini = { enabled = true },
                harpoon = true,
            },
        }

        _G.lualine_theme = {
            normal = {
                a = { fg = '#131229', bg = '#1184a3', gui = 'bold' },
                b = { fg = '#c8c2d6', bg = '#1f1e38' },
                c = { fg = '#988fae', bg = '#18172d' },
            },
            insert = {
                a = { fg = '#131229', bg = '#5db0c2', gui = 'bold' },
                b = { fg = '#c8c2d6', bg = '#1f1e38' },
                c = { fg = '#988fae', bg = '#18172d' },
            },
            visual = {
                a = { fg = '#131229', bg = '#b8586f', gui = 'bold' },
                b = { fg = '#c8c2d6', bg = '#1f1e38' },
                c = { fg = '#988fae', bg = '#18172d' },
            },
            replace = {
                a = { fg = '#131229', bg = '#c24b57', gui = 'bold' },
                b = { fg = '#c8c2d6', bg = '#1f1e38' },
                c = { fg = '#988fae', bg = '#18172d' },
            },
            command = {
                a = { fg = '#131229', bg = '#a88554', gui = 'bold' },
                b = { fg = '#c8c2d6', bg = '#1f1e38' },
                c = { fg = '#988fae', bg = '#18172d' },
            },
            inactive = {
                a = { fg = '#6d6288', bg = '#18172d', gui = 'bold' },
                b = { fg = '#6d6288', bg = '#18172d' },
                c = { fg = '#4d426d', bg = '#131229' },
            },
        }

        if _G.theme == 'catppuccin' then
            vim.cmd.colorscheme 'catppuccin'
        end
    end,
}
