if $SHELL =~ 'fish'
    set shell=/bin/bash
endif

"Neobundle""""""""""""""""""""""
if has('vim_starting')
  set nocompatible
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" Required:
call neobundle#begin(expand('~/.vim/bundle'))
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
""""""""""""""""""""""""""""""""
" colorscheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'itchyny/lightline.vim'
""""""""""""""""""""""""""""""""
" plugin
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tyru/caw.vim'
"NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/syntastic'
""""""""""""""""""""""""""""""""
call neobundle#end()
" Required:
filetype plugin indent on
NeoBundleCheck
"""""""""""""""""""""""""""""""""

" lightline"""""""""""""""""""""
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left':[ ['mode', 'paste'],
    \            ['readonly', 'filename', 'modified'] ]
    \ },
    \ 'component_function': {
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }

function! LightLineModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

""""""""""""""""""""""""""""""""
" line status
set laststatus=2
set showtabline=2
set noshowmode
""""""""""""""""""""""""""""""""

"caw remap"""""""""""""""""""""""
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)
"""""""""""""""""""""""""""""""""

"syntax checker setting""""""""""
if ! empty(neobundle#get('syntastic'))
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_c_check_header=1	
    let g:syntastic_cpp_check_header=1
    let g:syntastic_cpp_compiler_options = '-Wall -std=c++11'
    let g:syntastic_c_compiler_options = '-Wall -std=c99'
endif
"""""""""""""""""""""""""""""""""

set number
set ruler
set title
set showmatch
set ignorecase
set smartcase
set hlsearch
set wrapscan
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set cursorline
set colorcolumn=81
" set cursorcolumn
syntax on
set background=dark
colorscheme hybrid
set mouse=a
set showcmd
set noswapfile

"binary file"""""""""""""""""""""""
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
