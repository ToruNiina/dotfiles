return {
    {
        "terrortylor/nvim-comment",
        config = function()
            require('nvim_comment').setup()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "vigoux/notifier.nvim",
        config = function()
            require('notifier').setup({
            })
        end,
    },
    {
        'Wansmer/treesj',
        keys = {
            '<space>m',
            '<space>j',
            '<space>s',
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({})
        end,
    },
    {
        'monaqa/dial.nvim',
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },
}
