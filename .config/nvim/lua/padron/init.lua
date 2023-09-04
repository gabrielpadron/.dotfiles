require "padron.settings"

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require "padron.mappings"
    require "padron.autocmds"
  end,
})
