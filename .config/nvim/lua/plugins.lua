return {
    {
        'cocopon/iceberg.vim',
        config = function()
            vim.opt.termguicolors = false -- i like iceberg on cterm
            vim.cmd.colorscheme("iceberg")
        end,
    },
    {
        'tpope/vim-commentary',
    },

    -- nvim-tree ---------------------------------------------------------------
    {
        'nvim-tree/nvim-web-devicons',
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")
                    local function opts(desc)
                        return {
                            desc = "nvim-tree: " .. desc,
                            buffer = bufnr,
                            noremap = true,
                            silent = true,
                            nowait = true
                        }
                    end
                    api.config.mappings.default_on_attach(bufnr)
                    vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Vertical Split'))
                    vim.keymap.set('n', 'v', api.node.open.vertical,   opts('Open: Horizontal Split'))
                end,
            })
            -- to use muscle memory...
            vim.api.nvim_create_user_command('NERDTree', 'NvimTreeOpen', {})
        end,
    },

    -- completion --------------------------------------------------------------
    {
        'neovim/nvim-lspconfig',

        dependencies = {
            'hrsh7th/cmp-nvim-lsp' -- use capabilities
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspcfg = require('lspconfig')
            lspcfg.clangd.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- do not highlight cpp
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
            lspcfg.rust_analyzer.setup({
                capabilities = capabilities
            })

            -- do not shift column position by diagnostics.
            for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
                vim.fn.sign_define("DiagnosticSign" .. diag, {
                    text = "",
                    texthl = "DiagnosticSign" .. diag,
                    linehl = "",
                    numhl = "DiagnosticSign" .. diag,
                })
            end
        end,
    },
    {
        'p00f/clangd_extensions.nvim'
    },

    { 'hrsh7th/vim-vsnip' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-nvim-lsp', },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
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
        end,
    },


    -- highlights --------------------------------------------------------------
    {
        'ntpeters/vim-better-whitespace',
        config = function()
            vim.cmd('highlight ExtraWhiteSpace Error')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        if lang == 'cpp' then
                            return true
                        end
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                }
            })
        end,
    },
    {
        'nvim-treesitter/playground',
        config = function()
            require("nvim-treesitter.configs").setup({
                playground = {
                    enable = true,
                    disable = function(lang, buf)
                        if lang == 'cpp' then
                            return true
                        end
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    updatetime = 25,
                    persist_queries = false,
                }
            })
        end,
    },
    {
        'bfrg/vim-cpp-modern',
    },

    -- statusline ---------------------------------------------------------------
    {
        -- show date and time on status line
        'archibate/lualine-time',
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'archibate/lualine-time'
        },
        config = function()
            -- make inactive ones visible/readable
            local custom_iceberg = require('lualine.themes.iceberg')
            custom_iceberg.inactive.a.fg = '#818596'
            custom_iceberg.inactive.b.fg = '#818596'
            custom_iceberg.inactive.c.fg = '#818596'

            require('lualine').setup({
                options = {
                    theme = custom_iceberg
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            path = 3,
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '[R]',
                                unnamed = '[No Name]',
                                newfile = '[New]',
                            },
                        }
                    },
                    lualine_y = {
                        'location' -- we don't need %, but line:column
                    },
                    lualine_z = {
                        'cdate', 'ctime'
                    }
                },
                -- show info of inactive ones
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            'filename',
                            path = 3,
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '[R]',
                                unnamed = '[No Name]',
                                newfile = '[New]',
                            },
                        }
                    },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'location'},
                    lualine_z = {'cdate', 'ctime'}
                },
            })
        end,
    },
}
