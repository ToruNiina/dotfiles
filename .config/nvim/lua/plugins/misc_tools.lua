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
        "rcarriga/nvim-notify",
        config = function()
            require('notify').setup({})
            vim.notify = require("notify")
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
    {
        'notjedi/nvim-rooter.lua',
        config = function()
            require('nvim-rooter').setup({})
        end,
    },
    {
        'stevearc/overseer.nvim',
        dependencies = {
            "rcarriga/nvim-notify",
            'nvim-telescope/telescope.nvim',
            'stevearc/dressing.nvim',
        },
        opts = {},
        config = function()
            require('overseer').setup({
                templates = {
                    "cmake-build",
                    "cmake-test",
                }
            })
        end,
    },
}
