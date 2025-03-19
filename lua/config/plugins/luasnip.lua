local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node

ls.setup({
    link_children = true,
})

ls.add_snippets("all", {

	s("ternary", { -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),

    s("trigger", {
        i(1, "First jump"),
        t(" :: "),
        sn(2, {
            i(1, "Second jump"),
            t" : ",
            i(2, "Third jump")
        })
    })
})

ls.add_snippets("markdown", {
	s("insert_code", {
		t("```"), i(1, "lang"), t("```"),
	}),
})

--------------------------------------------------------------------------------
--------------------           unused options          -------------------------
--------------------------------------------------------------------------------
-- local isn = ls.indent_snippet_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("ls.util.events")
-- local ai = require("ls.nodes.absolute_indexer")
-- local extras = require("ls.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("ls.extras.fmt").fmt
-- local fmta = require("ls.extras.fmt").fmta
-- local conds = require("ls.extras.expand_conditions")
-- local postfix = require("ls.extras.postfix").postfix
-- local types = require("ls.util.types")
-- local parse = require("ls.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("ls.nodes.key_indexer").new_key
