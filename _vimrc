set nocompatible
filetype off
filetype plugin off
filetype indent off
 
" -------------------------------------
" NeoBundle
" -------------------------------------
" {{{
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Set the vimproc library path
if has('mac')
    let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
elseif has('win32')
    let g:vimproc_dll_path = $HOME . 'vimfiles/bundle/vimproc/autoload/vimproc_win32.dll'
elseif has('win64')
    let g:vimproc_dll_path = $HOME . 'vimfiles/bundle/vimproc/autoload/vimproc_win64.dll'
endif

" Retrieve plugins via https.
let g:neobundle_default_git_protocol='https'
 
NeoBundleFetch 'Shougo/neobundle.vim'
" After installing vimproc, turn shell ~/.vim/bundle/vimproc, 
" (e.g.)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'
" }}}

NeoBundle 'Shougo/unite.vim'

" -------------------------------------
" localrc
" -------------------------------------
NeoBundle 'thinca/vim-localrc'

" -------------------------------------
" neocomplcache
" -------------------------------------
let g:neocomplcache_enable_at_startup = 1
NeoBundle 'Shougo/neocomplcache'
set infercase
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_use_vimproc = 1
imap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <silent><expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"

" -------------------------------------
" vim-surround
" -------------------------------------
NeoBundle 'tpope/vim-surround'

" -------------------------------------
" vim-fugitive
" -------------------------------------
NeoBundle 'tpope/vim-fugitive'

" -------------------------------------
" NERDTree
" -------------------------------------
NeoBundle 'scrooloose/nerdtree'

" -------------------------------------
" vim-ruby
" -------------------------------------
NeoBundleLazy 'vim-ruby/vim-ruby', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
compiler ruby

" -------------------------------------
" vim-rails
" -------------------------------------
NeoBundle 'tpope/vim-rails'
"{{{
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
    nnoremap <buffer><Space>r :R<CR>
    nnoremap <buffer><Space>a :A<CR>
    nnoremap <buffer><Space>m :Rmodel<Space>
    nnoremap <buffer><Space>c :Rcontroller<Space>
    nnoremap <buffer><Space>v :Rview<Space>
    nnoremap <buffer><Space>p :Rpreview<CR>
endfunction

aug MyAutoCmd
    au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
    au!
aug END
"}}}

filetype plugin on
filetype indent on
syntax on

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
" {{{
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]
set statusline+=\ [ASCII=\%03.3b(0x\%02.2B)
set statusline+=\ [%04v,%04l]\ -\ %p%%\ [%{&fileencoding}]
set laststatus=2
" }}}

" -------------------------------------
"  Load a local vimrc if exists.
"  This function searches .vim.local from current to root directories.
" -------------------------------------
call localrc#load('.vimrc.local', getcwd())

" vi: expandtab ts=4 sw=4 sts=4 tw=0 ff=unix 
