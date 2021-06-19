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
