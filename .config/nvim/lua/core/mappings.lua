local opts = { noremap = true, silent = true }
local api = vim.api
local fn = vim.fn
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- buffer close handling
local close_buffer = function(force)
   if vim.bo.buftype == "terminal" then
      api.nvim_win_hide(0)
      return
   end

   local fileExists = fn.filereadable(fn.expand "%p")
   local modified = api.nvim_buf_get_option(fn.bufnr(), "modified")

   -- if file doesnt exist & its modified
   if fileExists == 0 and modified then
      print "no file name? add it now!"
      return
   end

   force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

   -- if not force, change to prev buf and then close current
   local close_cmd = force and ":bd!" or ":bp | bd" .. fn.bufnr()
   vim.cmd(close_cmd)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

--new window vertical
keymap("n", "<leader>v", "<C-w>v", opts)
keymap("n", "<leader><S-v>", "<cmd>topleft vnew<cr>", opts)
--new window horizontal
keymap("n", "<leader>h", "<C-w>s", opts)

keymap("n", "<C-n>", ":NvimTreeToggle<cr>", opts)

-- git signs
keymap("n", "gh", "<cmd>Gitsigns next_hunk<cr>", opts)
keymap("n", "gp", "<cmd>Gitsigns preview_hunk<cr>", opts)
keymap("n", "gw", "<cmd>Gitsigns toggle_current_line_blame<cr>", opts)

-- bufferline
keymap("n", "<TAB>", "<cmd> BufferLineCycleNext <CR>", opts)
keymap("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>", opts)
vim.keymap.set("n", "<leader>x", function ()
 close_buffer()
end, opts)

--refresh
keymap("n", "`", "<cmd> edit! <cr>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "<C-k>", "<up>", opts)
keymap("i", "<C-j>", "<down>", opts)
keymap("i", "<C-h>", "<left>", opts)
keymap("i", "<C-l>", "<right>", opts)
keymap("i", "<C-e>", "<ESC>$a", opts)
keymap("i", "<C-b>", "<ESC>^i", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- telescope
keymap("n", "<C-p>", "<cmd> lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("i", "<C-p>", "<cmd> lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts) --use telescope for lsp references

-- git telescope
keymap("n", "<leader>gt", "<cmd>Telescope git_status<cr>", opts) --gt status
keymap("n", "<leader>gb", "<cmd> lua require'telescope.builtin'.git_branches(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts) -- git branches
keymap("n", "<leader>gs", "<cmd>Telescope git_stash<cr>", opts) -- git stash
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts) -- git commits 

-- outline
keymap("n", "<C-s>", "<cmd>SymbolsOutline<cr>", opts)

--sidebar

keymap("n", "<C-x>", "<cmd>SidebarNvimToggle<cr>", opts)
