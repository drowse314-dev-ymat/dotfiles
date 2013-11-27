" @vimonly
" General options.
set nocompatible
" ~@vimonly
set nobackup
set writebackup
set backupcopy=yes
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
let g:neobundle_default_git_protocol='https'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'ciaranm/inkpot.git'
NeoBundle 'jnurmine/Zenburn.git'
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'vim-scripts/BusyBee.git'
NeoBundle 'vim-scripts/jellybeans.vim.git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/pdftotext.git'
NeoBundle 'mattn/emmet-vim.git'
NeoBundle 'elzr/vim-json.git'
NeoBundle 'kchmck/vim-coffee-script.git'
NeoBundle 'vim-scripts/Sorcerer.git'
" ++++++++++++++
" --theNERDTree++++++++++
nmap <Leader>t :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ++++++++++
" --Neocomplcache++++++++++
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
set completeopt-=preview
" ++++++++++
" --lightline.vim++++++++++
let g:lightline = {
\    'colorscheme': 'jellybeans',
\    'active': {
\        'left': [
\            ['mode', 'paste'],
\            ['fugitive', 'filename'],
\        ],
\        'right': [
\            ['lineinfo'],
\            ['percent'],
\            ['fileformat', 'fileencoding', 'filetype'],
\        ],
\    },
\    'component_function': {
\        'mode': 'MyMode',
\        'fugitive': 'MyFugitive',
\        'filename': 'MyFilename',
\        'fileformat': 'MyFileformat',
\        'fileencoding': 'MyFileencoding',
\        'filetype': 'MyFiletype',
\    },
\    'subseparator': {'left': '⮁', 'right': '⮃'},
\}

function! MyMode()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree.*' ? ' NERDTree ' :
        \ winwidth('.') > 60 ? ' ' . lightline#mode() . ' ' : ''
endfunction

function! MyFugitive()
    try
        if expand('%:t') !~? 'NERD' && exists('*fugitive#head')
            let mark = '⭠ '
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFilename()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree.*' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[-]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyReadonly()
    return &ft !~? 'help' && &readonly ? '⭤' : ''
endfunction

function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'none') : ''
endfunction
" ++++++++++
" --emmet-vim++++++++++
let g:user_emmet_settings = {
\    'lang': 'ja',
\}
" ++++++++++


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
colorscheme jellybeans
" dynamic colors
noremap <expr><S-t> ":let g:zenburn_high_Contrast=0<CR> :colorscheme zenburn<CR>"
noremap <expr><S-y> ":let g:zenburn_high_Contrast=1<CR> :colorscheme zenburn<CR>"
noremap <expr><C-c> ":colorscheme inkpot<CR>"
noremap <expr><S-j> ":colorscheme jellybeans<CR>"
noremap <expr><S-b> ":colorscheme BusyBee<CR>"
noremap <expr><C-l> ":colorscheme landscape<CR>"
noremap <expr><C-o> ":colorscheme sorcerer<CR>"

" ----edit
set backspace=indent,eol,start
set expandtab
set showmatch
" for tab width
function! MyTabWidth()
    let shorttab = ['ruby', 'html']
    if (index(shorttab, &filetype) > -1)
        let tabwidth = 2
    else
        let tabwidth = 4
    endif
    return tabwidth
endfunction
" <tab> is replced with spaces:
autocmd FileType * execute 'set softtabstop=' . MyTabWidth()
" in auto-mode
autocmd FileType * execute 'set shiftwidth=' . MyTabWidth()
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
