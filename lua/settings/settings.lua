-- Easy Mode Transfer
vim.keymap.set("n", "a", "i") -- Append Mode goes strait to insert mode
vim.keymap.set("n", "<BS>", "i<BS>")

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

-- Set cursor shapes for different modes
vim.opt.guicursor = {
    "n-c:block",           -- Block cursor in Normal, Visual, and Command modes
    "i-ci-v-ve:ver25",         -- Vertical bar (thin) cursor in Insert, Command-line Insert, and Visual Insert modes
    "r-cr:hor20",            -- Horizontal bar cursor in Replace and Command-line Replace modes
    "o:hor50",               -- Horizontal bar cursor in Operator-pending mode
}
vim.opt.selection = "exclusive"
vim.opt.virtualedit = "onemore"

