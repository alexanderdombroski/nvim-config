-- Setup Harpoon (quickest file navigation)

local harpoon = require("harpoon")
harpoon:setup({})

-- Telescope configuration for Harpoon files
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end



-- Make it easier to enter Explorer Mode
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>qe", vim.cmd.Ex)


-- Telescope Remaps
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>qf', builtin.find_files, {}) -- " " q f >>> to show all files in open dir 
vim.keymap.set('n', '<leader>qg', builtin.git_files, {}) -- CMD + p >>> to show all git files
vim.keymap.set('n', '<leader>qs', function()
		builtin.grep_string( { search = vim.fn.input("Grep > ") } )
end)
vim.keymap.set("n", "<leader>qd", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })


-- Harpoon Mappings
vim.keymap.set("n", "<leader>qa", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>qq", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>,", function() harpoon:list():prev() end)  -- CTRL + '<' to go to previous
vim.keymap.set("n", "<leader>.", function() harpoon:list():next() end)  -- CTRL + '>' to go to next

vim.keymap.set('n', '<leader>qz', function() 
	harpoon:list():clear() end, { desc = "Clear Harpoon list" })

-- Undo Tree Mappings
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })


