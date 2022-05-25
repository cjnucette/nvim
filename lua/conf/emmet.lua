vim.g.user_emmet_mode = 'a'
vim.g.user_emmet_install_global = 0
-- vim.g.user_emmet_leader_key = ','
-- vim.g.user_emmet_expandabbr_key = ','
vim.g.user_emmet_settings = {
  variables = { lang = 'en' },
  html = {
    default_attributes = {
      option = { value = nil },
      textarea = { id = nil, name = nil, cols = 10, rows = 10 },
    },
    snippets = {
      ['html:5'] = [[
<!DOCTYPE html />
<html lang="${lang}">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>${1}</title>
    <link rel="stylesheet" href="${2:style.css}" />
    <script type="module" src="${3:main.js}"></script>
  </head>
  <body>
    ${child}|
  </body>
</html>]]
    }
  }
}

vim.cmd [[
  augroup Emmet
    autocmd!
    autocmd FileType html,css,javascriptreact,typescriptreact EmmetInstall
  augroup END
]]
