" @vimonly
version 6.0

" General options.
set nocompatible
" ~@vimonly
set nobackup
set autoread


" ---- extensions
" --neobundle++++++++++
filetype off
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/vim_share/bundle/neobundle.vim/
    call neobundle#rc(expand('~/vim_share/bundle'))
endif
" plugins
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neosnippet.git'
" ++++++++++++++
" --theNERDTree++++++++++
nmap <Leader>t :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ++++++++++
" --Neocomplcache++++++++++
let g:neocomplcache_enable_at_startup = 1
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-y> neocomplcache#close_popup()
noremap <expr><C-e> neocomplcache#cancel_popup()
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
" ++++++++++

" ~@vimonly
" CUI options.
" --cmdline
set wildmenu
set showcmd
set visualbell
set hidden
" --search
set hlsearch
set wrapscan
set incsearch
set ignorecase
set smartcase
" ----UI
syntax enable
" line number & ruler
set number
set ruler
set cursorline
set cursorcolumn
set laststatus=2
set statusline=%<%t\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%lL/%L:%cC%V%8P
set title
" <tab> width in view
set tabstop=8
" change schemes by filetype
filetype plugin on
" color settings
set t_Co=256
colorscheme zenburn
" dynamic colors
noremap <expr><S-t> ":colorscheme zellner <CR> :set nocursorcolumn<CR>"
noremap <expr><C-c> ":colorscheme zenburn<CR> :set cursorcolumn<CR>"

" ----edit
set backspace=indent,eol,start
set expandtab
set showmatch
" <tab> is replced with spaces:
set softtabstop=4
" in auto-mode
set shiftwidth=4
set noautoindent
set nosmartindent

" ---- keybinds
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap j gj
nnoremap k gk


if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
let &cpo=s:cpo_save
unlet s:cpo_save
set fileencodings=ucs-bom,utf-8,latin1
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set helplang=ja
set history=50
set viminfo='20,\"50
" vim: set ft=vim :
