
vim.opt.number = true -- Line Numbers
vim.opt.numberwidth = 1

vim.opt.undofile = false -- turn off persistant undo tree

-- 4 Space Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.wrap = false -- turn off linewrap

-- find and replace
vim.opt.incsearch = true
vim.opt.hlsearch = false


vim.opt.scrolloff = 8 -- Have at least the 8 next lines always visible
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 100


