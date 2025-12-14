-- return {
--   {
--     "tpope/vim-dispatch",
--     lazy = false,
--     config = function()
--       -- Key mapping to run the current C++ file
--       vim.api.nvim_set_keymap(
--         "n",
--         "<leader>r",
--         ":Dispatch g++ % -o %:t:r && ./%:t:r<CR>",
--         { noremap = true, silent = true }
--       )
--     end,
--   },
-- }
--

-- return {
--   {
--     "akinsho/toggleterm.nvim",
--     lazy = false,
--     config = function()
--       require("toggleterm").setup()
--     end,
--   },
--   vim.api.nvim_set_keymap(
--     "n",
--     "<leader>r",
--     ":ToggleTerm exec 'g++ % -o %:t:r && ./%:t:r'<CR>",
--     { noremap = true, silent = true }
--   ),
-- }
--
-- return {
--   {
--     "kassio/neoterm",
--     lazy = false,
--   },
--   vim.api.nvim_set_keymap("n", "<leader>r", ":T g++ %<CR>", { noremap = true, silent = true }),
-- }
return {
  {
    "kassio/neoterm",
    lazy = false,
  },
  -- Key mapping to compile and run the current C++ file
  vim.api.nvim_set_keymap("n", "<leader>rr", ":T g++ % -o a.out && ./a.out<CR>", { noremap = true, silent = true }),
}
