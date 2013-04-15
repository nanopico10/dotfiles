set nocompatible
filetype plugin indent off
 
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif
 
let g:neobundle_default_git_protocol='https'
 
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'

NeoBundle 'tpope/vim-surround'

NeoBundle 'altercation/vim-colors-solarized'
syntax enable
set background=dark
colorscheme solarized

filetype plugin on
filetype indent on

NeoBundleCheck
