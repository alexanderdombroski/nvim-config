-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>hd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>hD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>hi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>ht", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>hr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>hs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>hrn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "x" }, "<leader>hf", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "<leader>ha", vim.lsp.buf.code_action, opts)
	end,
})

-- -------------------- List of LSPs -----------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").csharp_ls.setup({
	capabilitie = capabilities,
})
require("lspconfig").java_language_server.setup({
	capabilitie = capabilities,
})
--Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cssls.setup({
	capabilities = capabilities,
})
require("lspconfig").cssmodules_ls.setup({
	capabilitie = capabilities,
})
require("lspconfig").html.setup({
	capabilitie = capabilities,
})

vim.g.markdown_fenced_languages = {
	"ts=typescript",
}
require("lspconfig").denols.setup({
	capabilitie = capabilities,
})
require("lspconfig").eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
require("lspconfig").ts_ls.setup({
	cmd = { "/opt/homebrew/bin/typescript-language-server", "--stdio" },
	capabilities = capabilities,
})

require("lspconfig").jsonls.setup({
	capabilities = capabilities,
})

require("lspconfig").erlangls.setup({
	capabilitie = capabilities,
})
require("lspconfig").elp.setup({
	capabilitie = capabilities,
}) -- Erlang

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

require("lspconfig").marksman.setup({
	capabilitie = capabilities,
}) -- Markdown
require("lspconfig").pylsp.setup({
	capabilitie = capabilities,
}) -- Python
require("lspconfig").sqlls.setup({
	capabilities = capabilities,
}) -- SQL (not installed)
require("lspconfig").vimls.setup({
	capabilities = capabilities,
}) --VimScript

-- -------------------- Setup Autocompletion -----------------------

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	-- Key mapping setup
	mapping = cmp.mapping.preset.insert({
		-- Use Tab to expand the snippet and navigate through insert nodes
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				-- First, try to expand the snippet if possible
				luasnip.expand()
			elseif cmp.visible() then
				-- Then, if completion menu is visible, select the next item
				if cmp.get_selected_entry() == nil then
					cmp.select_next_item()
				end
				cmp.confirm({ select = true })
			else
				-- If none of the above, fallback to default behavior
				fallback()
			end
		end, { "i", "s" }),

		-- Arrows Navigate Snippets
		["<left>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] then
				luasnip.jump(-1) -- Jump to the previous node
			else
				fallback() -- Fallback if no previous node to jump to
			end
		end, { "i", "s" }),

		["<right>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] then
				luasnip.jump(1) -- Jump to the previous node
			else
				luasnip.unlink_current()
				fallback() -- Fallback if no previous node to jump to
			end
		end, { "i", "s" }),

		-- Cycle through choice nodes with 'n'
		["<C-n>"] = cmp.mapping(function(fallback)
			if luasnip.choice_active() then
				luasnip.change_choice(1) -- Move to the next choice in the choice node
			else
				fallback() -- Fallback if no choice node is active
			end
		end, { "i", "s" }),

		-- Confirm the completion with Enter
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif luasnip.in_snippet() then
				luasnip.unlink_current()
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = function(entry, item)
			-- Add source name to the menu item
			local source_names = {
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				path = "[Path]",
			}

			-- Set a custom label if it's a LuaSnip source and contains specific indicators
			if entry.source.name == "luasnip" then
				local name = entry:get_completion_item().word
				if string.sub(name, -2) == "--" then
					item.menu = "[Luasnip]"
				else
					item.menu = "[VS]"
				end
			else
				item.menu = source_names[entry.source.name] or "[Other]"
			end

			-- Truncate item label to a max width of 30 characters
			local max_label_width = 30
			if #item.abbr > max_label_width then
				item.abbr = string.sub(item.abbr, 1, max_label_width - 3) .. "..."
			end
			return item
		end,
	},
})

-- -------------------- Fix Paren Inserter --------------------
vim.keymap.set("v", "(", "<Esc>`<i(<Esc>`>a)", { noremap = true, silent = true })
vim.keymap.set("v", "[", "<Esc>`<i[<Esc>`>a]", { noremap = true, silent = true })
vim.keymap.set("v", "{", "<Esc>`<i{<Esc>`>a}", { noremap = true, silent = true })
vim.keymap.set("v", '"', '<Esc>`<i"<Esc>`>a"', { noremap = true, silent = true })
vim.keymap.set("v", "'", "<Esc>`<i'<Esc>`>a'", { noremap = true, silent = true })

-- -------------------- Linting and FileCleanup --------------------

vim.keymap.set("n", "<leader>cf", function()
	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%:p")
	local extension = vim.fn.expand("%:e")


    if
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "html"
		or filetype == "css"
		or filetype == "json"
	then
		-- Format with Prettier
        print(filename)
        local command = "prettier --stdin-filepath foo." .. extension .. " --tab-width 2 < " .. filename
        print(command)
        local handle = io.popen(command)
		local formatted_output = handle:read("*a")
		handle:close()

		-- If we have output, replace the buffer content
		if formatted_output and #formatted_output > 0 then
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted_output, "\n"))
			print("Buffer formatted successfully.")
		else
			print("Failed to format buffer or no output received.")
		end

-- elseif filetype == "cpp" or filetype == "c" then
	--     -- Format with clang-format
	--     vim.cmd("!clang-format -i " .. filename)


    elseif filetype == "lua" then
		-- Format with stylua
		vim.cmd("!stylua " .. filename)
	else
		print("No formatter configured for this file type.")
	end
end)
