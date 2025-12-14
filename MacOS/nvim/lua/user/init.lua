-- =====
-- -- ~/.config/nvim/lua/user/init.lua
--
-- -- Function to insert template from user/templates directory
-- local function insert_template()
--   local template_dir = "/Users/apple/.config/nvim/lua/user/templates" -- Path to your templates
--   local template_files = vim.fn.systemlist("ls " .. template_dir) -- List template files
--
--   -- Use FZF to select a template file
--   local selected_template =
--     vim.fn.fzf_select(template_files, { ["options"] = '--preview "cat ' .. template_dir .. '/{1}"' })
--
--   if selected_template then
--     local template_path = template_dir .. "/" .. selected_template[1] -- Full path to the selected template
--     local template_content = vim.fn.readfile(template_path) -- Read the content of the selected template
--
--     -- Insert the content into the current buffer at the cursor position
--     vim.api.nvim_put(template_content, "l", true, true)
--   end
-- end
--
-- -- Key mapping for inserting a template
-- vim.api.nvim_set_keymap("n", "<leader>it", ":lua insert_template()<CR>", { noremap = true, silent = true })
--
-- ======

-- =====
-- -- ~/.config/nvim/lua/user/init.lua
--
-- -- Define the insert_template function globally
-- _G.insert_template = function()
--   local template_dir = "/Users/apple/.config/nvim/lua/user/templates" -- Path to your templates
--   local template_files = vim.fn.systemlist("ls " .. template_dir) -- List template files
--
--   -- Check if fzf is available in vim
--   if vim.fn.exists(":FZF") == 2 then
--     -- Run fzf and select template
--     local selected_template = vim.fn["fzf#run"]({
--       source = template_files,
--       sink = function(selected)
--         if selected then
--           local template_path = template_dir .. "/" .. selected
--           local template_content = vim.fn.readfile(template_path)
--           vim.api.nvim_put(template_content, "l", true, true)
--         end
--       end,
--       options = '--preview "cat ' .. template_dir .. '/{1}"',
--     })
--   else
--     -- Simple selection fallback if fzf#run is unavailable
--     local selected_template = vim.fn.inputlist(template_files)
--     if selected_template > 0 then
--       local template_path = template_dir .. "/" .. template_files[selected_template]
--       local template_content = vim.fn.readfile(template_path)
--       vim.api.nvim_put(template_content, "l", true, true)
--     end
--   end
-- end
--
-- -- Key mapping for inserting a template
-- vim.api.nvim_set_keymap("n", "<leader>it", ":lua insert_template()<CR>", { noremap = true, silent = true })
-- ====
--
--
--
--
--
--
--
--
--
--
--
-- -- ~/.config/nvim/lua/user/init.lua
--
-- -- Define the insert_template function globally
-- _G.insert_template = function()
--   local template_dir = "/Users/apple/.config/nvim/lua/user/templates" -- Path to your templates
--   local template_files = vim.fn.systemlist("ls " .. template_dir) -- List template files
--
--   -- Check if fzf is available in vim
--   if vim.fn.exists(":FZF") == 2 then
--     -- Run fzf and select template
--     local selected_template = vim.fn["fzf#run"]({
--       source = template_files,
--       sink = function(selected)
--         if selected then
--           local template_path = template_dir .. "/" .. selected
--           local template_content = vim.fn.readfile(template_path)
--
--           -- Replace %DATE% placeholder with current date
--           local date_str = os.date("%d %B %Y")
--           for i, line in ipairs(template_content) do
--             template_content[i] = line:gsub("%%DATE%%", date_str)
--           end
--
--           vim.api.nvim_put(template_content, "l", true, true)
--         end
--       end,
--       options = '--preview "cat ' .. template_dir .. '/{1}"',
--     })
--   else
--     -- Simple selection fallback if fzf#run is unavailable
--     local selected_template = vim.fn.inputlist(template_files)
--     if selected_template > 0 then
--       local template_path = template_dir .. "/" .. template_files[selected_template]
--       local template_content = vim.fn.readfile(template_path)
--
--       -- Replace %DATE% placeholder with current date
--       local date_str = os.date("%d %B %Y")
--       for i, line in ipairs(template_content) do
--         template_content[i] = line:gsub("%%DATE%%", date_str)
--       end
--
--       vim.api.nvim_put(template_content, "l", true, true)
--     end
--   end
-- end
--
-- -- Key mapping for inserting a template
-- vim.api.nvim_set_keymap("n", "<leader>it", ":lua insert_template()<CR>", { noremap = true, silent = true })
--
--
--
--
--
--
--
--
--
--
--
--
--
--

-- ~/.config/nvim/lua/user/init.lua

-- Function to add ordinal suffix to day number
local function add_ordinal_suffix(day)
  local suffix = "th"
  if day % 10 == 1 and day ~= 11 then
    suffix = "st"
  elseif day % 10 == 2 and day ~= 12 then
    suffix = "nd"
  elseif day % 10 == 3 and day ~= 13 then
    suffix = "rd"
  end
  return day .. suffix
