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
  Plug 'mileszs/ack.vim'
  Plug 'w0rp/ale'
  Plug 'mhinz/vim-signify'
  Plug 'vim-vdebug/vdebug'
  Plug 'mattn/emmet-vim'
call plug#end()

" general
filetype plugin indent on
syntax on

" options
set mouse=a
set autoread
set completeopt=menu,menuone,preview,noselect,noinsert
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
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
set autowrite
set autowriteall
set autoread
set cursorline
set nojoinspaces
set title
set listchars=trail:·
set incsearch
set laststatus=2
set wildmenu
set ruler
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

let g:signify_vcs_list=['git']

" python setup
let g:python_host_prog='~/.virtualenvs/neovim2/bin/python'
let g:python3_host_prog='~/.virtualenvs/neovim3/bin/python'

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

" Emmet
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key=','
autocmd FileType html,blade,css EmmetInstall

" indent
autocmd FileType html,javascript,typescript,css setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python,php setlocal expandtab shiftwidth=4 softtabstop=4

" linting
let g:ale_lint_on_enter=1
let g:ale_c_parse_makefile=1
let g:ale_fix_on_save=1
let g:ale_linters_explicit=1
let g:ale_set_balloons=1
let g:ale_sign_column_always=1
let g:ale_set_highlights=0
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_c_clang_options = '-std=c11 -Wall'
let g:ale_c_clangd_options = '-std=c11 -Wall'
let g:ale_c_clangtidy_options = '-std=c11 -Wall'
let g:ale_c_gcc_options = '-std=c11 -Wall'
let g:ale_linters={
\ 'c': ['clang', 'clangd', 'clangtidy', 'cquery', 'flawfinder', 'gcc'],
\ 'go': ['gopls', 'gofmt', 'gobuild', 'golint', 'govet'],
\ 'rust': ['cargo'],
\ 'python': ['pyls'],
\ 'php': ['php', 'phpstan', 'phpcs'],
\ 'javascript': ['tsserver', 'eslint'],
\ 'typescript': ['tsserver', 'eslint'],
\ 'json': ['jsonlint'],
\ 'html': [],
\}
let g:ale_fixers={
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'c': ['clang-format', 'uncrustify'],
\ 'go': ['goimports', 'gofmt'],
\ 'rust': ['rustfmt'],
\ 'python': ['black', 'isort'],
\ 'php': ['php_cs_fixer'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'json': ['jq'],
\ 'css': [],
\ 'html': [],
\}
" rust
let g:ale_rust_rls_config={
\ 'rust': {
\   'clippy_preference': 'on'
\  }
\}
"php
let g:ale_php_phan_use_client = 1
let g:ale_php_phan_executable = '/usr/local/bin/phpstan'
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

" vdebug
let g:vdebug_options={
\ 'idekey': 'xdebug',
\ 'ide_key': 'xdebug',
\ 'break_on_open': 1,
\ 'timeout': 30,
\ 'server': '',
\ 'port': '9000',
\ 'path_maps': {"/var/www/devenv": "/Users/bx2/Projects/rtk-console"}
\}

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
