return { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
        -- Snippet Engine
        {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
            opts = {},
        },
        'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<C-k>'] = false,
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
        },

        appearance = {
            nerd_font_variant = 'normal',
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'lazydev' },
            providers = {
                lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },

        snippets = { preset = 'luasnip' },

        fuzzy = {
            implementation = 'prefer_rust_with_warning',
            sorts = {
                'score', -- Primary sort: by fuzzy matching score
                'sort_text', -- Secondary sort: by sortText field if scores are equal
                'label', -- Tertiary sort: by label if still tied
            },
        },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
    },
}