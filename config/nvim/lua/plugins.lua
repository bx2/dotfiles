-- install packer
-- in case of issues remove it completely: rm -rf ~/.local/share/nvim
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
  use "wbthomason/packer.nvim"

  -- colors
  use "siduck76/nvim-base16.lua"

  -- status line
  -- wip
  use {
  "glepnir/galaxyline.nvim",
    branch = "main",
    config = function() require"statusline" end,
    requires = {"kyazdani42/nvim-web-devicons"},
  }

  -- fuzzy search
  -- wip
  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
  }

  -- code highlight and indents
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- mark indent levels
  use {
    "lukas-reineke/indent-blankline.nvim",
    branch = "lua",
  }

  -- code formatting
  -- wip
  use "sbdchd/neoformat"

  -- lsp & autocompletion
  use {
    "neovim/nvim-lspconfig",
    requires = {"kabouzeid/nvim-lspinstall", "onsails/lspkind-nvim"},
  }
  use "hrsh7th/nvim-compe"

  -- snippets
  use "hrsh7th/vim-vsnip"
  use "rafamadriz/friendly-snippets"

  -- git markers
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("gitsigns").setup()
    end
  }

  -- comment toggle
  -- wip
  -- better shortcuts, currently gcc
  use {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end
  }

  -- tree file navigation
  -- wip
  -- add shortcuts
  use {
    "kyazdani42/nvim-tree.lua",
  }

end,
  {
    display = {
      border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
    }
  }
)
