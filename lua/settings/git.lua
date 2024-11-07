
-- git commands
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gl", ":Git log<CR>")


vim.keymap.set("n", "<leader>ga", function()
  vim.cmd("w")               -- Save the current file
  vim.cmd("Git add %")        -- Stage the current file
end, { desc = "Save and stage current file" })
vim.keymap.set("n", "<leader>ga.", function()
  vim.cmd("wa")               -- Save all files
  vim.cmd("Git add .")        -- Stage all changes
end, { desc = "Save all and stage all files" })

vim.keymap.set("n", "<leader>gc", ":Git commit")
vim.keymap.set("n", "<leader>gp", ":Git push")


