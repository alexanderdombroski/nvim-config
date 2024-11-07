-- Command to run when Neovim opens
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    print("Welcome to Neovim!")
    -- Run a shell command when Neovim opens
    vim.fn.system("karabiner_cli --set-variables '{\"nvim_open\":true}'")
    end
})

-- Command to run when Neovim closes
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    print("Goodbye from Neovim!")
    -- Run a shell command when Neovim closes
    vim.fn.system("karabiner_cli --set-variables '{\"nvim_open\":false}'")
    end
})
