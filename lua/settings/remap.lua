-- Leader o to open config
vim.api.nvim_set_keymap(
	"n",
	"<leader>o",
	":tabnew ~/.config/nvim | tcd ~/.config/nvim<CR>",
	{ noremap = true, silent = true }
)

-- Set Caps to Esc
vim.api.nvim_set_keymap("i", "CAPSLOCK", "<ESC>", { noremap = true, silent = true })

-- Map CMD+C to Save
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<ESC>:w<CR>", { desc = "Save file" })
-- Map CMD-Q to Quit
vim.keymap.set({ "n", "v" }, "<C-q>", ":wa | qa<CR>", { noremap = true, silent = true })

-- Map CMD+Z to Undo
vim.keymap.set("n", "<C-z>", "u", { noremap = true })
vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true })
vim.keymap.set({ "n", "i" }, "<C-r>", "<C-o>:redo<CR>", { desc = "Redo" })
vim.keymap.set({ "n", "i" }, "<C-S-Z>", "<C-o>:redo<CR>", { desc = "Redo" })

-- Allow Mouse Support
vim.o.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("v", "<BS>", '"_di', { noremap = true }) -- Allows highlight then delete

-- Map CMD+C to copy to clipboard
vim.keymap.set("n", "<C-c>", '"+y', { noremap = true }) -- Normal mode (yank)
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true }) -- Visual mode (yank)
-- Map CMD+V to paste from clipboard
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true }) -- Normal mode (paste)
vim.keymap.set("v", "<C-v>", '"_dP', { noremap = true }) -- Visual mode (paste)
vim.keymap.set("i", "<C-v>", function()
	return vim.fn.getreg("+")
end, { noremap = true, expr = true }) -- Visual mode (paste)
-- Map CMD+X to cut to clipboard
vim.keymap.set("v", "<C-x>", '"+d', { noremap = true }) -- Visual mode (cut)

-- Tab Navigation
vim.keymap.set("n", "<leader>t.", function()
	vim.cmd("tabnext")
end, { desc = "Next tab" })
vim.keymap.set("n", "<leader>t,", function()
	vim.cmd("tabprevious")
end, { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tq", function()
	vim.cmd("tabclose")
end, { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", function()
	vim.cmd("tabnew")
	vim.cmd("Ex")
end, { desc = "Open a new tab" })
vim.keymap.set("n", "<leader>t<left>", "<C-w>h")
vim.keymap.set("n", "<leader>t<right>", "<C-w>l")

-- Line Moving
vim.keymap.set("v", "<C-up>", ":m '<-2<CR>gv=gv", {})
vim.keymap.set("v", "<C-down>", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("n", "<C-up>", ":m .-2<CR>==", {})
vim.keymap.set("n", "<C-down>", ":m .+1<CR>==", {})
vim.keymap.set("i", "<C-up>", "<Esc>:m .-2<CR>==gi", {})
vim.keymap.set("i", "<C-down>", "<Esc>:m .+1<CR>==gi", {})

-- Find and Replace
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "<leader>ff", function()
	vim.fn.input("/")
	vim.cmd("normal! zz")
end)
vim.keymap.set("n", "<C-f>", "<leader>ff")
vim.keymap.set("n", "<leader>frw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>fra", function()
	vim.cmd("wa") -- Save all files
	local previous = vim.fn.input("Replace: ")
	local next = vim.fn.input("With: ")
	local escaped_previous = vim.fn.escape(previous, "\\/") -- Escape any special characters

	require("telescope.builtin").grep_string({
		search = previous,
		word_match = "-w",
		additional_args = function()
			return { "--case-sensitive" }
		end,
		attach_mappings = function(prompt_bufnr)
			vim.defer_fn(function()
				local actions = require("telescope.actions")
				actions.send_to_qflist(prompt_bufnr)
				vim.cmd("cclose") -- Close Telescope quickfix preview window

				-- Check if the quickfix list is populated
				if #vim.fn.getqflist() > 0 then
					-- Run the substitution with confirmation
					vim.cmd("cdo s/" .. escaped_previous .. "/" .. next .. "/gc")
				else
					print("No matches found for: " .. previous)
				end
			end, 200) -- Delay slightly to allow Telescope to fully open
			return true
		end,
	})
end, { noremap = true, silent = true })

-- Duplicate Line
vim.keymap.set("n", "<C-d>", "yyp", { desc = "Duplicate line" })
vim.keymap.set("v", "<C-d>", ":t'><CR>gv", { desc = "Duplicate selection" })
vim.keymap.set("i", "<C-d>", "<Esc>yypA", { desc = "Duplicate line in insert mode" })

-- Add a newline below line
vim.keymap.set("n", "<S-CR>", "o<Esc>", { desc = "Add a new line below" })

-- Run Function
vim.keymap.set("n", "<leader>rjs", ":w<CR>:!deno run %<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rpy", ":w<CR>:lua RunPythonFile()<CR>", { noremap = true, silent = true })
function RunPythonFile()
	-- Get the path of the current file's directory
	local file_dir = vim.fn.expand("%:p:h")
	-- Get the full path of the current file
	local file_path = vim.fn.expand("%:p")
	-- Change to the file's directory, run Python, and return to the previous directory
	vim.cmd("!" .. "cd " .. file_dir .. " && python3 " .. file_path)
end


-- NO Ops
vim.keymap.set({ "n", "v", "o" }, "q", "<Nop>", { desc = "Disable macro recording" })
vim.keymap.set({ "n", "v", "o", "i" }, "<C-n>", "<Nop>", { desc = "Disable macro recording" })
