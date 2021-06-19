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
	-- wip
	use "siduck76/nvim-base16.lua"

	-- code highlight and indents
	-- wip
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}

	-- mark indent levels
	-- wip
	use {
		"lukas-reineke/indent-blankline.nvim",
		branch = "lua"
	}

	-- code formatting
	-- wip
	use "sbdchd/neoformat"

	-- lsp & autocompletion
	use {
		"neovim/nvim-lspconfig",
		requires = {"kabouzeid/nvim-lspinstall", "onsails/lspkind-nvim"},
	}

	-- done
	use "hrsh7th/nvim-compe"
end,
{
	display = {
		border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
	}
}
)
