vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.cmd(':set noexpandtab')
vim.cmd(':set listchars=space:.,tab:-->')
vim.cmd(':set list')
vim.cmd(":set number relativenumber")

vim.api.nvim_create_autocmd("VimEnter", {
 once = true,
 callback = function()
  vim.cmd(":hi LineNrAbove guifg=#FF2222")
  vim.cmd(":hi LineNrBelow guifg=#22FF22")
  vim.cmd(":hi LineNr guifg=#31C0DC")
  vim.cmd(":hi Normal guibg=NONE")
 end,
})

vim.opt.fileformats = "unix,dos"
vim.opt.guicursor = "i:block"

vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.opt.updatetime = 50

vim.diagnostic.config({
	virtual_text = false,
})
