local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_ok then return end

gitsigns.setup({
  -- enable it
  current_line_blame = true,
  -- configure it
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol'|'overlay'|'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  -- format it
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
})
