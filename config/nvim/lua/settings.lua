-- global aliases
local cmd = vim.cmd
local g = vim.g

-- options with proper locality
-- o: global options, b: buffer options, w: window options.
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

-- globals
g.mapleader = ","
g.auto_save = 0
g.netrw_banner = 0

-- colors
cmd "syntax on"

-- settings
opt("o", "compatible", false)
opt("o", "showmode", false)
opt("w", "number", true)
opt("o", "numberwidth", 2)
opt("o", "hidden", true)
opt("o", "cmdheight", 2)
opt("o", "termguicolors", true)
opt("o", "backup", false)
opt("o", "writebackup", false)
opt("o", "backspace", "indent,eol,start")
opt("o", "swapfile", false)
opt("o", "wrap", false)
opt("o", "visualbell", false)
opt("o", "errorbells", false)
opt("o", "cursorline", true)
opt("o", "splitright", true)
opt("o", "splitbelow", true)
opt("o", "autowrite", true)
opt("o", "autowriteall", true)
opt("o", "hlsearch", true)
opt("o", "ignorecase", true)
opt("o", "incsearch", true)
opt("o", "smarttab", true)
opt("o", "joinspaces", false)
opt("o", "title", true)
opt("o", "wildmenu", true)
opt("o", "smartcase", true)
opt("o", "smarttab", true)
opt("o", "tabstop", 2)
opt("o", "softtabstop", 2)
opt("o", "shiftwidth", 2)
opt("o", "shiftround", true)
opt("o", "expandtab", true)
opt("o", "updatetime", 300)
opt("o", "signcolumn", "yes")
opt("o", "listchars", "trail:·")
opt("o", "completeopt", "menuone,noinsert,noselect")
