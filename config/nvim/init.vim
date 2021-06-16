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
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'psf/black', { 'branch': 'stable' }
  Plug 'hashivim/vim-hashicorp-tools'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
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
set completeopt=menuone,noinsert,noselect

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

" LSPs configuration
let g:omnicomplete_fetch_full_documentation = 1
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require'completion'.on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

" use <Tab> to autocomplete
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" black config
"let g:black_virtualenv = "~/.virtualenvs/neovim3"

" nvim python hosts
let g:python_host_prog="~/.virtualenvs/neovim2/bin/python"
let g:python3_host_prog="~/.virtualenvs/neovim3/bin/python"

" indent
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufWritePre *.py execute ':Black'

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
