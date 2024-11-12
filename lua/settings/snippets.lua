-- File that loads snippets into luasnip
local luasnip = require("luasnip")

-- Define the path to your snippets
local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets/"

-- Function to load snippets by filetype
function LoadSnippets()
    local files = vim.fn.glob(snippets_path .. "*.lua", true, true)
    for _, file in ipairs(files) do
        local language = vim.fn.fnamemodify(file, ":t:r") -- Extract filetype from filename
    	local snippet_table = require("snippets." .. language)


    	if next(snippet_table) then
            -- Add a custom tag or label to distinguish custom snippets
            for _, snippet in pairs(snippet_table) do
                snippet.trigger = snippet.trigger ..  "--"
            end

    	    -- Add snippets to LuaSnip for this filetype
    	    luasnip.add_snippets(language, snippet_table)
    	end
    end
end

-- Set up LuaSnip and load the snippets
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.setup({})
LoadSnippets()
