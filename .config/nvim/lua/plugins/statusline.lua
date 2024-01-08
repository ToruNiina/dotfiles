return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'archibate/lualine-time',
        },
        config = function()
            -- make inactive ones visible/readable
            local custom_iceberg = require('lualine.themes.iceberg')

            custom_iceberg.inactive.a.fg = '#818596'
            custom_iceberg.inactive.b.fg = '#818596'
            custom_iceberg.inactive.c.fg = '#818596'

            require('lualine').setup({
                options = {
                    theme = custom_iceberg,
                },
                tabline = {
                    lualine_a = { -- show current pwd
                        {'branch', icon = ''}
                    },
                    lualine_b = {
                        function()
                            return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:~')
                        end,
                    },
                    lualine_c = {
                    },
                    lualine_x = {
                    },
                    lualine_y = {
                        { 'tabs', mode = 2 },
                    },
                    lualine_z = {
                    }
                },
                sections = {
                    lualine_b = {
                    },
                    lualine_c = {
                        {
                            'filename',
                            path = 1, -- relative path from pwd
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '[]',
                                unnamed = '[No Name]',
                                newfile = '[New]',
                            },
                        },
                    },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
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
                            path = 1,
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '[]',
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
