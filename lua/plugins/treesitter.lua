return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",  -- Automatically run TSUpdate to install parsers
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", 
      		"markdown", "markdown_inline", "bash", "c_sharp", 
		"cpp", "erlang", "git_config", "gitignore", "html", 
		"java", "javascript", "json", "json5", "python", 
		"regex", "rust", "scss", "sql", "swift", "tsx", 
		"typescript", "vue", "xml", "yaml"
      },  -- Automatically install languages
      highlight = {
        enable = true,              -- Enable syntax highlighting
        disable = {},               -- Disable some languages if needed
      },
      indent = {
        enable = true,              -- Enable automatic indentation
      },
      -- Add additional configurations here, like `autotag`, `rainbow`, etc.
    }
  end
}
