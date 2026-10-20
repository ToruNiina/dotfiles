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
        'veryl-lang/veryl.vim',
        config = function()
            -- do nothing
        end
    },
}
