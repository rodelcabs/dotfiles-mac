
vim.cmd[[
try
  colorscheme vscode
  hi NvimTreeNormal guibg=NONE ctermbg=NONE
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]


  --[[ highlight SignColumn guibg = NONE ]]
  --[[ highlight NormalFloat guibg = #0000 ]]
