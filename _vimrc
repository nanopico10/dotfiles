set nocompatible
filetype off
filetype plugin off
filetype indent off
 
" -------------------------------------
"  NeoBundle
" -------------------------------------
" {{{
if has('vim_starting')
    if has('win32') || has('win64')
        set runtimepath+=~/vimfiles/bundle/neobundle.vim/
        call neobundle#rc(expand('~/vimfiles/bundle/'))
    else
        set runtimepath+=~/.vim/bundle/neobundle.vim/
        call neobundle#rc(expand('~/.vim/bundle/'))
    endif
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
"  localrc
" -------------------------------------
NeoBundle 'thinca/vim-localrc'

" -------------------------------------
"  neocomplcache
"  neosnippet
" -------------------------------------
let g:neocomplcache_enable_at_startup = 1
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
set infercase
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_use_vimproc = 1
imap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <silent><expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" -------------------------------------
"  vim-surround
" -------------------------------------
NeoBundle 'tpope/vim-surround'

" -------------------------------------
"  vim-fugitive
" -------------------------------------
NeoBundle 'tpope/vim-fugitive'

" -------------------------------------
"  ctrlp.vim
" -------------------------------------
NeoBundle 'kien/ctrlp.vim'

" -------------------------------------
"  vimfiler
" -------------------------------------
NeoBundle 'Shougo/vimfiler'
let g:vimfiler_as_default_explorer = 1

" -------------------------------------
"  NERDTree
" -------------------------------------
NeoBundle 'scrooloose/nerdtree'

" -------------------------------------
"  vim-ruby
" -------------------------------------
NeoBundleLazy 'vim-ruby/vim-ruby', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
compiler ruby
autocmd FileType ruby set sw=2 sts=2 et autoindent ts=2

" -------------------------------------
"  vim-rails
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

filetype on
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
"  Switch status bar color
"  between insert and edit mode.
" -------------------------------------
augroup switchStatusLine
    au!
    au InsertEnter * highlight StatusLine guifg=DarkGray guibg=DarkBlue
        \ ctermfg=DarkGray ctermbg=DarkBlue cterm=none
    au InsertLeave * highlight StatusLine guifg=DarkBlue guibg=DarkGray
        \ ctermfg=DarkBlue ctermbg=DarkGray cterm=none
augroup END
" Apply to change colors immediately for not-GUI Vim (Cygwin and so on).
if has('unix') && !has('gui_running')
    inoremap <silent> <ESC> <ESC>
    inoremap <silent> <C-[> <ESC>
endif

" -------------------------------------
"  Highlight ZenkakuSpace
" -------------------------------------
scriptencoding=utf-8
highlight ZenkakuSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
match ZenkakuSpace /　/

" -------------------------------------
"  Open search result window with 
"  in vimgrep command.
" -------------------------------------
"  {{{
augroup grepopen
    autocmd!
    autocmd QuickFixCmdPost vimgrep cw
augroup END
" }}}

" -------------------------------------
"  Switch the next tab.
" -------------------------------------
" non-GUI Vim doesn't work..
nnoremap <C-S-tab>  :tabprevious<CR>
nnoremap <C-tab>    :tabnext<CR>
" Only this keymap does work in non-GUI Vim.
nnoremap <C-t>      :tabnext<CR>

" -------------------------------------
"  Set mouse enabled.
" -------------------------------------
set mouse=a

" -------------------------------------
"  Move cursor by display lines
"  when wrapping
"  from http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
" -------------------------------------
" {{{
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap nolinebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> k gk
        noremap  <buffer> <silent> j gj
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction
" }}}


" -------------------------------------
"  Set backspace enabled in insert mode.
" -------------------------------------
set backspace=indent,eol,start

" -------------------------------------
"  Load a local vimrc if exists.
"  This function searches .vim.local from current to root directories.
" -------------------------------------
call localrc#load('.vimrc.local', getcwd())

" vi: expandtab ts=4 sw=4 sts=4 tw=0 ff=unix
