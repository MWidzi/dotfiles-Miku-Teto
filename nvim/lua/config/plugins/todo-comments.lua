return { -- Highlight todo, notes, etc in comments
    'folkw/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
}