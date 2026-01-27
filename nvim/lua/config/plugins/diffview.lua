return {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
        { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git [D]iffview' },
        { '<leader>gD', '<cmd>DiffviewOpen --staged<cr>', desc = 'Git [D]iffview (staged)' },
    },
    opts = {},
}