" This must be first, because it changes other options as side effect
set nocompatible

"" Plugins {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"" }}}

"" Syntax highlighting {{{
syntax enable
set background=dark
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"let g:solarized_termcolors=256 " 16 | 256
"let g:solarized_termtrans=0 " 0 | 1
"let g:solarized_degrade=0 " 0 | 1
"let g:solarized_bold = 1 | 0
"let g:solarized_underline = 1 | 0
"let g:solarized_italic = 1 | 0
"let g:solarized_contrast='high' " normal | high or low
"let g:solarized_visibility='high' " normal | high or low
colorscheme solarized
"" }}}

"" Indentation {{{
set tabstop=8
set softtabstop=2
set shiftwidth=2
set colorcolumn=80
set expandtab
"let g:indentLine_char = '|'
let g:indentLine_char = '·'
"let g:indentLine_enabled = 0
set listchars=tab:▸\ ,eol:¬
"" }}}

"" UI Config {{{
set number
set showcmd
"set cursorline
filetype plugin indent on " load filetype-specific indent files
set wildmenu              " visual autocomplete for command menu
set lazyredraw            " redraw only when we need to
set showmatch             " highlight matching [{()}]
set matchpairs+=<:>       " match < and > as well
if has('gui_running')
  set guifont=Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline:h14
endif

set title
set hidden
nnoremap <right> :bnext<cr>
nnoremap <left> :bprevious<cr>
nnoremap <up> :enew<cr>
nnoremap <down> :bdelete<cr>
nnoremap <S-right> <C-w>l
nnoremap <S-left> <C-w>h
nnoremap <S-up> <C-w>k
nnoremap <S-down> <C-w>j
"" }}}

"" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " filename only
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
set laststatus=2
set noshowmode
"" }}}

"" GitGutter {{{
"let g:gitgutter_diff_args = '-w'
set updatetime=750
"" }}}

"" Searching {{{
set ignorecase            " case-insensitive search
set smartcase             " upper-case sensitive search
set incsearch             " search as characters are entered
set hlsearch              " highlight matches
" clear search highlight with \<space>
nnoremap <leader><space> :nohlsearch<CR>
"" }}}

"" Folding {{{
set foldenable            " enable folding
set foldlevelstart=10     " open most folds by default
set foldnestmax=10        " 10 nested fold max
set foldmethod=syntax     " fold based on indent level
"" }}}

" vim:foldmethod=marker:foldlevel=0:
