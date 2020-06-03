" vim:foldmethod=marker:foldlevel=0:

" This must be the first viml statement, because it changes other options as
" side effect
set nocompatible

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undofile
set undodir=~/.vim/undo//

" ViM built-in fuzzy-finding
set path+=**
set wildignore+=**/dist/**
set wildignore+=**/node_modules/**
set wildignore+=**/tmp/**
set wildignore+=**/vendor/**

let g:gutentags_cache_dir = '~/.vim/tags//'
let g:gutentags_file_list_command = {
\   'markers': {
\       '.git': 'git ls-files',
\   },
\}
let g:gutentags_ctags_executable_ruby = 'ripper-tags'

set splitbelow
set splitright

"" NERDTree {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1

autocmd StdinReadPre * let s:std_in=1

" Open NERDTree when started without arguments, or if the argument is a directory.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Automatically close NERDTree or the quickfix/location-list window if it's the last thing open.
autocmd BufEnter * if (winnr('$') == 1 && (&buftype == 'quickfix' || exists('b:NERDTree') && b:NERDTree.isTabTree())) | q | endif

"nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <silent> - :NERDTreeFind<CR>
"" }}}

" Templates
au BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl

"" Plugins {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"" }}}

"" Syntax highlighting {{{

syntax enable

" autodetect from COLORFGBG environment variable
" TODO: This seems to happen automagically now?
"set background&

if $TERM_PROGRAM != 'Apple_Terminal'
  set termguicolors
endif
colorscheme solarized8
" Toggle between dark and light mode (yay)
call togglebg#map('<F5>')

let g:solarized_extra_hi_groups = 1
let g:solarized_statusline = 'flat'

let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_sign_column_always = 1

let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_options = '--cache --cache-location ~/.eslintcache/'

let g:ale_lint_on_text_changed = 'normal' " `always' (the default) is too slow!

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:airline#extensions#ale#enabled = 1

let g:sql_type_default = 'pgsql'
"" }}}

"" Indentation {{{
set tabstop=8
set softtabstop=2
set shiftwidth=2
set colorcolumn=80
set expandtab
let g:indentLine_char = '·'
"let g:indentLine_char = '|'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 0
"let g:indentLine_setColors = 0
"let g:indentLine_showFirstIndentLevel = 1
"let g:vim_json_syntax_conceal = 0
let g:indent_guides_start_level = 2
set showbreak=↪
set listchars=tab:▶—,eol:↲,nbsp:␣,space:·,extends:⟩,precedes:⟨
"" }}}

"" UI Config {{{
set number
set relativenumber
set showcmd
filetype plugin indent on " load filetype-specific indent files
set wildmenu              " visual autocomplete for command menu
set lazyredraw            " redraw only when we need to

" Cursor
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
  au WinLeave * setlocal nocursorcolumn nocursorline
augroup END

let &t_SI .= "\<Esc>[5 q" "SI = INSERT mode
let &t_SR .= "\<Esc>[4 q" "SR = REPLACE mode
let &t_EI .= "\<Esc>[1 q" "EI = NORMAL mode (ELSE)
set ttimeoutlen=25

" Matching 💯
set showmatch
runtime! macros/matchit.vim

if has('gui_running') && has('gui_macvim')
  " Use patched font that (mostly) matches our terminal font...
  set guifont=mononoki-Regular:h14

  " No scrollbars!
  set guioptions=
endif

set iconstring=%(%{TabooTabTitle(tabpagenr())}%)\ —\ %(tab\ %{tabpagenr()}\/%{tabpagenr(\'$\')}%)
set icon

" TODO: Update Terminal.app's current working directory when we do a :cd in ViM.
"
" The working directory and location of the current document may be set using the Operating System Command (OSC) escape sequence:
"
"	ESC ] Ps ; Pt BEL
"
" The parameter Ps is either 6 (document) or 7 (working directory) and Pt is a “file:” URL. The URL should include a hostname to disambiguate local and remote paths, and characters must be percent-encoded as appropriate.
"
"autocmd DirChanged global execute 'silent !echo -ne k' . ''
"" }}}

"" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.modified = '†'

" Airline will show us the mode; no need to double up on it.
set noshowmode

" No need to show this super redundant information...
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

""" Tabline {{{
let g:airline#extensions#tabline#enabled = 1

" TODO: I don't see any point in showing a close button, even in mouse mode?
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#close_symbol = '✘'

" We care less about buffers, per se, and more about splits-per-tab. This
" enables the functionality we want.
let g:airline#extensions#tabline#show_buffers = 0

" Keep abandoned buffers open, but hidden.
set hidden

" Always show the tab count, even if there's only one tab.
let g:airline#extensions#tabline#show_tab_count = 2

" Don't show `tabs' label or tab numbers on tabs.
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#tabs_label = ''

" This affects buffer (split) filenames in the tabline, but not tab filenames.
" TODO: Why is the quickfix and location list still showing as `[No Name]'?
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Use Taboo to make our tabs look pretty.
let g:taboo_tab_format = '⿹%U%m %r (%S)'
let g:taboo_renamed_tab_format = '⿹%U%m •%l'
" TODO: There has to be a better symbol to represent _blank_ or _new_.
let g:taboo_unnamed_tab_label = 'Ϟ'
let g:taboo_modified_tab_flag = '†'
""" }}}
"" }}}

"" GitGutter {{{
set updatetime=750
" Always show the sign column, even when there are no signs.
set signcolumn=yes
" Let GitGutter use `Diff*' highlight groups (if any)
" TODO: This makes the gutter weird in iTerm.app
"let g:gitgutter_set_sign_backgrounds = 1
" Let other plugins (i.e. linters) clobber GitGutter signs.
let g:gitgutter_sign_priority = -10
" https://github.com/airblade/vim-gitgutter/issues/614
" https://github.com/airblade/vim-gitgutter/commit/f458f43cf2f356fde1de85e2ec74ac2af774ffd4
"highlight! link SignColumn LineNr
"" }}}

"" Searching {{{
set ignorecase            " case-insensitive search
set smartcase             " upper-case sensitive search
set incsearch             " search as characters are entered
set hlsearch              " highlight matches

" Make double (in normal mode) and triple (in other modes) <Esc> clear search highlights.
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
"" }}}

"" Folding {{{
set foldenable            " enable folding
set foldlevelstart=10     " open most folds by default
set foldnestmax=10        " 10 nested fold max
set foldmethod=marker     " `syntax' is too expensive!
"" }}}
