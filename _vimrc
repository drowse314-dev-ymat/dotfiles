" ================
" Program options.
" ================
set nocompatible
set visualbell
set title
set viminfo='20,\"50
" loading etc.
set autoread
set ttyfast
set lazyredraw
set hidden
" backup
set nobackup
set writebackup
set backupcopy=yes

" ===========
" Extensions.
" ===========

" ++++++++++++
" >> NeoBundle
" ++++++++++++
if has('vim_starting')
    set runtimepath+=~/vim_share/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/vim_share/bundle'))
let g:neobundle_default_git_protocol='https'
" general
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/pdftotext.git'
NeoBundle 'mattn/benchvimrc-vim.git'
NeoBundle 'kien/ctrlp.vim.git'
" edit
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'mattn/emmet-vim.git'
" colors & appearance
NeoBundle 'ciaranm/inkpot.git'
NeoBundle 'jnurmine/Zenburn.git'
NeoBundle 'vim-scripts/BusyBee.git'
NeoBundle 'vim-scripts/jellybeans.vim.git'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'vim-scripts/Sorcerer.git'
NeoBundle 'itchyny/lightline.vim'
" syntax
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'elzr/vim-json.git'
NeoBundle 'kchmck/vim-coffee-script.git'
NeoBundle 'majutsushi/tagbar.git'
filetype plugin indent on
" ++++++++++++
" << NeoBundle
" ++++++++++++

" ++++++++++++++
" >> theNERDTree
" ++++++++++++++
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap tr :NERDTreeToggle<CR>
nnoremap tp :NERDTree<Space>
" ++++++++++++++
" << theNERDTree
" ++++++++++++++

" ++++++++++++++++
" >> Neocomplcache
" ++++++++++++++++
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
set completeopt-=preview
" ++++++++++++++++
" << Neocomplcache
" ++++++++++++++++

" ++++++++++++++++
" >> lightline.vim
" ++++++++++++++++
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

" always show status line
set laststatus=2
" ++++++++++++++++
" << lightline.vim
" ++++++++++++++++

" ++++++++++++
" >> emmet-vim
" ++++++++++++
let g:user_emmet_settings = {
\    'lang': 'ja',
\}
" ++++++++++++
" << emmet-vim
" ++++++++++++

" +++++++++
" >> Ctrl-P
" +++++++++
nnoremap tb :CtrlPBuffer<CR>
let g:ctrlp_map = '<Nop>'
let g:ctrlp_match_window = 'bottom,order:ttb,min:6,max:' . &lines
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("t")': ['<C-o>'],
    \ 'OpenMulti()':          ['<C-m>'],
    \ 'PrtExit()':            ['<esc>', '<c-c>', '<C-e>'],
    \ 'PrtCurEnd()':          ['<c-g>'],
\}
let g:ctrlp_switch_buffer = 1
let g:ctrlp_working_path_mode = 'ra'
" +++++++++
" << Ctrl-P
" +++++++++

" +++++++++
" >> Tagbar
" +++++++++
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
"let g:tagbar_compact = 1
let g:tagbar_iconchars = ['<>', '<->']
let g:tagbar_map_jump = '<C-j>'
let g:tagbar_width = 35
nnoremap tgb :TagbarToggle<CR>
" +++++++++
" << Tagbar
" +++++++++

" =====================
" Command line options.
" =====================
set history=50
" commands etc.
set wildmenu
set showcmd
" search
set hlsearch
set wrapscan
set incsearch
set ignorecase
set smartcase

" ===========
" UI options.
" ===========

syntax enable
" line number & ruler, etc.
set number
function! ToggleRelativeNumber()
    if &number
        set relativenumber
    else
        set number
    endif
endfunction
nnoremap <leader>n :call ToggleRelativeNumber()<CR>
set ruler
set cursorline
set cursorcolumn
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set scrolloff=3
nnoremap <C-p> :echo expand('%:p')<CR>

" >> rendering
" ++++++++++++
set showmatch
" for unicodes
set ambiwidth=double
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,shift-jis,cp932,latin1
set fileformats=unix,dos,mac
" <tab> width in view
set tabstop=8
" ++++++++++++
" << rendering

" >> color settings
" +++++++++++++++++
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
" +++++++++++++++++
" << color settings

" >> edit
" +++++++
set backspace=indent,eol,start
set expandtab
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
" +++++++
" << edit

" ===============
" Other Keybinds.
" ===============

nnoremap j gj
nnoremap k gk
nnoremap <Tab> %
inoremap <C-@> <C-[>

" << Tabpages
" +++++++++++
nnoremap tn :tabnew<CR>

" for moving tab
function! CurrentTabToLast()
    let current = tabpagenr()
    let to_move = bufname('%')
    execute 'tabmove ' . tabpagenr('$')
    execute 'normal ' . current . 'gt'
    redraw
    echomsg 'moved to last: "' . to_move . '".'
endfunction
nnoremap tl :call CurrentTabToLast()<CR>

function! MoveTabToVisualIndex(index)
    let index = a:index - 1
    execute 'tabmove ' . index
endfunction
command! -nargs=1 ReadableTabMove :call MoveTabToVisualIndex(<args>)
nnoremap tm :execute "ReadableTabMove "<Space>.<Space>

" for switching tab
set swb=usetab
" +++++++++++
" << Tabpages

" ==============
" Site settings.
" ==============
source ~/site_vimrc
