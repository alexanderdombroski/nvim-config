-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
       vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
       vim.keymap.set('n', '<leader>hd', vim.lsp.buf.definition, opts)
       vim.keymap.set('n', '<leader>hD', vim.lsp.buf.declaration, opts)
       vim.keymap.set('n', '<leader>hi', vim.lsp.buf.implementation, opts)
       vim.keymap.set('n', '<leader>ht', vim.lsp.buf.type_definition, opts)
       vim.keymap.set('n', '<leader>hr', vim.lsp.buf.references, opts)
       vim.keymap.set('n', '<leader>hs', vim.lsp.buf.signature_help, opts)
       vim.keymap.set('n', '<leader>hrn', vim.lsp.buf.rename, opts)
       vim.keymap.set({'n', 'x'}, '<leader>hf', function() vim.lsp.buf.format({async = true}) end, opts)
       vim.keymap.set('n', '<leader>ha', vim.lsp.buf.code_action, opts)
  end,
})


-- -------------------- List of LSPs -----------------------
require('lspconfig').csharp_ls.setup({})
require('lspconfig').java_language_server.setup({})


--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').cssls.setup({
  capabilities = capabilities,
})
require('lspconfig').cssmodules_ls.setup({})
require('lspconfig').html.setup({})

vim.g.markdown_fenced_languages = {
	  "ts=typescript"
}
require('lspconfig').denols.setup({})
require('lspconfig').eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

require('lspconfig').jsonls.setup ({
    capabilities = capabilities,
})

require('lspconfig').erlangls.setup({})
require('lspconfig').elp.setup({}) -- Erlang


require('lspconfig').lua_ls.setup ({
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

require('lspconfig').marksman.setup({}) -- Markdown
require('lspconfig').pylsp.setup({}) -- Python
require('lspconfig').sqlls.setup({}) -- SQL (not installed)
require('lspconfig').vimls.setup({}) --VimScript


-- -------------------- Setup Autocompletion -----------------------

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
	-- Custom Autocompletion added here
        ['<Tab>'] = cmp.mapping.confirm({ select = true })
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})


-- -------------------- Fix Paren Inserter --------------------
vim.keymap.set("v", "(", "<Esc>`<i(<Esc>`>a)", { noremap = true, silent = true })
vim.keymap.set("v", "[", "<Esc>`<i[<Esc>`>a]", { noremap = true, silent = true })
vim.keymap.set("v", "{", "<Esc>`<i{<Esc>`>a}", { noremap = true, silent = true })
vim.keymap.set("v", "\"", "<Esc>`<i\"<Esc>`>a\"", { noremap = true, silent = true })
vim.keymap.set("v", "'", "<Esc>`<i'<Esc>`>a'", { noremap = true, silent = true })

