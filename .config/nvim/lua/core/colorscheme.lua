
vim.cmd[[
try
  colorscheme ayu
  highlight SignColumn guibg = NONE
  highlight NormalFloat guibg = #0000
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
