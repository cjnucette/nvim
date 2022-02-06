-- highlight lua heredoc
vim.g.vimsyn_embed = "l"

-- hexokinase
vim.g.Hexokinase_optInPatterns = {
  "full_hex",
  "triple_hex",
  "rgb",
  "rgba",
  "hsl",
  "hsla",
  "colour_names",
}
vim.g.Hexokinase_highlighters = { "virtual", "foreground" }

-- vim-markdown
vim.g.vim_markdown_folding_disabled = true
vim.g.vim_markdown_folding_frontmatter = true
vim.g.markdown_fenced_languages = { "html", "css", "javascript", "typescript", "rust", "lua", "vim" }

-- markdown-preview
vim.g.mkdp_auto_start = false

-- matchup
vim.g.matchup_matchpref = {
  html = { tagnameonly = 1 },
  javascript = { tagnameonly = 1 },
  typescript = { tagnameonly = 1 },
  javascriptreact = { tagnameonly = 1 },
  typescriptreact = { tagnameonly = 1 },
  ["javascript.jsx"] = { tagnameonly = 1 },
  ["typescript.tsx"] = { tagnameonly = 1 },
}
vim.g.matchup_matchparen_deferred = true
vim.g.matchup_matchparen_offscreen = { method = "popup", highlight = "ColorColumn" }
vim.g.matchup_matchparen_hi_surround_always = true

-- bracey
vim.g.bracey_server_port = 5000
vim.g.bracey_server_allow_remote_connections = true

-- coc-explorer
vim.g.coc_explorer_global_presets = {
  [".vim"] = { ["root-uri"] = "~/.vim" },
  nvim = { ["root-uri"] = "~/.config/nvim" },
  floating = { position = "floating" },
  floatingLeftside = {
    position = "floating",
    ["floating-position"] = "left-center",
    ["floating-width"] = 50,
  },
  floatingRightside = {
    position = "floating",
    ["floating-position"] = "right-center",
    ["floating-width"] = 50,
  },
  simplify = {
    ["file.child.template"] = "[selection | clip | 1] [indent][icon | 1][filename omitCenter 1]",
  },
}

-- netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = false
vim.g.netrw_browse_split = 2
vim.g.netrw_winsize = 30
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

-- indend-blankline
if vim.opt.diff:get() then
  vim.g.indent_blakline_enabled = false
end

vim.g.indent_blankline_filetype_exclude = { "diff", "man", "vim-plug", "help", "markdown", "text", "coc-explorer" }
vim.g.indent_blankline_buftype_exclude = { "terminal" }
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_highlight = "Function"
vim.g.indent_blankline_context_patterns = { "function", "class", "method" }
vim.g.indent_blankline_char = "▏"

-- vim-rooter
vim.g.rooter_manual_only = 1
vim.g.rooter_change_directory_for_non_project_files = "current"
