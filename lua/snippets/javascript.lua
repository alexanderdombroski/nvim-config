local ls = require("luasnip")  
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

print(require("snippets.all"))

return {
  s("log", { t("console.log("), i(1, "message"), t(");") }),
  -- Add more snippets here
}
