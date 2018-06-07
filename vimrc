" This must be first, because it changes other options as side effect
set nocompatible

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undofile
set undodir=~/.vim/undo//

"" Plugins {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"" }}}

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_eslint_exe='$(yarn bin)/eslint'
let g:sql_type_default = 'pgsql'

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
"" }}}

"" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " filename only
let g:airline#extensions#tabline#buffer_nr_show = 1
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
nnoremap <leader>/ :nohlsearch<CR> " clear highlighted search results
"" }}}

"" Folding {{{
set foldenable            " enable folding
set foldlevelstart=10     " open most folds by default
set foldnestmax=10        " 10 nested fold max
"set foldmethod=syntax     " fold based on indent level
set foldmethod=manual     " syntax is too expensive?
"" }}}

" vim:foldmethod=marker:foldlevel=0:
