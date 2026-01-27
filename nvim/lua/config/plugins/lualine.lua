return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = {
                    normal = {
                        a = { fg = '#39375A', bg = '#439fb5', gui = 'bold' },
                        b = { fg = '#439fb5', bg = '#39375A' },
                        c = { fg = '#E0E0E0', bg = nvim_bg },
                    },
                    visual = {
                        a = { fg = '#39375A', bg = '#A0546D', gui = 'bold' },
                        b = { fg = '#A0546D', bg = '#39375A' },
                        c = { fg = '#E0E0E0', bg = nvim_bg },
                    },
                    insert = {
                        a = { fg = '#39375A', bg = '#7DE8F4', gui = 'bold' },
                        b = { fg = '#7DE8F4', bg = '#39375A' },
                        c = { fg = '#E0E0E0', bg = nvim_bg },
                    },
                    replace = {
                        a = { fg = '#39375A', bg = '#FF4A43', gui = 'bold' },
                        b = { fg = '#FF4A43', bg = '#39375A' },
                        c = { fg = '#E0E0E0', bg = nvim_bg },
                    },
                    command = {
                        a = { fg = '#39375A', bg = '#FFE756', gui = 'bold' },
                        b = { fg = '#FFE756', bg = '#39375A' },
                        c = { fg = '#E0E0E0', bg = nvim_bg },
                    },
                    inactive = {
                        a = { fg = '#39375A', bg = '#F38E21', gui = 'bold' },
                        b = { fg = '#F38E21', bg = '#39375A' },
                        c = { fg = '#E0E0E0', bg = nvim_bg },
                    },
                },
                component_separators = '',
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
                lualine_b = { 'branch', { 'lsp_status', symbols = { separator = '|' } }, 'diagnostics' },
                lualine_c = { { 'filename', file_status = true, newfile_status = true } },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { 'searchcount', 'progress' },
                lualine_z = { { 'location', separator = { right = '', left = '' }, left_padding = 2 } },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        }
    end,
}