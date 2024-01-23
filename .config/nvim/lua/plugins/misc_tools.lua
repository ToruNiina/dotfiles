return {
    {
        'tpope/vim-commentary',
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
        'chrisgrieser/nvim-chainsaw',
        config = function()
            require("chainsaw").setup ({
                marker = '[chainsaw] log: ',
                logStatements = {
                    variableLog = {
                        cpp = 'std::cerr << "%s %s:" << %s << std::endl;',
                    },
                },
            })
            vim.keymap.set('n', '<C-l>', ':lua require("chainsaw").variableLog()<CR>')
            vim.api.nvim_create_user_command('Rmlog', ':lua require("chainsaw").removeLogs()<CR>', {})
        end,
    },
    {
        'stevearc/aerial.nvim',
        config = function()
            require('aerial').setup({
                layout = {
                    default_direction = 'prefer_left'
                }
            })
            vim.api.nvim_create_user_command('Aerial', ':lua require(\'aerial\').toggle({focus=false, direction=\'left\'})', {})
        end,
    },
    {
        'jbyuki/venn.nvim',
        config = function()
            function _G.Toggle_venn()
                local venn_enabled = vim.inspect(vim.b.venn_enabled)
                if venn_enabled == "nil" then
                    vim.b.venn_enabled = true
                    vim.cmd.setlocal('ve=all')
                    -- draw a line on HJKL keystokes
                    vim.keymap.set('n', 'J', '<C-v>j:VBox<CR>')
                    vim.keymap.set('n', 'K', '<C-v>k:VBox<CR>')
                    vim.keymap.set('n', 'L', '<C-v>l:VBox<CR>')
                    vim.keymap.set('n', 'H', '<C-v>h:VBox<CR>')
                    -- draw a box by pressing "f" with visual selection
                    vim.keymap.set('v', 'f', ':VBox<CR>')
                else
                    vim.cmd.setlocal('ve=')
                    vim.cmd.mapclear('<buffer>')
                    vim.b.venn_enabled = nil
                end
            end
            -- toggle by `:Venn`
            vim.api.nvim_create_user_command('Venn', ':lua Toggle_venn()', {})
        end,
    },
}
