local heirline_ok, heirline = pcall(require, 'heirline')
if not heirline_ok then
  return
end

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local Heirline = augroup('Heirline', { clear = true })
autocmd('ColorScheme', { group = Heirline, callback = function()
  require('heirline').reset_highlights()
  vim.cmd('luafile  ~/.config/nvim/lua/conf/heirline.lua')
end })

-- Abbreviations
local api = vim.api
local set = vim.opt

-- Helper and Utilities
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
local signs = require('utils').signs
local capitalize = require('utils').capitalize

-- statusline options
set.laststatus = 3
set.showmode = false
set.cmdheight = 2

-- statusline
local colors = {
  folder = '#ff9e64',
  red = utils.get_highlight('DiagnosticError').fg,
  green = utils.get_highlight('String').fg,
  blue = utils.get_highlight('Function').fg,
  gray = utils.get_highlight('NonText').fg,
  orange = utils.get_highlight('DiagnosticWarn').fg,
  purple = utils.get_highlight('Statement').fg,
  cyan = utils.get_highlight('Special').fg,
  white = '#FFFFFF',
  diag = {
    warning = utils.get_highlight('DiagnosticWarn').fg,
    error = utils.get_highlight('DiagnosticError').fg,
    hint = utils.get_highlight('DiagnosticHint').fg,
    information = utils.get_highlight('DiagnosticInfo').fg,
  },
  git = {
    removed = utils.get_highlight('diffDelete').fg,
    added = utils.get_highlight('diffAdd').fg,
    changed = utils.get_highlight('diffChange').fg,
  },
}

local Align = {
  provider = '%=',
}

local Space = utils.make_flexible_component(1, {
  provider = '  ',
}, { provider = ' ' })

local Delimiter = {
  provider = ' ',
}

local LongDiag = {
  {
    condition = function(self)
      return self.diagnostics['error'] > 0
    end,
    {
      hl = { fg = colors.diag.error },

      provider = function()
        return (signs.error .. ' ')
      end,
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
      hl = { fg = colors.diag.warning },

      provider = function()
        return (signs.warning .. ' ')
      end,
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
      hl = { fg = colors.diag.information },

      provider = function()
        return (signs.information .. ' ')
      end,
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
      hl = { fg = colors.diag.hint },

      provider = function()
        return (signs.hint .. ' ')
      end,
    },
    {
      provider = function(self)
        return self.diagnostics['hint'] .. ' '
      end,
    },
  },
}

local ShortDiag = {
  {
    condition = function(self)
      return self.diagnostics['error'] > 0
    end,
    {
      hl = { fg = colors.diag.error },

      provider = function()
        return '·'
      end,
    },
  },
  {
    condition = function(self)
      return self.diagnostics['warning'] > 0
    end,
    {
      hl = { fg = colors.diag.warning },

      provider = function()
        return '·'
      end,
    },
  },
  {
    condition = function(self)
      return self.diagnostics['information'] > 0
    end,
    {
      hl = { fg = colors.diag.information },

      provider = function()
        return '·'
      end,
    },
  },
  {
    condition = function(self)
      return self.diagnostics['hint'] > 0
    end,
    {
      hl = { fg = colors.diag.hint },

      provider = function()
        return '·'
      end,
    },
  },
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
  utils.make_flexible_component(1, LongDiag, { ShortDiag, Space }),
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

  utils.make_flexible_component(1, {
    hl = { bold = true },

    provider = function(self)
      return self.mode_names[self.mode][1]:upper()
    end,
  }, {
    hl = { bold = true },

    provider = function(self)
      return self.mode_names[self.mode][2]:upper()
    end,
  }),
}

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  -- hl = { fg = colors.orange },

  { -- git branch name
    -- hl = { bold = true },

    provider = function(self)
      return ' ' .. self.status_dict.head
    end,
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  utils.make_flexible_component(1, {
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = ' | ',
    },
    {
      hl = { fg = colors.git.added },

      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ('+' .. count)
      end,
    },
    {
      hl = { fg = colors.git.removed },

      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and ('-' .. count)
      end,
    },
    {
      hl = { fg = colors.git.changed },

      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and ('~' .. count)
      end,
    },
  }, {
    provider = '',
  }),
}

local Ruler = utils.make_flexible_component(1, {
  provider = 'Ln %l,Col %c',
}, {
  provider = '%l,%c',
})

