
vim.cmd[[
try
  colorscheme ayu
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]


  --[[ highlight SignColumn guibg = NONE ]]
  --[[ highlight NormalFloat guibg = #0000 ]]
