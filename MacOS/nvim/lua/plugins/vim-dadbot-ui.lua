-- return {
--   -- "tpope/vim-dadbod",
--   -- "kristijanhusak/vim-dadbod-completion",
--   -- "kristijanhusak/vim-dadbod-ui",
-- }
return {
  -- vim-dadbod
  {
    "tpope/vim-dadbod",
    lazy = true,
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer" },
  },
  -- Optional: UI wrapper for vim-dadbod
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer" },
    config = function()
      -- Set this to avoid opening a new tab for the UI
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- Optional: SQL completion
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql" }, -- Lazy-load for SQL files only
    config = function()
      require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    end,
  },
}
