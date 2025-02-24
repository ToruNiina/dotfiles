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
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group{
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.integer.alias.octal,
                    augend.integer.alias.binary,
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.constant.alias.bool,
                },
            }
            vim.keymap.set("n", "<C-a>", function()
                require("dial.map").manipulate("increment", "normal")
            end)
            vim.keymap.set("n", "<C-x>", function()
                require("dial.map").manipulate("decrement", "normal")
            end)
            vim.keymap.set("n", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gnormal")
            end)
            vim.keymap.set("n", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gnormal")
            end)
            vim.keymap.set("v", "<C-a>", function()
                require("dial.map").manipulate("increment", "visual")
            end)
            vim.keymap.set("v", "<C-x>", function()
                require("dial.map").manipulate("decrement", "visual")
            end)
            vim.keymap.set("v", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gvisual")
            end)
            vim.keymap.set("v", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gvisual")
            end)
        end,
    },
    -- {
    --     "sphamba/smear-cursor.nvim",
    --     opts = {},
    -- },
    {
        'notjedi/nvim-rooter.lua',
        config = function()
            require('nvim-rooter').setup({
                manual = true,
            })
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
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {
            provider = "ollama",
            vendors = {
                ollama = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://127.0.0.1:11434/v1",
                    model = "qwen2.5-coder:14b",
                },
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "Avante" },
                },
                ft = { "Avante" },
            },
        },
    },
}
