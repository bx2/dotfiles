local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
	ensure_installed = {
		"javascript",
		"html",
		"css",
		"bash",
		"lua",
		"json",
		"c",
		"cpp",
		"python",
		"rust",
		"go",
		"gomod",
		"comment",
		"dockerfile",
		"yaml",
	},
	indent = {
		enable = true
	},
	highlight = {
		enable = true,
		use_languagetree = true
	},
}
