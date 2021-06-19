-- global aliases
local cmd = vim.cmd
local g = vim.g

-- globals
require "settings"
require "mappings"
require "plugins"

-- plugins configuration
require "plg_lsp"
require "plg_completion"
require "plg_treesitter"

-- color scheme
local base16 = require "base16"
base16(base16.themes["spacemacs"], true)

-- blankline

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false
