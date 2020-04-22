let g:terminal_color_orange    = "#D08770"
let g:terminal_color_red       = "#BF616A"
let g:terminal_color_yellow    = "#EBCB8B"
let g:terminal_color_green     = "#A3BE8C"
let g:terminal_color_blue      = "#5E81AC"
let g:terminal_color_pale_blue = "#88C0D0"
let g:terminal_color_white     = "#FFFFFF"

function highlight#CustomHighlight() abort
  " execute "hi Comment"
  execute "hi Constant            guifg="g:terminal_color_red
    " execute "hi String"
    " execute "hi Character"
    " execute "hi Number"
    " execute "hi Boolean"
    " execute "hi Float"
  " execute "hi Identifier"
    execute "hi Function          guifg="g:terminal_color_blue
  execute   "hi Statement         guifg="g:terminal_color_blue
    execute "hi Conditional       guifg="g:terminal_color_blue
    " execute "hi Repeat            guifg="g:terminal_color_blue
    execute "hi Label             guifg="g:terminal_color_orange
    execute "hi Operator          guifg="g:terminal_color_red
    execute "hi Keyword           guifg="g:terminal_color_pale_blue
    execute "hi Exception         guifg="g:terminal_color_red
  " execute "hi PreProc"
    execute "hi Include           guifg="g:terminal_color_blue
    execute "hi Define            guifg="g:terminal_color_blue
    " execute "hi Macro"
    " execute "hi PreCondit"
  " execute "hi Type"
    " execute "hi StorageClass"
    " execute "hi Structure"
    " execute "hi Typedef"
  execute "hi Special             guifg="g:terminal_color_red
    execute "hi SpecialChar       guifg="g:terminal_color_orange
    execute "hi Tag               guifg="g:terminal_color_blue
    execute "hi Delimiter         guifg="g:terminal_color_orange
    " execute "hi SpecialComment"
    " execute "hi Debug"
  " execute "hi Underlined"
  " execute "hi Ignore"
  " execute "hi Error"
  " execute "hi Todo"
  execute "hi Conceal             guifg="g:terminal_color_white  "guibg=NONE"

  hi Comment             gui = italic
  hi Constant            gui = italic
  hi Keyword             gui = italic
  hi Identifier          gui = italic
  hi StorageClass        gui = italic
  " hi Repeat              gui = italic,bold
  hi Conditional         gui = italic,bold
  hi Function            gui = italic,bold
  hi Include             gui = italic,bold
  hi Special             gui = italic,bold
endfunction

syntax enable

augroup theming
  autocmd!
  autocmd ColorScheme * call highlight#CustomHighlight()
augroup END
