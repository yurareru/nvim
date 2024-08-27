syntax clear

syntax keyword bbcodeKeyword [b] [i] [u] [url] [img] [code] [quote] [color] [size] [centre] [notice] [imagemap] [box] [c] [audio]
syntax keyword bbcodeTag [url=] [img=] [color=] [size=] [box=]

highlight def link bbcodeKeyword Keyword
highlight def link bbcodeTag Type

syntax match bbcodeBracket "\[\|\]"
highlight def link bbcodeBracket Special

syntax match bbcodeHexColor "#\x\{6}"
highlight def link bbcodeHexColor Identifier

