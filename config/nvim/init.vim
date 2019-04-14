let mapleader =","

" install plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" this needs to be enabled before ALE is loaded
let g:ale_completion_enabled=1

" install plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'chriskempson/base16-vim'
  Plug 'lervag/vimtex'
  Plug 'tpope/vim-commentary'
  Plug 'mileszs/ack.vim'
  Plug 'w0rp/ale'
call plug#end()

" general
filetype plugin indent on
syntax on

" options
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

" colors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  hi Search ctermbg=magenta ctermfg=black
endif

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
let g:ale_go_bingo_executable = 'gopls'
let g:ale_linters_explicit=1
let g:ale_sign_column_always=1
let g:ale_set_highlights=0
let g:ale_linters={
\   'go': ['golint', 'go vet'],
\   'make': ['checkmake'],
\   'vim': ['vint'],
\}
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\}

" latex
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk={
    \ 'continuous' : 1,
    \}
let g:vimtex_view_method='skim'
let g:vimex_quickfix_mode=0
let g:vimtex_view_automatic=1

" bindings
nnoremap ; :

" next/previous buffer
nnoremap ,. :bn<cr>
nnoremap ,m :bp<cr>

" window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" if I forget to open a file with sudo
cmap w!! w !sudo tee % >/dev/null
