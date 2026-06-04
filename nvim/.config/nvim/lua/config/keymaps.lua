local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation (vim keys)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered on search & jumps
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Better paste (don't overwrite register)
map("x", "<leader>p", [["_dP]])

-- Yank to system clipboard (ThePrimeagen special)
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Delete without yanking
map({ "n", "v" }, "<leader>d", [["_d]])

-- Quick escape
map("i", "jk", "<ESC>")

-- Terminal
map("n", "<leader>t", ":ToggleTerm<CR>")

-- File tree
map("n", "<leader>e", ":Neotree toggle<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")

-- LSP (set in lsp config, but common ones here)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)

-- DAP (debugger)
map("n", "<leader>db", ":DapToggleBreakpoint<CR>")
map("n", "<leader>dc", ":DapContinue<CR>")
map("n", "<leader>dn", ":DapStepOver<CR>")
map("n", "<leader>di", ":DapStepInto<CR>")
map("n", "<leader>do", ":DapStepOut<CR>")
map("n", "<leader>du", ":lua require('dapui').toggle()<CR>")
