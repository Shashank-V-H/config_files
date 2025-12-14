-- Check if the filetype is C++ and then set mappings
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    -- Compile and run with a.out in a terminal split on <F5>
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F5>",
      ":w<CR>:terminal g++ -std=c++17 % -o a.out && ./a.out<CR>",
      { noremap = true, silent = true }
    )

    -- Compile, run with input redirection, and output to output.txt in a terminal split on <F9>
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F9>",
      ":w<CR>:terminal g++ -std=c++17 % -o a.out && ./a.out < input.txt > output.txt<CR>",
      { noremap = true, silent = true }
    )
  end,
})

-- for detecting instant changes, but didn't work
--
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cpp",
--   callback = function()
--     -- Compile and run with a.out in a terminal split on <F5>
--     vim.api.nvim_buf_set_keymap(
--       0,
--       "n",
--       "<F5>",
--       ":w<CR>:terminal g++ -std=c++17 % -o a.out && ./a.out<CR>",
--       { noremap = true, silent = true }
--     )
--
--     -- Compile, run with input redirection, and output to output.txt in a terminal split on <F9>
--     vim.api.nvim_buf_set_keymap(
--       0,
--       "n",
--       "<F9>",
--       ":w<CR>:terminal g++ -std=c++17 % -o a.out && ./a.out < input.txt > output.txt<CR>",
--       { noremap = true, silent = true }
--     )
--
--     -- Set up automatic reload for output.txt when it changes
--     vim.api.nvim_create_autocmd({ "CursorHold", "FocusGained", "BufEnter" }, {
--       pattern = "output.txt",
--       command = "checktime", -- Check for external changes
--     })
--   end,
-- })

-- for detecting instant changes, but didn't work
--
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cpp",
--   callback = function()
--     -- Compile and run with a.out in a terminal split on <F5>
--     vim.api.nvim_buf_set_keymap(
--       0,
--       "n",
--       "<F5>",
--       ":w<CR>:terminal g++ -std=c++17 % -o a.out && ./a.out<CR>",
--       { noremap = true, silent = true }
--     )
--
--     -- Compile, run with input redirection, and output to output.txt in a terminal split on <F9>
--     vim.api.nvim_buf_set_keymap(
--       0,
--       "n",
--       "<F9>",
--       ":w<CR>:terminal g++ -std=c++17 % -o a.out && ./a.out < input.txt > output.txt<CR>",
--       { noremap = true, silent = true }
--     )
--
--     -- Set up timer to check for changes in output.txt every second
--     local output_timer = vim.loop.new_timer()
--     output_timer:start(
--       0, -- start immediately
--       1000, -- check every 1000ms (1 second)
--       vim.schedule_wrap(function()
--         -- Check if output.txt is open and reload if it's changed
--         if vim.fn.bufexists("output.txt") == 1 and vim.fn.getbufinfo("output.txt")[1].changedtick then
--           vim.cmd("checktime output.txt")
--         end
--       end)
--     )
--
--     -- Stop the timer when Neovim exits
--     vim.api.nvim_create_autocmd("VimLeavePre", {
--       callback = function()
--         output_timer:stop()
--         output_timer:close()
--       end,
--     })
--   end,
-- })
