local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s({ trig = "var", name = "var", wordTrig = true }, {
		t { "var(--" },
		i(1),
		t { ")" },
		i(0),
	}),
	s({ trig = "!imp", name = "important", wordTrig = true }, {
		t { "!important" },
		i(0),
	}),
}
