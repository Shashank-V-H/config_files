-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Here it remaps the <Esc> to kj
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })

-- Dismiss notice messages
-- vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
--
