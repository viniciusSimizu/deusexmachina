vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader><esc>", vim.cmd.noh)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "ç", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "Ç", vim.cmd.NvimTreeFindFileToggle)

vim.keymap.set("n", "<C-S-h>", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-S-j>", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-S-k>", ":TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-S-l>", ":TmuxNavigateRight<CR>")
