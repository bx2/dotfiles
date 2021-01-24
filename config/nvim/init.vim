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
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'psf/black', { 'branch': 'stable' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
  Plug 'stephpy/vim-yaml'
  Plug 'saltstack/salt-vim'
  Plug 'mileszs/ack.vim'
  Plug 'voldikss/vim-floaterm'
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

" coc
let g:coc_global_extensions = [
 \ 'coc-git',
 \ 'coc-snippets',
 \ 'coc-pairs',
 \ 'coc-python',
 \ 'coc-yaml',
 \ 'coc-html',
 \ 'coc-json',
 \ 'coc-phpls',
 \ 'coc-go',
 \ 'coc-clangd',
 \]

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

" Floaterm
let g:floaterm_open_command = 'tabe'
nnoremap <leader>t :FloatermToggle<cr>

" copy 
vnoremap <C-c> "*y

" vimwiki
let g:vimwiki_list = [{
  \ 'name': 'bx2wiki',
  \ 'path': '/Users/bx2/Sync/vimwiki/wiki',
  \ 'path_html':'/Users/bx2/Sync/vimwiki/html',
  \ 'template_path':'/Users/bx2/Sync/vimwiki/templates',
  \ 'css_file': '/Users/bx2/Sync/vimwiki/templates/style.css',
  \ 'css_name': 'css/style.css',
  \ 'diary_rel_path': 'journal/',
  \ 'links_space_char': '_',
  \ 'diary_index': 'index',
  \ 'diary_header': 'Journal',
  \ 'auto_header': 1,
  \ 'auto_diary_index': 0,
  \ 'auto_tags': 1,
  \ 'auto_generate_tags': 1,
  \ 'auto_generate_links': 1,
  \ 'automatic_nested_syntaxes': 1,
  \ 'nested_syntaxes': {'python': 'python', 'c': 'c', 'c++': 'cpp', 'go': 'go', 'php': 'php', 'javascript': 'js', 'html': 'html', 'json': 'json', 'css': 'css'},
  \ 'syntax': 'default', 
  \ 'hl_headers': 1, 
  \ 'ext': '.txt',
  \ 'exclude_files': ['**/index.txt'],
  \ }]

let g:vimwiki_auto_header = 1
let g:vimwiki_dir_link = 'index'

" content search
if executable('ag')
  let g:ackprg = 'ag --vimgrep --nogroup --nocolor --column'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Map <tab> for trigger completion, completion confirm, 
" snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc-go: Organize imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

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

" insert today's date
nnoremap ,dd :pu=strftime('%b %d, %Y')<cr>
nnoremap ,dt :pu=strftime('%X')<cr>
nnoremap ,ds :pu=strftime('%Y%m%d%H%M%S')<cr>

" window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" if I forget to open a file with sudo
cmap w!! w !sudo tee % >/dev/null
