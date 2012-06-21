version 6.0

" ----general options
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set nocompatible
set nobackup
set autoread

" ---- extensions
" pathogen
call pathogen#infect('~/Dropbox/Others/vim_share/bundle')
" --neobundle++++++++++
filetype off
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/Dropbox/Others/vim_share/bundle/neobundle.vim/
    call neobundle#rc(expand('~/Dropbox/Others/vim_share/bundle'))
endif
" plugins
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/tpope/vim-pathogen.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
"NeoBundle 'git://github.com/Shougo/unite.vim.git'
"NeoBundle 'git://github.com/tyru/open-browser.vim.git'
" colors
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
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

" ----CLI
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
set laststatus=2
set statusline=%<%t\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%lL/%L:%cC%V%8P
set title
" <tab> width in view
set tabstop=8
" change schemes by filetype
filetype plugin on
" color settings
set t_Co=256
" --for solarized++++++++++
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"set background=dark
" ++++++++++++++
colorscheme zenburn
" dynamic transparency
noremap <expr><S-t> ":hi Normal ctermbg=None<CR> :hi Statement ctermbg=NONE<CR> :hi ColorColumn ctermbg=NONE<CR> :echo ''<CR>"
noremap <expr><C-c> ":colorscheme zenburn<CR> :hi ColorColumn ctermbg=238<CR>"
" colorcolumn
set colorcolumn=80
hi ColorColumn ctermbg=238

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
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap j gj
nnoremap k gk


if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
let &cpo=s:cpo_save
unlet s:cpo_save
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=ja
set history=50
set printoptions=paper:a4
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" vim: set ft=vim :
