
-- git commands
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gll", ":Git log<CR>")
vim.keymap.set("n", "<leader>gl1", ":Git log --oneline<CR>")

-- Git Add
vim.keymap.set("n", "<leader>gaa", function()
  vim.cmd("w")               -- Save the current file
  vim.cmd("Git add %")        -- Stage the current file
end, { desc = "Save and stage current file" })
vim.keymap.set("n", "<leader>ga.", function()
  vim.cmd("wa")               -- Save all files
  vim.cmd("Git add .")        -- Stage all changes
  vim.cmd("echo 'Saved and staged All Files'")
end, { desc = "Save all and stage all files" })
vim.keymap.set("n", "<leader>gau", ":Git restore --staged .<CR>")

-- Git Commit, Push
vim.keymap.set("n", "<leader>gcc", ":Git commit<CR>")
vim.keymap.set("n", "<leader>gcm", ":Git commit -m ")
vim.keymap.set("n", "<leader>gca", ":Git commit --amend<CR>")
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")

-- Git Stash
vim.keymap.set("n", "<leader>gss", function()
    vim.cmd("wa")
    vim.cmd("Git stash -u")
end, {desc = "Save and Stash all files"})
vim.keymap.set("n", "<leader>gsp", ":Git stash pop<CR>")

-- Git Branch
vim.keymap.set("n", "<leader>gbb", ":Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>gbc", ":Git branch ")
vim.keymap.set("n", "<leader>gbs", ":Git switch ")
vim.keymap.set("n", "<leader>gbd", ":Git branch -D ")

-- Git Merge
vim.keymap.set("n", "<leader>gm", ":Git merge ")

-- Git Pull
vim.keymap.set("n", "<leader>gu", ":Git pull ")
vim.keymap.set("n", "<leader>guu", ":Git pull<CR>")
vim.keymap.set("n", "<leader>gur", ":Git pull --rebase<CR>")
vim.keymap.set("n", "<leader>gur", ":Git pull --rebase<CR>")

-- Git Remote
vim.keymap.set("n", "<leader>gr", ":Git remote ")
vim.keymap.set("n", "<leader>grr", ":Git remote -v<CR>")
vim.keymap.set("n", "<leader>gra", ":Git remote add ")
vim.keymap.set("n", "<leader>grs", ":Git remote set-url ")

-- Git Config
vim.keymap.set("n", "<leader>goo", ":botright new | setlocal buftype=nofile | read !sh -c " ..
    "'echo \"\\n--- Global Config ---\\n\"; " ..
    "git config --list --global; " ..
    "echo \"\\n--- Local Config ---\\n\"; " ..
    "git config --list --local'" ..
    "<CR>")
vim.keymap.set("n", "<leader>gol", ":Git config --local ")
vim.keymap.set("n", "<leader>gog", ":Git config --global ")

-- Gitk
vim.keymap.set("n", "<leader>gk", ":!gitk<CR>")
