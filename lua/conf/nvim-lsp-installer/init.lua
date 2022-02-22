local lspinstaller_ok, lspinstaller = pcall(require, 'nvim-lsp-installer')
if not lspinstaller_ok then
  return
end

-- require('conf/nvim-lsp-installer/custom-servers/ls_emmet')

lspinstaller.settings({
  install_root_dir = vim.fn.stdpath("config") .. "/lsp_servers",
})


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

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = 0 }
  -- mappings
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gT', vim.lsp.buf.type_definition, opts)
  map('n', 'gI', vim.lsp.buf.implementation, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map('n', '<leader>f', vim.lsp.buf.formatting, opts)
  map('n', '<F2>', vim.lsp.buf.rename, opts)
  map('n', '<leader>la', '<cmd>Telescope diagnostics<cr>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup format_on_save
        autocmd!
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_document_hightlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
end

local custom_server_options = {
  ['sumneko_lua'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true
      on_attach(client, bufnr)
    end
    opts.settings = {
      Lua = {
        diagnostics = {
          enable = true,
          disable = {
            'different-requires',
          },
          globals = { 'vim', 'P', 'R', 'it', 'describe', 'before_each', 'after_each'},
        },
        format = {
          enable = true,
        },
        runtime = {
          path = {'?.lua', '?/init.lua'}
        }
      },
    }
  end,

  ['tsserver'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end
  end,
  ['html'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end
  end,
  ['jsonls'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end
    opts.settings = {
      json = {
        format = { enable = true },
        schemas = {
          {
            fileMatch = { 'tsconfig.json', 'jsconfig.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
          {
            fileMatch = { 'deno.json', 'deno.jsonc' },
            url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
          },
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { '.prettierrc' },
            url = 'https://json.schemastore.org/prettierrc.json',
          },
        },
      },
    }
  end,
  ['yamlls'] = function(opts)
    opts.settings = {
      yaml = {
        schemas = {
          {
            fileMatch = {"docker-compose.yml", 'docker-compose.yaml'},
            url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"
          }
        }
      }
    }

  end
}

lspinstaller.on_server_ready(function(server)
  local options = {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  if custom_server_options[server.name] then
    custom_server_options[server.name](options)
  end

  server:setup(options)
end)

-- gopls
require('lspconfig').gopls.setup({
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})
