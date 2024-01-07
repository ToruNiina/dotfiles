-- key remapping
vim.keymap.set('i', 'jk', '<esc>')
vim.g.mapleader = ' '
vim.keymap.set({'n', 'v', 'o'}, '<Leader>h', '0')
vim.keymap.set({'n', 'v', 'o'}, '<Leader>l', '$')

-- basic settings
vim.opt.fileencoding  = 'utf-8'
vim.opt.title         = true
vim.opt.ruler         = true
vim.opt.number        = true
vim.opt.wrap          = false
vim.opt.swapfile      = false
vim.opt.lazyredraw    = true
vim.opt.mouse         = ''
vim.opt.backspace     = 'indent,eol,start'

vim.opt.showmatch     = true
vim.opt.ignorecase    = true
vim.opt.hlsearch      = true
vim.opt.smartcase     = true
vim.opt.wrapscan      = true

vim.opt.expandtab     = true
vim.opt.tabstop       = 4
vim.opt.shiftwidth    = 4
vim.opt.colorcolumn   = '81'
vim.opt.cursorline    = true

vim.opt.laststatus    = 2
vim.opt.showtabline   = 2
vim.opt.synmaxcol     = 1000
vim.opt.showmode      = false
vim.opt.re            = 1
vim.opt.foldmethod    = 'marker'

-- to suppress annoying, completely useless sounds
vim.opt.visualbell = false
vim.opt.belloff    = 'all'

-- package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
