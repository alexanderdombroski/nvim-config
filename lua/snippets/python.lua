local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
    s("printf", { t("print(f\""), i(1, "message"), t("\")") }),
    -- Add more snippets here
}
