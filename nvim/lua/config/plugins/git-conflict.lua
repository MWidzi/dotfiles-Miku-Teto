return { -- Visualize & resolve git conflict markers
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true, -- auto-setup with defaults
    keys = {
        { '<leader>co', '<Plug>(git-conflict-ours)', mode = { 'n', 'x' }, desc = 'Conflict take ours' },
        { '<leader>ct', '<Plug>(git-conflict-theirs)', mode = { 'n', 'x' }, desc = 'Conflict take theirs' },
        { '<leader>cb', '<Plug>(git-conflict-both)', mode = { 'n', 'x' }, desc = 'Conflict take both' },
        { '<leader>c0', '<Plug>(git-conflict-none)', mode = { 'n', 'x' }, desc = 'Conflict take none' },
        { ']x', '<Plug>(git-conflict-next-conflict)', desc = 'Next conflict' },
        { '[x', '<Plug>(git-conflict-prev-conflict)', desc = 'Prev conflict' },
    },
}