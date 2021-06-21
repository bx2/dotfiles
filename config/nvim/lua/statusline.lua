local gl = require("galaxyline")
local gls = gl.section
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")

-- do not show the statusline in utility windows
gl.short_line_list = {"NvimTree", "packer"}
gls.short_line_left = {}
gls.short_line_right = {}

-- full status line
gls.left[1] = {
  FirstElement = {
    provider = function() return "ﱦ" end,
    separator = " ",
  },
}

-- vim mode
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',v= 'VISUAL',V= 'VISUAL LINE', [''] = 'VISUAL BLOCK'}
      return alias[vim.fn.mode()]
    end,
    separator = " ",
  },
}

-- file info
gls.left[3] ={
  FileIcon = {
    provider = {"FileIcon", "FileName"},
    condition = condition.buffer_not_empty,
    separator = " "
  },
}

-- git branch info
gls.left[4] = {
    GitIcon = {
        provider = {"GitBranch"},
        icon = " ",
        condition = condition.check_git_workspace,
        separator = " "
    }
}
