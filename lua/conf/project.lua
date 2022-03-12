local project_ok, project = pcall(require,'project_nvim')
if not project_ok then return end

project.setup({
  datapath = vim.fn.stdpath('config')
})
