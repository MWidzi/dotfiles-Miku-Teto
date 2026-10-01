return {
    'jesseleite/noirbuddy.nvim',
    dependencies = {
        'tjdevries/colorbuddy.nvim',
    },
    lazy = false,
    priority = 1000,
    config = function()
        require('noirbuddy').setup {
            colors = {
                primary = '#1184a3', -- Miku cyan (functions, constants, highlights, active tokens)
                secondary = '#b8586f', -- Teto rose (types, variables, secondary accents)
                background = '#131229', -- Rice deep navy background

                -- Monochromatic scale tinted with Miku-Teto purple-navy shades
                noir_0 = '#ffffff', -- brightest text
                noir_1 = '#e2deeb', -- main code identifiers / statements
                noir_2 = '#c8c2d6', -- standard code text
                noir_3 = '#aba2c0', -- secondary text / titles
                noir_4 = '#988fae', -- parameters / tags
                noir_5 = '#827896', -- subtle elements / keywords
                noir_6 = '#6d6288', -- comments / operators
                noir_7 = '#4d426d', -- borders / float borders
                noir_8 = '#2e294e', -- visual selection / active panels
                noir_9 = '#1f1e38', -- cursorline

                -- Diagnostics
                diagnostic_error = '#c24b57',
                diagnostic_warning = '#a88554',
                diagnostic_info = '#358fa2',
                diagnostic_hint = '#5db0c2',

                -- Diff
                diff_add = '#1184a3',
                diff_change = '#6d6288',
                diff_delete = '#b8586f',
            },
            styles = {
                italic = true,
                bold = true,
                underline = false,
                undercurl = true,
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
                a = { fg = '#131229', bg = '#b8586f', gui = 'bold' },
                b = { fg = '#c8c2d6', bg = '#1f1e38' },
                c = { fg = '#988fae', bg = '#18172d' },
            },
            inactive = {
                a = { fg = '#6d6288', bg = '#18172d', gui = 'bold' },
                b = { fg = '#6d6288', bg = '#18172d' },
                c = { fg = '#4d426d', bg = '#131229' },
            },
        }

    end,
}
