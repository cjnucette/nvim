local heirline_ok, heirline = pcall(require, 'heirline')
if not heirline_ok then
  return
end

local set = vim.opt
local api = vim.api
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
local signs = require('utils').signs
local capitalize = require('utils').capitalize

-- statusline options
set.laststatus = 2
set.showmode = false
set.cmdheight = 2

-- statusline
local colors = {
  folder = '#ff9e64',
  diag = {
    warning = utils.get_highlight('DiagnosticWarn').fg,
    error = utils.get_highlight('DiagnosticError').fg,
    information = utils.get_highlight('DiagnosticInfo').fg,
    hint = utils.get_highlight('DiagnosticHint').fg,
  },
  git = {
    del = utils.get_highlight('diffDelete').fg,
    add = utils.get_highlight('diffAdd').fg,
    change = utils.get_highlight('diffChange').fg,
  },
}

local Align = {
  provider = '%=',
  hl = { bg = utils.get_highlight('Normal').bg }, -- ???
}

local Space = {
  provider = '  ',
}
local Delimiter = {
  provider = ' ',
}

local Diagnostics = {
  condition = conditions.has_diagnostics,

  init = function(self)
    self.diagnostics = {
      error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
      warning = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
      hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }),
      information = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }),
    }
  end,
  {
    condition = function(self)
      return self.diagnostics['error'] > 0
    end,
    {
      provider = function()
        return (signs.error .. ' ')
      end,
      hl = { fg = colors.diag.error },
    },
    {
      provider = function(self)
        return self.diagnostics['error'] .. ' '
      end,
    },
  },
  {
    condition = function(self)
      return self.diagnostics['warning'] > 0
    end,
    {
      provider = function()
        return (signs.warning .. ' ')
      end,
      hl = { fg = colors.diag.warning },
    },
    {
      provider = function(self)
        return self.diagnostics['warning'] .. ' '
      end,
    },
  },
  {
    condition = function(self)
      return self.diagnostics['information'] > 0
    end,
    {
      provider = function()
        return (signs.information .. ' ')
      end,
      hl = { fg = colors.diag.information },
    },
    {
      provider = function(self)
        return self.diagnostics['information'] .. ' '
      end,
    },
  },
  {
    condition = function(self)
      return self.diagnostics['hint'] > 0
    end,
    {
      provider = function()
        return (signs.hint .. ' ')
      end,
      hl = { fg = colors.diag.hint },
    },
    {
      provider = function(self)
        return self.diagnostics['hint'] .. ' '
      end,
    },
  },
}

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = setmetatable({
      n = { 'Normal', 'N' },
      no = { 'N·Pending', 'N·P' },
      v = { 'Visual', 'V' },
      V = { 'V·Line', 'V·L' },
      [''] = { 'V·Block', 'V·B' },
      s = { 'Select', 'S' },
      S = { 'S·Line', 'S·L' },
      [''] = { 'S·Block', 'S·B' },
      i = { 'Insert', 'I' },
      ic = { 'Insert', 'I' },
      R = { 'Replace', 'R' },
      Rv = { 'V·Replace', 'V·R' },
      c = { 'Command', 'C' },
      cv = { 'Vim·Ex', 'V·E' },
      ce = { 'Ex', 'E' },
      r = { 'Prompt', 'P' },
      rm = { 'More', 'M' },
      ['r?'] = { 'Confirm', 'C' },
      ['!'] = { 'Shell', 'Sh' },
      t = { 'Terminal', 'T' },
    }, {
      __index = function()
        return { 'Unknown', 'U' }
      end,
    }),
  },
  provider = function(self)
    return '--%2(' .. self.mode_names[self.mode][1]:upper() .. '%)--'
  end,
}

local Git = {
  condition = conditions.is_git_repo(),
  init = function(self)
    self.head = vim.g.coc_git_status
    self.status = vim.b.coc_git_status
  end,
  {
    provider = function(self)
      return self.head
    end,
  },
  {
    condition = function(self)
      return self.status
    end,
    provider = function(self)
      return ' | ' .. vim.trim(self.status)
    end,
  },
}

local Ruler = {
  provider = 'Ln %l,Col %c',
}

local TabStop = {
  provider = function()
    return 'Spaces: ' .. vim.bo.tabstop
  end,
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return enc:upper()
  end,
}

