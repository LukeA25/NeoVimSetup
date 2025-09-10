-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.mouse = "a"
vim.cmd("syntax enable")

-- UI tweaks
vim.cmd([[
  hi WinSeparator guifg=#AAAAAA guibg=NONE
  highlight StatusLine   guibg=#23232e guifg=#cdd6f4
  highlight StatusLineNC guibg=#23232e guifg=#888888
]])

-- Exception: Makefiles require real tabs (no spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab   = false
    vim.opt_local.tabstop     = 8
    vim.opt_local.shiftwidth  = 8
    vim.opt_local.softtabstop = 0
  end,
})
