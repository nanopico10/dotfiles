set nocompatible
filetype plugin indent off
 
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif
 
let g:neobundle_default_git_protocol='https'
 
NeoBundleFetch 'Shougo/neobundle.vim'
" After installing vimproc, turn shell ~/.vim/bundle/vimproc, 
" (e.g.)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'

NeoBundle 'tpope/vim-surround'

filetype plugin on
filetype indent on

NeoBundleCheck

" -------------------------------------
"  Enable mode line
" -------------------------------------
set modeline
set modelines=5

" -------------------------------------
"  Display followings on status bar
"  - file name
"  - file format
"  - file type
"  - ASCII code(dec and hex)
"  - column and line numbers
"  - file encoding
" -------------------------------------
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]
set statusline+=\ [ASCII=\%03.3b(0x\%02.2B)
set statusline+=\ [%04v,%04l]\ -\ %p%%\ [%{&fileencoding}]
set laststatus=2

" vi: expandtab ts=4 sw=4 sts=4 ff=unix
