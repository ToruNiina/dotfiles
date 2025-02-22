return {
    {
        'oahlen/iceberg.nvim',
        config = function()
            vim.cmd.colorscheme("iceberg")
        end,
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true
                },
            })
        end
    },
    {
        'ntpeters/vim-better-whitespace',
        config = function()
            vim.cmd("hi! link ExtraWhiteSpace Error")
        end,
    },
    {
        'tpope/vim-markdown',
        config = function()
            vim.g.markdown_fenced_languages = {'c', 'cpp', 'scala', 'rust', 'sh', 'bash'}
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        if lang == 'cpp' or lang == 'rust' then
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
                        if lang == 'cpp' or lang == 'rust' then
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

}
