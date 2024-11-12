local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

return {
    s("printf", { t("print(f\""), i(1, "message"), t("\")") }),


    s("class", { t("class "), i(1, "ClassName"), t(":"),
    t({"", "\tdef __init__(self, "}), i(2, "param1, param2"), t({"):", ""}),
    t({""}),
    -- Function node that splits input string into class attributes
    f(function(args)
        -- Split the parameters by commas and format them
        local params = vim.split(args[1][1], ",")
        local lines = {}
        for _, param in ipairs(params) do
            table.insert(lines, "\t\tself." .. param:gsub("%s+", "") .. " = " .. param:gsub("%s+", ""))
        end
        return lines
    end, {2}),
    t({"", ""})
    })


}
