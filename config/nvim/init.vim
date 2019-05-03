let mapleader =","

" install plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" this needs to be enabled before ALE is loaded
let g:ale_completion_enabled=1
let g:ale_set_balloons=1

" install plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'sheerun/vim-polyglot'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'lervag/vimtex'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sleuth'
  Plug 'mileszs/ack.vim'
  Plug 'w0rp/ale'
  Plug 'ledger/vim-ledger'
call plug#end()

" general
filetype plugin indent on
syntax on

" options
set mouse=a
set completeopt=menu,menuone,preview,noselect,noinsert
set termguicolors
set encoding=utf-8
set nowrap
set number
set numberwidth=4
set novisualbell
set noerrorbells
set nobackup
set noswapfile
set pastetoggle=<F2>
set autochdir
set autowrite
set autowriteall
set autoread
set cursorline
set nojoinspaces
set title
set listchars=trail:·
set incsearch
set hlsearch
set ignorecase
set smartcase
set splitright
set splitbelow
set wildignore=*.o,*~,*.pyc

" colors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  hi Search ctermbg=magenta ctermfg=black
endif

" python setup
let g:python_host_prog = '~/.virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '~/.virtualenvs/neovim3/bin/python'

" plugins options
let g:netrw_banner=0

" fuzzy search
let g:fzf_action={
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
nnoremap <c-p> :FZF<cr>

" content search
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" linting
let g:ale_lint_on_enter=1
let g:ale_c_parse_makefile=1
let g:ale_fix_on_save=1
let g:ale_linters_explicit=1
let g:ale_set_balloons=1
let g:ale_sign_column_always=1
let g:ale_set_highlights=0
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_linters={
\ 'c': ['clang', 'clangd', 'clangtidy', 'cquery', 'flawfinder', 'gcc'],
\ 'go': ['gopls', 'gofmt', 'gobuild', 'golint', 'govet', 'staticcheck'],
\ 'python': ['pyls'],
\ 'php': ['php', 'phpstan', 'phpmd', 'phpcs'],
\ 'javascript': ['tsserver'],
\ 'typescript': ['tsserver', 'tslint'],
\}
let g:ale_fixers={
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'c': ['clang-format', 'uncrustify'],
\ 'go': ['goimports', 'gofmt'],
\ 'python': ['black', 'isort'],
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'json': ['prettier'],
\ 'php': ['php_cs_fixer', 'prettier'],
\ 'css': ['prettier'],
\ 'html': ['prettier'],
\}
" ALE colors
highlight ALEErrorSign ctermfg=1 ctermbg=18 guifg=#ff5c57 guibg=#34353e
highlight ALEWartningSign ctermfg=3 ctermbg=18 guifg=#f3f99d guibg=#34353e

nnoremap <C-]> :ALEGoToDefinitionInVSplit<cr>

" latex
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimex_quickfix_mode=0
let g:vimtex_view_automatic=1
let g:vimtex_compiler_latexmk={
\ 'continuous' : 1,
\}

" ledger
let g:ledger_default_commodity='CHF'
let g:ledger_default_commodity_before=0
let g:ledger_default_date_format='%Y-%m-%d'
let g:ledger_commodity_sep=' '
let g:ledger_winpos='R'
let g:ledger_extra_options='--pedantic --explicit --check-payees'

" ledger autocomplete
au FileType ledger inoremap <silent> <tab> <c-r>=ledger#autocomplete_and_align()<cr>

" bindings
nnoremap ; :

" next/previous buffer
nnoremap ,. :bn<cr>
nnoremap ,m :bp<cr>

" remove highlight
nnoremap ,, :noh<cr>

" window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" if I forget to open a file with sudo
cmap w!! w !sudo tee % >/dev/null
