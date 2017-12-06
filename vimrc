if $SHELL =~ 'fish'
    set shell=/bin/bash
endif

" key re mapping"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-j> <esc>
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
noremap  <Leader>h 0
noremap  <Leader>l $
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Neobundle""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
" Let NeoBundle manage itself"""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleFetch 'Shougo/neobundle.vim'
" colorschemes""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'
" plugins"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tyru/caw.vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'cespare/vim-toml'
NeoBundle 'ntpeters/vim-better-whitespace'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call neobundle#end()
" Required:
filetype plugin indent on
NeoBundleCheck
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" caw remaps""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap \c <Plug>(caw:zeropos:toggle)
vmap \c <Plug>(caw:zeropos:toggle)
nmap \C <Plug>(caw:zeropos:uncomment)
vmap \C <Plug>(caw:zeropos:uncomment)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" lightline settings""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
    \ 'colorscheme': 'hybrid',
    \ 'active': {
    \   'left':  [ ['mode', 'paste'],
    \              ['fugitive', 'readonly', 'filename', 'modified'] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag'
    \ },
    \ 'component_type': {
    \   'syntastic': 'error'
    \ },
    \ 'component_function': {
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename',
    \ },
    \ 'separator': {
    \   'left': "\ue0b0", 'right': "\ue0b2"
    \ },
    \ 'subseparator': {
    \   'left': "\ue0b1", 'right': "\ue0b3"
    \ }
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

function! LightLineFugitive()
    if exists("*fugitive#head")
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" syntastic"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if ! empty(neobundle#get('syntastic'))
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_cpp_check_header=1
    let g:syntastic_cpp_compiler_options = ' -std=c++11 -Wall'
    let g:syntastic_c_check_header=1
    let g:syntastic_c_compiler = 'clang'
    let b:syntastic_c_compiler_options = ' -std=c99 -Wall'
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"basic settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set title
set ruler
set number
set ttyfast
set nowrap
set noswapfile
set lazyredraw
"search setting"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch
set ignorecase
set hlsearch
set smartcase
set wrapscan
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set tabstop=4
set shiftwidth=4
set colorcolumn=81
set cursorline
" set cursorcolumn
set laststatus=2
set showtabline=2
set synmaxcol=150
set noshowmode
set re=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencoding=utf-8
set ambiwidth=double
:command ShiftJis :e ++enc=shift_jis
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"binary edit""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd
  autocmd BufWritePost * set nomod | endif
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" count number of letters"""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:Count_impl()
   :%s/./&/g
   :noh
endfunction
command! Count call s:Count_impl()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" folding"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark
colorscheme hybrid
syntax on
highlight ExtraWhitespace ctermbg=160
let g:indentLine_faster = 1
set norelativenumber
syntax sync minlines=256

au BufNewFile,BufRead *cuh set ft=cuda
au BufNewFile,BufRead *cu set ft=cuda
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
