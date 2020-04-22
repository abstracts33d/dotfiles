" javscript
" conceal
syntax keyword javascriptFuncKeyword function   conceal cchar=
syntax keyword javascriptRepeat      for        conceal cchar=∀
syntax keyword javascriptOperator    in         conceal cchar=∈
syntax keyword javascriptNull        null       conceal cchar=ﳠ
syntax match   javascriptArrowFunc   /=>/       conceal cchar=ﰲ
syntax match   javascriptOpSymbol    /=\{1}/    conceal cchar=←
syntax match   javascriptOpSymbol    /\!=/      conceal cchar=≠
syntax match   javascriptOpSymbol    /\!/       conceal cchar=¬
syntax match   javascriptOpSymbol    /&\{2}/    conceal cchar=∧
syntax match   javascriptOpSymbol    /|\{2}/    conceal cchar=∨
syntax match   javascriptOpSymbol    /<=\{1,2}/ conceal cchar=≤
syntax match   javascriptOpSymbol    />=\{1,2}/ conceal cchar=≤
syntax match   javascriptOpSymbol    /=\{3}/    conceal cchar=

let operatorGroup=[
  \ 'javascriptComma',
  \ 'javaScriptBraces',
  \ 'javaScriptBrackets',
  \ 'javascriptTemplateSB',
  \ 'javascriptParens',
  \ 'javascriptDotNotation',
  \ 'javascriptEndColons',
  \ 'javascriptComma'
  \ ]

for group in operatorGroup
  execute "hi link " group " Delimiter"
endfor

hi! link javascriptVariable    Constant
hi! link javascriptArrowFunc   Special
hi! link javascriptOpSymbol    Special
hi! link javascriptFuncKeyword Function
hi! link javascriptReturn      Function
hi! link javascriptConditional Conditional
hi! link javascriptRepeat      Repeat
hi! link javascriptImport      Include
hi! link javascriptExport      Include

" jsx
hi! link xmlEndTag  xmlTag
hi! link xmlTagN    xmlTagName
hi! link xmlTag     Tag
hi! link xmlAttrib  Keyword
hi! link xmlTagName SpecialChar
hi! link jsxRegion  SpecialChar

