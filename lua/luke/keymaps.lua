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

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- ========= Diagnostics popup (your old map) =========
vim.keymap.set("n", "<C-d>", vim.diagnostic.open_float, { silent = true })

-- ========= TODO Comment Jump =========
local todo = require("todo-comments")

local function cursor_pos()
  local l, c = unpack(vim.api.nvim_win_get_cursor(0))
  return l, c
end

local function jump_next_cycle()
  local l1, c1 = cursor_pos()
  todo.jump_next()                -- regular jump
  local l2, c2 = cursor_pos()
  if l1 == l2 and c1 == c2 then   -- didn't move -> wrap to top then jump
    vim.api.nvim_win_set_cursor(0, {1, 0})
    todo.jump_next()
  end
end

vim.keymap.set("n", "<leader>t", jump_next_cycle, { desc = "Next todo (cycle)" })

-- ========= Window navigation =========
vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })

vim.keymap.set("n", "<Tab>", function()
  local ft = vim.bo.filetype
  if ft ~= "NvimTree" and ft ~= "netrw" and ft ~= "oil" then
    vim.cmd("wincmd w")
  end
end, { silent = true })

-- Delete to close and save window
vim.keymap.set("n", "<BS>", function()
  if vim.bo.modified then
    vim.cmd("update")
  end
  if #vim.api.nvim_list_wins() > 1 then
    pcall(vim.cmd, "close")
  else
    pcall(vim.cmd, "q")
  end
end, { silent = true })

-- New Windows
vim.keymap.set("n", "<leader>v", function()
  vim.cmd("vsplit")
  vim.cmd("Telescope find_files")
end, { silent = true })
vim.keymap.set("n", "<leader>s", function()
  vim.cmd("split")
  vim.cmd("Telescope find_files")
end, { silent = true })

-- ========= Window Resizing =========
local resize_mode = false

local function toggle_resize_mode()
  resize_mode = not resize_mode
  if resize_mode then
    print("Resize Mode ON (h/j/k/l)")
    vim.keymap.set("n", "h", ":vertical resize +3<CR>", { silent = true, buffer = 0 })
    vim.keymap.set("n", "l", ":vertical resize -3<CR>", { silent = true, buffer = 0 })
    vim.keymap.set("n", "j", ":resize +3<CR>", { silent = true, buffer = 0 })
    vim.keymap.set("n", "k", ":resize -3<CR>", { silent = true, buffer = 0 })
  else
    print("Resize Mode OFF")
    vim.keymap.del("n", "h", { buffer = 0 })
    vim.keymap.del("n", "l", { buffer = 0 })
    vim.keymap.del("n", "j", { buffer = 0 })
    vim.keymap.del("n", "k", { buffer = 0 })
  end
end

vim.keymap.set("n", "<leader>r", toggle_resize_mode, { desc = "Toggle resize mode" })

-- ========== Window Swap Mode ==========
local swap_mode = false

local function toggle_swap_mode()
  swap_mode = not swap_mode
  if swap_mode then
    print("Swap Mode ON (h/j/k/l)")
    -- Swap with left/right/up/down
    vim.keymap.set("n", "h", "<C-w>H", { silent = true, buffer = 0 })
    vim.keymap.set("n", "l", "<C-w>L", { silent = true, buffer = 0 })
    vim.keymap.set("n", "k", "<C-w>K", { silent = true, buffer = 0 })
    vim.keymap.set("n", "j", "<C-w>J", { silent = true, buffer = 0 })
  else
    print("Swap Mode OFF")
    vim.keymap.del("n", "h", { buffer = 0 })
    vim.keymap.del("n", "l", { buffer = 0 })
    vim.keymap.del("n", "k", { buffer = 0 })
    vim.keymap.del("n", "j", { buffer = 0 })
  end
end

vim.keymap.set("n", "<leader>m", toggle_swap_mode, { desc = "Toggle swap window mode" })

-- ========= File finding (Telescope) =========
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true, })

-- ========= File tree toggle (convenience) =========
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })

-- ========= LSP: smart help on K (params if in call, else docs) =========
vim.keymap.set("n", "K", function()
  local ok = pcall(vim.lsp.buf.signature_help)
  if not ok then vim.lsp.buf.hover() end
end, { silent = true })

-- ========= Yank highlight =========
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- ========= Markdown Preview =========
vim.keymap.set("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true })
