local library = {}
local function add(lib)
  for _, p in pairs(vim.fn.expand(lib, false, true)) do
    p = vim.loop.fs_realpath(p)
    library[p] = true
  end
end

add('$VIMRUNTIME')
-- add('~/.config/nvim')
add('~/.config/nvim/plugged/*')

return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      format = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        disable = {
          'different-requires',
        },
        globals = { 'vim', 'P', 'R', 'it', 'describe', 'before_each', 'after_each' },
      },
      completion = {
        keywordSnippet = 'Replace',
        callSnippet = 'Replace'
      },
      workspace = {
        library = library,
        checkThirdParty = false,
      },
    },
  }
}
