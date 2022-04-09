local neotree_ok, neotree = pcall(require, 'neo-tree')
if not neotree_ok then return end

local map = require('utils').map;
-- local map, signs = table.unpack(require('utils'))

local config = {
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        -- NOTE: you can set any of these to an empty string to not show them
        added     = "+", -- 002b: +
        deleted   = "", -- f655: 
        modified  = "·", -- 00b7: ·
        renamed   = "", -- f553: 
        -- Status type
        untracked = "?", -- 003f: ?
        ignored   = "ﯰ", -- 
        unstaged  = "",
        staged    = "", -- f634: 
        conflict  = "",
      },
      align = "right",
    },
  },
  window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
    width = 30,
    position = 'float',
    popup = { -- settings that apply to float position only
      size = {
        height = "70%",
        width = "50%",
      },
    },
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },
  filesystem = {
    bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
  },
}

neotree.setup(config);

-- mappings
map('n', '<leader>e', '<cmd>NeoTreeReveal<CR>')
-- map('n', '<leader>ef', '<cmd>NeoTreeFloatToggle<CR>')
