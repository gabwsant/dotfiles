-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- turn on spellchecker only for .txt files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "text",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "pt_br", "en" }
  end,
})
