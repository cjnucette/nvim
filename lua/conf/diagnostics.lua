local signs = require('utils').signs
local map = require('utils').map
local saga_ok = pcall(require, 'lspsaga')

if not saga_ok then
  vim.diagnostic.config({
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      show_header = false,
      source = 'always',
      border = 'rounded',
      prefix = ' '
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

  local diagnostic_active = true
  local toggle_diagnostics = function()
    diagnostic_active = not diagnostic_active
    if diagnostic_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end

  -- mappings
  map('n', '<leader>dn', vim.diagnostic.goto_next)
  map('n', '<leader>dp', vim.diagnostic.goto_prev)
  map('n', '<leader>ds', vim.diagnostic.open_float)
  map('n', '<leader>da', vim.diagnostic.setloclist)
  map('n', '<leader>dt', toggle_diagnostics)
end

-- Diagnostic Signs
vim.fn.sign_define('DiagnosticSignError', { text = signs.error, texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarning', { text = signs.warning, texthl = 'DiagnosticSignWarning', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = signs.information, texthl = 'DiagnosticSignInfo', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = signs.hint, texthl = 'DiagnosticSignHint', numhl = '' })

-- vim.cmd([[
--   augroup show_line_diagnostics
--     autocmd!
--     autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0, {scope = 'line', border = 'single'})
--   augroup END
-- ]])
