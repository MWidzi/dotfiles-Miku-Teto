return {
    'roobert/palette.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('palette').setup {
            palettes = {
                main = 'custom_main',
                accent = 'custom_accent',
                state = 'custom_state',
            },
            custom_palettes = {
                main = {
                    custom_main = {
                        color0 = '#131229', -- bg
                        color1 = '#18172d',
                        color2 = '#222043',
                        color3 = '#2e294e',
                        color4 = '#403663',
                        color5 = '#5a4a85',
                        color6 = '#786c9c',
                        color7 = '#958caf',
                        color8 = '#c4bed9',
                    },
                },
                accent = {
                    custom_accent = {
                        accent0 = '#1184a3', -- main1
                        accent1 = '#923852', -- main2
                        accent2 = '#8b7283',
                        accent3 = '#a0b5be',
                        accent4 = '#8b939b',
                        accent5 = '#b0c0ca',
                        accent6 = '#c1d0db',
                    },
                },
                state = {
                    custom_state = {
                        error = '#923852',
                        warning = '#ae9072',
                        hint = '#1184a3',
                        ok = '#729472',
                        info = '#5a7e9a',
                    },
                },
            },
            italics = true,
            transparent_background = false,
        }

        vim.cmd 'colorscheme palette'
        vim.api.nvim_set_hl(0, 'Keyword', { fg = '#1184a3', bold = true })
        vim.api.nvim_set_hl(0, 'Function', { fg = '#d3a593' })
        vim.api.nvim_set_hl(0, '@function.builtin', { fg = '#e7d2be' })
        vim.api.nvim_set_hl(0, 'String', { fg = '#923852' })
        vim.api.nvim_set_hl(0, 'Constant', { fg = '#923852' })
        vim.api.nvim_set_hl(0, 'Type', { fg = '#8597a0' })
        vim.api.nvim_set_hl(0, 'Comment', { fg = '#6d5f66', italic = true })
        vim.api.nvim_set_hl(0, 'Identifier', { fg = '#90a3ac' })
        vim.api.nvim_set_hl(0, 'Normal', { bg = '#131229', fg = '#c4bed9' })
        vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#b0c0ca' })
        vim.api.nvim_set_hl(0, 'Bracket', { fg = '#b0c0ca' })
        vim.api.nvim_set_hl(0, 'Visual', { bg = '#2e294e' }) -- darker blue with strong contrast
        vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#222043' }) -- slightly lighter background
    end,
}