return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
        {
            '<leader>ha',
            function()
                require('harpoon'):list():add()
            end,
            desc = 'Harpoon add file',
        },
        {
            '<leader>hr',
            function()
                require('harpoon'):list():remove()
            end,
            desc = 'Harpoon remove file',
        },
    },
    config = function(_, opts)
        local harpoon = require 'harpoon'
        harpoon:setup(opts)
    end,
}