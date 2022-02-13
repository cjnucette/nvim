local package_ok, package = pcall(require, 'package-info')
if not package_ok then return end

local map = require("utils").map

package.setup()

function SetMaps()
  local opts = { buffer = 0 }
  map("n", "<leader>ps", package.show, opts)
  map("n", "<leader>ph", package.hide, opts)
  map("n", "<leader>pu", package.update, opts)
  map("n", "<leader>pd", package.delete, opts)
  map("n", "<leader>pi", package.install, opts)
  map("n", "<leader>pr", package.reinstall, opts)
  map("n", "<leader>pc", package.change_version, opts)
end

vim.cmd([[
  augroup package_maps
    autocmd!
    autocmd BufRead,BufNewFile package.json lua SetMaps()
  augroup END
]])
