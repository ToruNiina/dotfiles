return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                filters = {
                    git_ignored = false,
                    custom = {
                        "^\\.git",
                        "^node_modules",
                    },
                },
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
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            }
        },
        config = function()
            local telescope = require('telescope')
            telescope.load_extension('fzf')

            vim.api.nvim_create_user_command('File', ':Telescope find_files', {})
            vim.api.nvim_create_user_command('Grep', ':Telescope live_grep', {})
            vim.api.nvim_create_user_command('Repo', ':Telescope git_files', {})
        end,
    },
}
