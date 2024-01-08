return {
    {
        'cocopon/iceberg.vim',
        config = function()
            vim.opt.termguicolors = false -- i like iceberg on cterm
            vim.cmd.colorscheme("iceberg")
        end,
    },
    {
        'ntpeters/vim-better-whitespace',
        config = function()
            vim.cmd("hi! link ExtraWhiteSpace Error")
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
}
