return {
  {
    "numToStr/Comment.nvim",
    config = function ()
      require('Comment').setup({
       ---Add a space b/w comment and the line
       padding = true,
       ---Whether the cursor should stay at its position
       sticky = true,
       ---Lines to be ignored while (un)comment
       ignore = nil,
       ---LHS of toggle mappings in NORMAL mode
       toggler = {
           ---Line-comment toggle keymap
           line = 'gcc',
           ---Block-comment toggle keymap
           block = 'gbc',
       },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
         ---Line-comment keymap
         line = 'gc',
         ---Block-comment keymap
         block = 'gb',
        },
       ---Enable keybindings
       ---NOTE: If given `false` then the plugin won't create any mappings
       mappings = {
           ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
           basic = true,
           ---Extra mapping; `gco`, `gcO`, `gcA`
           extra = false,
       },
       ---Function to call before (un)comment
       pre_hook = nil,
       ---Function to call after (un)comment
       post_hook = nil,
    })

    -- Linewise comment toggle for normal, insert, and visual modes
    vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { noremap = true, silent = true })
    vim.keymap.set("i", "<C-/>", "<Esc><Plug>(comment_toggle_linewise_current)i", { noremap = true, silent = true })
    vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { noremap = true, silent = true })

    -- Blockwise comment toggle for visual mode
    vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_blockwise_visual)", { noremap = true, silent = true })

    -- Linewise comment toggle for normal mode and insert mode (using <leader>/)
    vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { noremap = true, silent = true })
    end
  }
}
