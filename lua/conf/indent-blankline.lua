local indent_ok, indent = pcall(require, 'indent_blankline')
if not indent_ok then
  print('Indent_blankline not loaded')
  return
end

-- vim.cmd([[highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline]])

indent.setup({
  show_current_context = true,
  show_current_context_start = true,
  filetype_exclude = { 'git', 'diff', 'man', 'vim-plug', 'help', 'markdown', 'text', 'coc-explorer', 'NvimTree' },
  buftype_exclude = { 'terminal' },
  use_treesitter = true,
  show_first_indent_level = true,
  context_highlight = 'Function',
  context_patterns = { 'function', 'class', 'method', 'if', 'for', 'while', 'object', 'table', 'dictionary' },
  disable_with_nolist = true,
  -- char_highlight_list = {'IndentBlanklineContextChar', 'IndentBlanklineContextStart'},
  -- space_char_highlight_list = {'IndentBlanklineContextChar', 'IndentBlanklineContextStart'},
  -- show_trailing_blankline_indent = false,
  -- char = "▏",
})


if vim.opt.diff:get() then
  vim.g.indent_blakline_enabled = false
end
