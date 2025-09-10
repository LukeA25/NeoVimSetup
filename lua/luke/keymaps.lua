-- ========= File tree & terminal user commands =========
-- :FT -> toggle nvim-tree
vim.api.nvim_create_user_command("FT", "NvimTreeToggle", {})

-- :T -> open a horizontal ToggleTerm (re-uses the same hidden terminal)
vim.api.nvim_create_user_command("T", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local runner = Terminal:new({
    direction = "horizontal",
    close_on_exit = false,
    hidden = true,
  })
  runner:toggle()
end, {})

-- ========= Diagnostics popup (your old map) =========
vim.keymap.set("n", "<C-d>", vim.diagnostic.open_float, { silent = true })

-- ========= Window navigation =========
vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

vim.keymap.set("n", "<Tab>", function()
  local ft = vim.bo.filetype
  if ft ~= "NvimTree" and ft ~= "netrw" and ft ~= "oil" then
    vim.cmd("wincmd w")
  end
end, { silent = true })

-- Delete to close and save window
vim.keymap.set("n", "<Del>", function()
  if vim.bo.modified then
    vim.cmd("update")
  end
  if #vim.api.nvim_list_wins() > 1 then
    pcall(vim.cmd, "close")
  else
    pcall(vim.cmd, "q")
  end
end, { silent = true })

-- ========= File finding (Telescope) =========
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true })

-- ========= File tree toggle (convenience) =========
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })

-- ========= LSP: smart help on K (params if in call, else docs) =========
vim.keymap.set("n", "K", function()
  local ok = pcall(vim.lsp.buf.signature_help)
  if not ok then vim.lsp.buf.hover() end
end, { silent = true })
vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, { buffer = bufnr, silent = true })

-- ========= Yank highlight =========
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- ========= Save and Close =========
-- Save (only if modified) and close the current window with <Del>
vim.keymap.set("n", "<Del>", function()
  -- write only if modified
  if vim.bo.modified then
    vim.cmd("update")
  end
  -- if more than one window, just close this one; otherwise quit
  if #vim.api.nvim_list_wins() > 1 then
    pcall(vim.cmd, "close")
  else
    pcall(vim.cmd, "q")
  end
end, { silent = true })

-- ========= Markdown Preview =========
vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true })