end

-- Define the insert_template function globally
_G.insert_template = function()
  local template_dir = "/Users/apple/.config/nvim/lua/user/templates" -- Path to your templates
  local template_files = vim.fn.systemlist("ls " .. template_dir) -- List template files

  -- Check if fzf is available in vim
  if vim.fn.exists(":FZF") == 2 then
    -- Run fzf and select template
    local selected_template = vim.fn["fzf#run"]({
      source = template_files,
      sink = function(selected)
        if selected then
          local template_path = template_dir .. "/" .. selected
          local template_content = vim.fn.readfile(template_path)

          -- Replace %DATE% placeholder with current date in "4th November 2024" format
          local day = tonumber(os.date("%d"))
          local date_str = add_ordinal_suffix(day) .. " " .. os.date("%B %Y")
          local author_name = "Shashank" -- Replace %AUTHOR% with your name

          for i, line in ipairs(template_content) do
            template_content[i] = line:gsub("%%DATE%%", date_str)
            template_content[i] = template_content[i]:gsub("%%USER%%", author_name) -- Replace %AUTHOR%
          end

          vim.api.nvim_put(template_content, "l", true, true)
        end
      end,
      options = '--preview "cat ' .. template_dir .. '/{1}"',
    })
  else
    -- Simple selection fallback if fzf#run is unavailable
    local selected_template = vim.fn.inputlist(template_files)
    if selected_template > 0 then
      local template_path = template_dir .. "/" .. template_files[selected_template]
      local template_content = vim.fn.readfile(template_path)

      -- Replace %DATE% placeholder with current date in "4th November 2024" format
      local day = tonumber(os.date("%d"))
      local date_str = add_ordinal_suffix(day) .. " " .. os.date("%B %Y")
      local author_name = "Shashank" -- Replace %AUTHOR% with your name

      for i, line in ipairs(template_content) do
        template_content[i] = line:gsub("%%DATE%%", date_str)
        template_content[i] = template_content[i]:gsub("%%USER%%", author_name) -- Replace %AUTHOR%
      end

      vim.api.nvim_put(template_content, "l", true, true)
    end
  end
end

-- Key mapping for inserting a template
vim.api.nvim_set_keymap("n", "<leader>it", ":lua insert_template()<CR>", { noremap = true, silent = true })

--
--
--
--
--
--
-- =========================================================================================================
-- lsp cofiguration to toggle between comepetitive programming and project development period
-- =========================================================================================================
--
--
--
-- -- ~/.config/nvim/lua/user/init.lua
--
-- -- Function to set minimal LSP for competitive programming
-- local function set_competitive_lsp()
--   local cmp = require("cmp")
--   cmp.setup({
--     sources = {
--       { name = "buffer", keyword_length = 3 }, -- Suggest buffer words
--       { name = "nvim_lsp", max_item_count = 5 }, -- Limited LSP suggestions
--     },
--     completion = {
--       autocomplete = false, -- Disable automatic popup
--     },
--     mapping = cmp.mapping.preset.insert({
--       ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
--     }),
--   })
--
--   -- Limit diagnostics to warnings and errors
--   vim.diagnostic.config({
--     virtual_text = false,
--     signs = true,
--     severity_sort = true,
--     update_in_insert = false,
--   })
-- end
--
-- -- Toggle to competitive mode
-- _G.toggle_competitive_mode = function()
--   if vim.g.competitive_mode_enabled then
--     vim.cmd("echo 'Competitive Mode Disabled'")
--     vim.g.competitive_mode_enabled = false
--     vim.cmd("PackerLoad nvim-lspconfig") -- Re-enable full LSP if unloaded
--   else
--     set_competitive_lsp()
--     vim.g.competitive_mode_enabled = true
--     vim.cmd("echo 'Competitive Mode Enabled'")
--   end
-- end
--
-- -- Key mapping to toggle competitive mode
-- vim.api.nvim_set_keymap("n", "<leader>tc", ":lua toggle_competitive_mode()<CR>", { noremap = true, silent = true })
--
--
--
--
--////////// To only supress the auto suggestions /////////////

-- NOTE: Use <leader> tc to toggle for suggestions.
-- all are in their default action, can be supressid with below keybindings.
-- local cmp = require("cmp")
--
-- cmp.setup({
--   enabled = true, -- Enable completion globally
-- })

vim.api.nvim_set_keymap(
  "n",
  "<leader>tc",
  ":lua require('cmp').setup({enabled = not require('cmp').get_config().enabled})<CR>",
  { noremap = true, silent = true }
)

-- Keymap for stopping LSP
vim.api.nvim_set_keymap("n", "<leader>ts", ":LspStop<CR>", { noremap = true, silent = true })

--
--
-- =========================================================================================================
