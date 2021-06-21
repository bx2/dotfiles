local g = vim.g

g.nvim_tree_side = "left"
g.nvim_tree_width = 35
g.nvim_tree_ignore = {}
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 0
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ":t"
g.nvim_tree_tab_open = 0
g.nvim_tree_allow_resize = 1
g.nvim_tree_gitignore = 1
g.nvim_tree_disable_netrw = 1
g.nvim_tree_hijack_netrw = 1

g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 0
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    folder = {
        default = "▸",
        open = "▾",
        symlink = "◆",
        empty = "▹",
        empty_open = "▿",
        symlink_open = "◇"
    }
}
