local signs = require("utils").signs

vim.diagnostic.config({
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    show_header = false,
    source = "always",
    border = "single",
  },
  virtual_text = false,
  -- virtual_text = {
  --   spacing = 4,
  --   source = "always",
  --   severity = {
  --     min = vim.diagnostic.severity.HINT,
  --   },
  -- },
})

-- Diagnostic Signs
vim.fn.sign_define("DiagnosticSignError", { text = signs.error, texthl = "DiagnosticSignError", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarning", { text = signs.warning, texthl = "DiagnosticSignWarning", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = signs.info, texthl = "DiagnosticSignInfo", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = signs.hint, texthl = "DiagnosticSignHint", numhl = "" })

-- vim.cmd([[
--   augroup show_line_diagnostics
--     autocmd!
--     autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0, {scope = 'line', border = 'single'})
--   augroup END
-- ]])


-- mappings
local opts = {silent = true, noremap = true}
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>da', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float, opts)

