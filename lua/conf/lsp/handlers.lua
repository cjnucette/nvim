local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = require('utils').map

local border = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

M.handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local setup_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

M.capabilities = require('cmp_nvim_lsp').update_capabilities(setup_capabilities())

M.on_attach = function(client, bufnr)
  local telescope_ok, _ = pcall(require, 'telescope')
  local saga_ok, _ = pcall(require, 'lspsaga')

  local lsp_format_ok, lsp_format = pcall(require, 'lsp-format')
  if lsp_format_ok then
    lsp_format.setup {}
    lsp_format.on_attach(client)
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = 0 }
  -- mappings
  if not saga_ok then
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0, desc = 'Shows available code actions' })
    map('n', '<F2>', vim.lsp.buf.rename, opts)
  end

  if not telescope_ok then
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gT', vim.lsp.buf.type_definition, opts)
    map('n', 'gI', vim.lsp.buf.implementation, opts)
  end

  map('n', '<leader>f', '<cmd>Format<cr>', { buffer = 0, desc = 'Format current buffer' })

  if not lsp_format_ok then
    if client.server_capabilities.document_formatting then
      augroup('FormatOnSave', { clear = true })
      autocmd('BufWritePre', {
        group = 'FormatOnSave',
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })

      vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting_sync, {})
    end
  end

  if client.server_capabilities.document_highlight then
    augroup('HightlightWordUnderCursor', { clear = true })
    autocmd('CursorHold', {
      group = 'HightlightWordUnderCursor',
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    autocmd('CursorMoved', {
      group = 'HightlightWordUnderCursor',
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

return M
