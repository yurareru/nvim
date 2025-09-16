local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require "luasnip.extras.fmt".fmt

return {
	s(
		{
			trig = "init",
			name = "Rust CP Template",
		},
		fmt(
			[[
use std::io::stdin;

fn take_int() -> usize {{
    let mut input = String::new();
    stdin().read_line(&mut input).unwrap();
    input.trim().parse().unwrap()
}}

fn take_vector() -> Vec<isize> {{
    let mut input = String::new();
    stdin().read_line(&mut input).unwrap();
    input
        .trim()
        .split_whitespace()
        .map(|x| x.parse().unwrap())
        .collect()
}}

fn main() {{
    let n = take_int();
    {}
}}]],
			{
				i(0),
			}
		)
	),
}