local TabStop = utils.make_flexible_component(1, {
  provider = function()
    return 'Spaces: ' .. vim.bo.tabstop
  end,
}, {
  provider = function()
    return 'S:' .. vim.bo.tabstop
  end,
})

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
  init = function(self)
    local fname = vim.fn.fnamemodify(api.nvim_buf_get_name(0), ':.')

    self.filename = fname ~= '' and fname or '[No Name]'
  end,

  -- hl = { bg = utils.get_highlight('Normal').bg }, -- ???

  utils.make_flexible_component(1, {
    provider = function(self)
      return self.filename
    end,
    {
      condition = function()
        return conditions.buffer_matches({ filetype = { 'markdown', 'text' } })
      end,
      provider = function()
        return ' - ' .. vim.fn.wordcount().words .. ' words'
      end
    }
  }, {
    provider = function(self)
      return vim.fn.pathshorten(self.filename)
    end,
    {
      condition = function()
        return conditions.buffer_matches({ filetype = { 'markdown', 'text' } })
      end,
      provider = function()
        return ':' .. vim.fn.wordcount().words
      end
    }
  }),
}

local FileIcon = {
  init = function(self)
    local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
    if not devicons_ok then return end

    local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(0), ':t')
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
  end,

  hl = function(self)
    return { fg = self.icon_color }
  end,

  provider = function(self)
    return self.icon and (self.icon .. ' ')
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

  provider = '',
  -- provider = '',
}

local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  Space,
  {
    provider = function()
      local lang = ''
      for _, l in ipairs(vim.opt.spelllang:get()) do
        lang = lang .. l
      end
      -- return '  Spell: ' .. lang
      return 'SPELL'
    end,
  }
}

local LiveServer = {
  condition = function()
    return require('live_server').has_start_scripts() or conditions.buffer_matches({ filetype = { 'html', 'css', 'js', 'ts' } })
  end,
  Space,
  {
    condition = function()
      return require('live_server').is_active
    end,

    hl = { fg = colors.green },

    provider = function()
      return ' '
    end,
  },
  {
    condition = function()
      return not require('live_server').is_active
    end,

    provider = function()
      return '睊'
    end,
  }
}

local TerminalStatusLine = {
  condition = function()
    return conditions.buffer_matches({ buftype = { 'terminal' } })
  end,

  Delimiter,
  { condition = conditions.is_active, ViMode, Space },
  {
    hl = { fg = colors.folder },

    provider = '  ',
  },
  {
    provider = 'Terminal%=',
  },
}


local FileExplorerStatusLine = {
  condition = function()
    return conditions.buffer_matches({ filetype = { 'NvimTree' } }) or vim.o.ft == 'neo-tree'
  end,

  Delimiter,
  {
    hl = { fg = colors.folder },

    provider = '  ',
  },
  {
    provider = 'File Explorer%=',
  },
}

local PluginManagerStatusLine = {
  condition = function()
    return vim.bo.ft == 'vim-plug' or vim.bo.ft == 'packer'
    -- return conditions.buffer_matches({ filetype = { 'vim-plug', 'packer' } }) -- nop
  end,

  Delimiter,
  {
    hl = { fg = colors.folder },

    provider = '  ',
  },
  {
    provider = 'Plugin Manager%=',
  },
  Ruler,
  Delimiter,
}

local CheckhealthStatusLine = {
  condition = function()
    return conditions.buffer_matches({ filetype = { 'checkhealth' } })
  end,

  Delimiter,
  {
    hl = { fg = colors.red },

    provider = ' ',
  },
  {
    provider = 'Checkhealth%='
  },
  Ruler,
  Delimiter
}

local HttpStatusLine = {
  condition = function()
    return vim.bo.ft == 'httpResult'
  end,

  Delimiter,
  {
    hl = { fg = colors.folder },

    provider = ' 爵 ',
  },
  {
    provider = 'Http Result%=',
  },
  Ruler,
  Delimiter,
}

local DefaultStatusLine = {
  Delimiter,
  Diagnostics,
  ViMode,
  Space,
  Git,
  Delimiter,
  Align,
  FileName,
  Align,
  Delimiter,
  Ruler,
  Space,
  TabStop,
  Space,
  utils.make_flexible_component(1, { FileEncoding, Space }, { provider = '' }),
  utils.make_flexible_component(1, { FileFormat, Space }, { provider = '' }),
  utils.make_flexible_component(1, { FileIcon, FileType, Delimiter }, FileIcon),
  LSPActive,
  Spell,
  LiveServer,
  Delimiter,
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
  init = utils.pick_child_on_condition,

  hl = function()
    if conditions.is_active() then
      return {
        -- fg = utils.get_highlight('Statusline').fg,
        -- bg = utils.get_highlight('Statusline').bg,
        fg = colors.white,
        bg = utils.get_highlight('PmenuSel').bg,
      }
    else
      return {
        fg = utils.get_highlight('StatuslineNC').fg,
        bg = utils.get_highlight('StatuslineNC').bg,
      }
    end
  end,


  TerminalStatusLine,
  FileExplorerStatusLine,
  PluginManagerStatusLine,
  HttpStatusLine,
  CheckhealthStatusLine,
  InactiveStatusLine,
  DefaultStatusLine,
}

heirline.setup(Statusline)
