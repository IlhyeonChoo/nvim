-- Keymaps are automatically loaded on the VeryLazy event.
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", "<cmd>" .. i .. "tabnext<cr>", { desc = "Go to Tab " .. i })
end

vim.keymap.set("n", "<A-0>", "<cmd>tablast<cr>", { desc = "Go to Last Tab" })
