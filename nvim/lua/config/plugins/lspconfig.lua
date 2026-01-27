return {
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
}