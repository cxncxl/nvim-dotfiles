local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("go", {
    s("middleware", fmt([[
        func {}(next http.HandlerFunc) http.HandlerFunc {{
            return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {{
                {}
                next.ServeHTTP(w, r)
            }})
        }}
    ]], {
        i(1, "name"),
        i(2),
    }))
})

ls.add_snippets("go", {
    s("custerror", fmt([[
        type {} struct {{}}
        func ({}) Error() string {{
            return "{}";
        }}
        var {}Error = {}{{}}
    ]], {
        i(1, "name"),
        rep(1),
        i(2),
        rep(1),
        rep(1),
    }))
})
