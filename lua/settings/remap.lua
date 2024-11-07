-- Set Caps to Esc
vim.api.nvim_set_keymap('i', 'CAPSLOCK', '<ESC>', { noremap = true, silent = true })

-- Map CMD+C to Save
vim.keymap.set('n', '<C-s>', function() vim.cmd('w') end, { desc = "Save file" })


-- Map CMD+Z to Undo
vim.keymap.set("n", "<C-z>", "u", { noremap = true })
vim.keymap.set("i", "<C-z>", "u", { noremap = true })
-- CMD+R is still undo


-- Allow Mouse Support
vim.o.mouse = "a"
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('v', '<BS>', 'd', { noremap = true }) -- Allows highlight then delete


-- Map CMD+C to copy to clipboard
vim.keymap.set('n', '<C-c>', '"+y', { noremap = true })  -- Normal mode (yank)
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true })  -- Visual mode (yank)
-- Map CMD+V to paste from clipboard
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true })  -- Normal mode (paste)
vim.keymap.set('v', '<C-v>', '"+p', { noremap = true })  -- Visual mode (paste)
vim.keymap.set('i', '<C-v>', function()
  return vim.fn.getreg('+')
end, { noremap = true, expr = true }) -- Visual mode (paste)
-- Map CMD+X to cut to clipboard
vim.keymap.set('v', '<C-x>', '"+d', { noremap = true })  -- Visual mode (cut)


-- Tab Navigation
vim.keymap.set("n", "<leader>t.", function() vim.cmd("tabnext") end, { desc = "Next tab" })
vim.keymap.set("n", "<leader>t,", function() vim.cmd("tabprevious") end, { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tq", function() vim.cmd("tabclose") end, { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", function() vim.cmd("tabnew") end, { desc = "Open a new tab" })