local FileFormat = {
  static = {
    fmt = {
      dos = '',
      mac = '',
      unix = '',
    },
  },
  provider = function(self)
    return self.fmt[vim.bo.fileformat]
  end,
}

local FileName = {
  provider = function()
    local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(0), ':.')

    if filename == '' then
      return '[No Name]'
    end

    if not conditions.width_percent_below(#filename, 0.50) then
      filename = vim.fn.pathshorten(filename)
    end

    return filename
  end,
}

local FileIcon = {
  init = function(self)
    local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
    if not devicons_ok then
      return
    end
    local filename = api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  static = {
    filetypes = setmetatable({
      ['css'] = 'CSS',
      ['scss'] = 'Sass',
      ['sass'] = 'Sass',
      ['html'] = 'HTML',
      ['json'] = 'JSON',
      ['javascript'] = 'JavaScript',
      ['javascriptreact'] = 'JavaScriptReact',
      ['typescript'] = 'TypeScript',
      ['typescriptreact'] = 'TypeScriptReact',
    }, {
      __index = function(_, key)
        return capitalize(key)
      end,
    }),
  },
  provider = function(self)
    local ft = self.filetypes[vim.bo.ft]
    return ft and ft
  end,
}

local LSPActive = {
  condition = conditions.lsp_attached,

  provider = ' ',
}

local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = function()
    local lang = ''
    for _, l in ipairs(vim.opt.spelllang:get()) do
      lang = lang .. l
    end
    return '  Spell: ' .. lang
  end,
}

-- local ScrollBar = {
--   static = {
--     sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
--   },
--   provider = function(self)
--     local curr_line = api.nvim_win_get_cursor(0)[1]
--     local lines = api.nvim_buf_line_count(0)
--     local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
--
--     return string.rep(self.sbar[i], 2)
--   end,
-- }

local DefaultStatusLine = {
  Delimiter,
  Diagnostics,
  ViMode,
  Space,
  Git,
  Space,
  Align,
  Space,
  Ruler,
  Space,
  TabStop,
  Space,
  FileEncoding,
  Space,
  FileFormat,
  Space,
  FileIcon,
  FileType,
  LSPActive,
  Spell,
  Delimiter,
}

local Terminal = {
  {
    provider = '  ',
    hl = { fg = colors.folder },
  },
  {
    provider = 'Terminal%=',
  },
}

local TerminalStatusLine = {
  condition = function()
    return conditions.buffer_matches({ buftype = { 'terminal' } })
  end,

  Terminal,
}

local Explorer = {
  {
    provider = '  ',
    hl = { fg = colors.folder },
  },
  {
    provider = 'Explorer%=',
  },
}
local ExplorerStatusLine = {
  condition = function()
    -- return conditions.buffer_matches({ filetype = { 'coc-explorer', 'NvimTree' } })
    return vim.bo.ft == 'coc-explorer' or vim.bo.ft == 'NvimTree'
  end,

  Explorer,
}

local PackagerManager = {
  {
    provider = '  ',
    hl = { fg = colors.folder },
  },
  {
    provider = 'Package Manager%=',
  },
}

local PackagerManagerStatusLine = {
  condition = function()
    return vim.bo.ft == 'vim-plug' or vim.bo.ft == 'packer'
    -- return conditions.buffer_matches({ filetype = { 'vim-plug', 'packer' } }) -- nop
  end,

  PackagerManager,
}

local Http = {
  {
    provider = ' 爵 ',
    hl = { fg = colors.folder },
  },
  {
    provider = 'Http Result%=',
  },
}

local HttpStatusLine = {
  condition = function()
    return vim.bo.ft == 'httpResult'
  end,

  Http,
}

local InactiveStatusLine = {
  condition = function()
    return not conditions.is_active()
  end,

  Delimiter,
  FileIcon,
  FileName,
  Align,
  Delimiter,
}

local Statusline = {
  hl = function()
    -- if not conditions.is_active() then
    --   return {
    --     fg = utils.get_highlight('Statusline').fg,
    --     bg = utils.get_highlight('Statusline').bg,
    --   }
    -- else
    return {
      fg = utils.get_highlight('StatuslineNC').fg,
      bg = utils.get_highlight('StatuslineNC').bg,
    }
    -- end
  end,

  stop_at_first = true,

  TerminalStatusLine,
  ExplorerStatusLine,
  PackagerManagerStatusLine,
  HttpStatusLine,
  InactiveStatusLine,
  DefaultStatusLine,
}
heirline.setup(Statusline)
