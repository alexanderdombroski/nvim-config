require("config.lazy")
require("settings")

-- Command to run when Neovim opens
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    print("Welcome to Neovim!")
  end
})

-- Command to run when Neovim closes
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    print("Goodbye from Neovim!")
  end
})
