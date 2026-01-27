--[[

=====================================================================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
--
-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- tab config
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Number of spaces used for autoindent
vim.opt.expandtab = true -- Converts tabs to spaces (optional, depends on preference)

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 100

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>tn', function()
    vim.cmd.tabnew()
    vim.cmd.NvimTreeOpen()
end, { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose, { desc = '[T]ab [C]lose' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

-- resize all sidebar plugins
function AutoLayout()
    local api = require 'nvim-tree.api'
    local normal_buffers = {}
    local terminal_buffers = {}
    local width = vim.o.columns
    local height = vim.o.lines

    if api.tree.is_visible() then
        local windows = vim.api.nvim_list_wins()

        for _, win in ipairs(windows) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            local buf_type = vim.api.nvim_buf_get_option(buf, 'buftype')

            vim.api.nvim_set_current_win(win)

            if buf_type == 'terminal' then
                table.insert(terminal_buffers, win)
            elseif buf_name ~= '' and (buf_type == 'nofile' or buf_type == 'nowrite') then
                vim.print(buf_name)
                vim.cmd 'wincmd K'
                if string.find(buf_name, 'diffpanel') then
                    vim.cmd 'resize 10'
                elseif string.find(buf_name, 'undotree') then
                    vim.cmd 'resize 5'
                elseif string.find(buf_name, 'NvimTree') then
                    vim.cmd 'wincmd J'
                    vim.cmd 'resize 20'
                end
            elseif buf_name ~= '' and (buf_type == '' or buf_type == 'normal') then
                vim.cmd 'wincmd L'
                normal_buffers[#normal_buffers + 1] = win
            end
        end
        vim.cmd 'wincmd 10h'
        vim.cmd 'vertical resize 30'

        if #normal_buffers > 1 then
            vim.api.nvim_set_current_win(normal_buffers[#normal_buffers])
            vim.cmd 'vertical resize 50'
        end

        if #terminal_buffers > 0 then
            vim.api.nvim_set_current_win(terminal_buffers[1])
            vim.cmd 'wincmd L'

            if #terminal_buffers > 1 then
                for i = 2, #terminal_buffers do
                    local term_buf_to_move = vim.api.nvim_win_get_buf(terminal_buffers[i])
                    vim.api.nvim_set_current_win(terminal_buffers[1])
                    vim.cmd 'split'
                    vim.api.nvim_win_set_buf(0, term_buf_to_move)
                end

                for i = 2, #terminal_buffers do
                    vim.api.nvim_win_close(terminal_buffers[i], false)
                end
            end

            vim.cmd 'wincmd 10l'
            vim.cmd 'vertical resize 35'
        end
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
require('lazy').setup({
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.o.timeoutlen
            delay = 0,
            preset = 'helix',
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            -- Document existing key chains
            spec = {
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
        },
    },

    {
        'Hoffs/omnisharp-extended-lsp.nvim',
        lazy = true,
    },
    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
            -- [[ Configure Telescope ]]
            require('telescope').setup {
                defaults = {
                    wrap_results = true,
                    selection_caret = ' ',
                    prompt_prefix = ' ',
                    multi_icon = '',
                    path_display = 'truncate',
                    dynamic_preview_title = true,
                    mappings = {
                        i = {
                            ['<c-enter>'] = 'to_fuzzy_refine',
                            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
                            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
                        },
                    },
                },
                -- pickers = {}
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local harpoon = require 'harpoon'
            harpoon:setup {}

            local conf = require('telescope.config').values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require('telescope.pickers')
                    .new({}, {
                        prompt_title = 'Harpoon',
                        finder = require('telescope.finders').new_table {
                            results = file_paths,
                        },
                        previewer = conf.file_previewer {},
                        sorter = conf.generic_sorter {},
                    })
                    :find()
            end

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<C-e>', function()
                toggle_telescope(harpoon:list())
            end, { desc = 'Open harpoon window' })

            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earcb [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sc', builtin.git_commits, { desc = '[S]earch [C]ommits' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },

    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
        keys = {
            { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git [D]iffview' },
            { '<leader>gD', '<cmd>DiffviewOpen --staged<cr>', desc = 'Git [D]iffview (staged)' },
        },
        opts = {},
    },

    { -- Visualize & resolve git conflict markers
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
    },

    -- LSP Plugins
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            'saghen/blink.cmp',
        },
        config = function()
            vim.filetype.add {
                extension = {
                    ejs = 'html',
                },
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- Rename the variable under your cursor.
                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                    -- Find references for the word under your cursor.
                    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                    -- Jump to the implementation of the word under your cursor.
                    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                    -- Jump to the definition of the word under your cursor.
                    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- Fuzzy find all the symbols in your current document.
                    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                    -- Fuzzy find all the symbols in your current workspace.
                    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                    -- Jump to the type of the word under your cursor.
                    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    ---@param client vim.lsp.Client
                    ---@param method vim.lsp.protocol.Method
                    ---@param bufnr? integer some lsp support methods only in specific files
                    ---@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has 'nvim-0.11' == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local servers = {
                phpactor = {},
                pyright = {},
                rust_analyzer = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                omnisharp = {},
                html = {},
                ts_ls = {},
                copilot = {},
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
                'html-lsp',
                'omnisharp',
                'phpactor',
                'typescript-language-server',
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

                        if server_name == 'phpactor' then
                            require('lspconfig').phpactor.setup {
                                root_dir = function(_)
                                    return vim.loop.cwd()
                                end,
                                init_options = {
                                    ['language_server.diagnostics_on_update'] = false,
                                    ['language_server.diagnostics_on_open'] = false,
                                    ['language_server.diagnostics_on_save'] = false,
                                    ['language_server_phpstan.enabled'] = false,
                                    ['language_server_psalm.enabled'] = false,
                                },
                                capabilities = server.capabilities,
                            }
                            return
                        end

                        if server_name == 'omnisharp' then
                            local mono_path = 'mono'
                            local omni_path = vim.fn.stdpath 'data' .. '/mason/packages/omnisharp/OmniSharp.exe'
                            server.cmd = { mono_path, omni_path }
                            server.settings = {
                                FormattingOptions = {
                                    EnableEditorConfigSupport = true,
                                    OrganizeImports = true,
                                },
                                RoslynExtensionsOptions = {
                                    EnableAnalyzersSupport = true,
                                    EnableImportCompletion = true,
                                },
                                useModernNet = false,
                            }

                            local oe = require 'omnisharp_extended'
                            -- Override handlers with omnisharp-extended
                            server.handlers = {
                                ['textDocument/definition'] = oe.handler,
                                ['textDocument/typeDefinition'] = oe.type_definition_handler,
                                ['textDocument/references'] = oe.references_handler,
                                ['textDocument/implementation'] = oe.implementation_handler,
                            }
                        end

                        if server_name == 'ts_ls' then
                            server.filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'ejs' }
                        end

                        if server_name == 'html' then
                            server.filetypes = { 'html', 'php', 'ejs' }
                        end

                        require('lspconfig')[server_name].setup(server)

                        if server_name == 'copilot' then
                            vim.lsp.enable 'copilot'
                        end
                    end,
                },
            }
        end,
    },

    { -- Autoformat
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = true,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style.
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = 'fallback',
                    }
                end
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                python = { 'isort', 'black' },
                --
                -- You can use 'stop_after_first' to run the first available formatter from the list
                javascript = { 'prettierd', 'prettier', stop_after_first = true },
            },
        },
    },

    { -- Autocompletion
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
    },

    {
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
    },

    -- Highlight todo, notes, etc in comments
    { 'folkw/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require('mini.ai').setup { n_lines = 500 }

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup()
        end,
    },
    {
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
    },
    {
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
    },
    {
        'mbbill/undotree',
        lazy = true,
        keys = {
            {
                '<leader>u',
                function()
                    vim.cmd.UndotreeToggle()
                    AutoLayout()
                end,
                desc = 'Toggle UndoTree',
            },
        },
    },
    {
        'folke/sidekick.nvim',
        opts = {
            -- add any options here
            cli = {
                mux = {
                    backend = 'zellij',
                    enabled = true,
                },
            },
        },
        keys = {
            {
                '<tab>',
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require('sidekick').nes_jump_or_apply() then
                        return '<Tab>' -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = 'Goto/Apply Next Edit Suggestion',
            },
            {
                '<c-.>',
                function()
                    require('sidekick.cli').toggle()
                end,
                desc = 'Sidekick Toggle',
                mode = { 'n', 't', 'i', 'x' },
            },
            {
                '<leader>aa',
                function()
                    require('sidekick.cli').toggle()
                end,
                desc = 'Sidekick Toggle CLI',
            },
            {
                '<leader>as',
                function()
                    require('sidekick.cli').select()
                end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = 'Select CLI',
            },
            {
                '<leader>ad',
                function()
                    require('sidekick.cli').close()
                end,
                desc = 'Detach a CLI Session',
            },
            {
                '<leader>at',
                function()
                    require('sidekick.cli').send { msg = '{this}' }
                end,
                mode = { 'x', 'n' },
                desc = 'Send This',
            },
            {
                '<leader>af',
                function()
                    require('sidekick.cli').send { msg = '{file}' }
                end,
                desc = 'Send File',
            },
            {
                '<leader>av',
                function()
                    require('sidekick.cli').send { msg = '{selection}' }
                end,
                mode = { 'x' },
                desc = 'Send Visual Selection',
            },
            {
                '<leader>ap',
                function()
                    require('sidekick.cli').prompt()
                end,
                mode = { 'n', 'x' },
                desc = 'Sidekick Select Prompt',
            },
            -- Example of a keybinding to open Claude directly
            {
                '<leader>ac',
                function()
                    require('sidekick.cli').toggle { name = 'claude', focus = true }
                end,
                desc = 'Sidekick Toggle Claude',
            },
        },
    },
    {
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
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'diff',
                'html',
                'javascript',
                'typescript',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },

    -- TODO: check this out later
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

    { import = 'custom.plugins' },
}, {
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})
