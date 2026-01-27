return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup {
            view = { width = 30 },
            renderer = { group_empty = true },
            filters = { dotfiles = false },
        }
        vim.keymap.set('n', '<leader>e', function()
            local api = require 'nvim-tree.api'

            if api.tree.is_visible() then
                api.tree.focus()
            else
                api.tree.open()
            end

            AutoLayout()
        end, { desc = 'Open or focus file explorer' })
    end,
}