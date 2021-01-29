set fileencodings=utf-8
set encoding=utf-8 
let mapleader =","
let g:mapleader=","

" install plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" install plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'psf/black', { 'branch': 'stable' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'stephpy/vim-yaml'
  Plug 'saltstack/salt-vim'
call plug#end()

" colors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256 
  source ~/.vimrc_background 
  hi Search ctermbg=magenta ctermfg=black
endif

" general
filetype plugin indent on
syntax on

set t_Co=256
set nocompatible
set noshowmode
set number
set hidden
set cmdheight=2
set nobackup
set nowritebackup
set backspace=indent,eol,start
set termguicolors
set nowrap
set novisualbell
set noerrorbells
set noswapfile
set cursorline
set nojoinspaces
set title
set wildmenu
set smartcase
set splitright
set splitbelow
set autowrite
set autowriteall
set hlsearch
set ignorecase
set incsearch
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set updatetime=300
set shortmess+=c
set signcolumn=yes
set listchars=trail:·

" netrw
let g:netrw_banner=0

" lightline
let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

" fuzzy search
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
let $FZF_DEFAULT_OPTS='--reverse' 
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:fzf_action={
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
nnoremap <c-p> :FZF<cr>

" ripgrep
nnoremap <leader><space> :Rg<Cr>

" copy 
vnoremap <C-c> "*y

" black config
"let g:black_virtualenv = "~/.virtualenvs/neovim3"

" nvim python hosts
let pipenv_venv_path = system('pipenv --venv')
if v:shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:python_host_prog = venv_path . '/bin/python'
  let g:python3_host_prog = venv_path . '/bin/python'
else
  let g:python_host_prog="~/.virtualenvs/neovim2/bin/python"
  let g:python3_host_prog="~/.virtualenvs/neovim3/bin/python"
endif

" indent
autocmd FileType html,javascript,typescript,css setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python,php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType vimwiki setlocal textwidth=72 wrap spell
autocmd BufWritePre *.py execute ':Black'

" latex
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimex_quickfix_mode=0
let g:vimtex_view_automatic=1
let g:vimtex_compiler_latexmk={
\ 'continuous' : 1,
\}

" one shift less
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
