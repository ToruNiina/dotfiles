return {
    { 'nvim-lua/plenary.nvim' },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- capabilities
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspcfg = require('lspconfig')
            lspcfg.clangd.setup({
                cmd = {"clangd-18"},
                capabilities = capabilities,
            })
            lspcfg.rust_analyzer.setup({
                capabilities = capabilities,
            })

            -- do not shift column position by diagnostics.
            vim.opt.signcolumn = 'yes'
            local signs = {
                DiagnosticSignError = '',
                DiagnosticSignWarn  = '',
                DiagnosticSignHint  = '',
                DiagnosticSignInfo  = '',
            }
            for type, icon in pairs(signs) do
              vim.fn.sign_define(type, { text=icon, texthl=type, numhl=type })
            end
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'p00f/clangd_extensions.nvim'
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                performance = {
                    fetching_timeout = 2000,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'buffer' },
                }),
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ['<C-n>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                    ['<CR>'] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                }),
                enabled = function()
                    -- disable completion in comments
                    local context = require('cmp.config.context')
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and
                               not context.in_syntax_group("Comment")
                    end
                end
            })
            cmp.setup.cmdline({ '/', '?' }, {
                enabled = false -- I don't want to press enter twice
            })
            cmp.setup.cmdline(':', {
                enabled = false -- I don't want to press enter twice
            })
            vim.opt.pumheight = 10
        end,
    },
}
