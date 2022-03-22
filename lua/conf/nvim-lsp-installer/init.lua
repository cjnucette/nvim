local lspinstaller_ok, lspinstaller = pcall(require, 'nvim-lsp-installer')
if not lspinstaller_ok then
  return
end

local saga_ok, _ = pcall (require,'lspsaga')
local telescope_ok, _ = pcall (require,'telescope')

-- require('conf/nvim-lsp-installer/custom-servers/ls_emmet')

lspinstaller.settings({
  install_root_dir = vim.fn.stdpath('config') .. '/lsp_servers',
})

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

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local setup_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(setup_capabilities())

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = 0 }
  -- mappings
  if not saga_ok then
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', '<F2>', vim.lsp.buf.rename, opts)
  end

  if not telescope_ok then
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gT', vim.lsp.buf.type_definition, opts)
    map('n', 'gI', vim.lsp.buf.implementation, opts)
  end

  map('n', '<leader>f', '<cmd>Format<cr>', opts)

  if client.resolved_capabilities.document_formatting then
    augroup('FormatOnSave', {})
    autocmd('BufWritePre', { group = 'FormatOnSave', buffer = bufnr, callback = function() vim.lsp.buf.formatting_sync() end })

    -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()']])
  end

  if client.resolved_capabilities.document_highlight then
    augroup('HightlightWordUnderCursor', {})
    autocmd('CursorHold', { group = 'HightlightWordUnderCursor', buffer = bufnr, callback = function() vim.lsp.buf.document_highlight() end })
    autocmd('CursorMoved', { group = 'HightlightWordUnderCursor', buffer = bufnr, callback = function() vim.lsp.buf.clear_references() end })
  end
end

local custom_server_options = {
  ['sumneko_lua'] = function(opts)

    local library = {}
    local function add(lib)
      for _, p in pairs(vim.fn.expand(lib, false, true)) do
        p = vim.loop.fs_realpath(p)
        library[p] = true
      end
    end

    add('$VIMRUNTIME')
    add('~/.config/nvim')
    add('~/.config/nvim/plugged/*')

    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.document_range_formatting = true
      on_attach(client, bufnr)
    end

    opts.on_new_config = function(config, root)
      local libs = vim.tbl_deep_extend('force', {}, library)
      libs[root] = nil
      config.settings.Lua.workspace.library = libs
      return config
    end
    opts.settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        diagnostics = {
          enable = true,
          disable = {
            'different-requires',
          },
          globals = { 'vim', 'P', 'R', 'it', 'describe', 'before_each', 'after_each' },
        },
        format = {
          enable = true,
        },
        completion = {
          callSnippet = 'Replace',
        },
        workspace = {
          library = library,
          checkThirdParty = false,
        },
        telemetry = {
          enable = false
        }
      },
    }
  end,
  ['tsserver'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end
  end,
  ['denols'] = function(opts)
    opts.root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc', 'deps.ts')
  end,
  ['html'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end
  end,
  ['jsonls'] = function(opts)
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end
    opts.settings = {
      json = {
        format = { enable = true },
        schemas = vim.list_extend(
        {
            {
              description = 'Deno tsconfig replacement',
              name = 'deno.json[c]',
              fileMatch = { 'deno.json', 'deno.jsonc' },
              url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
            },
        },
            require('schemastore').json.schemas()
        ),
      },
    }
  end,
  ['yamlls'] = function(opts)
    opts.settings = {
      yaml = {
        schemas = require('schemastore').json.schemas()
      }
    }

  end,
  ['taplo'] = function(opts)
    opts.settings = {
      toml = {
        schemas = {
          {
            fileMatch = { 'Cargo.toml' },
            url = 'https://taplo.tamasfe.dev/schemas/cargo.toml.json'
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
