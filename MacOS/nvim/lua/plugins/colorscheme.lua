return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  --{ "adamkali/vaporlush", dependencies = { "rktjmp/lush.nvim" } },
  --add Abstract-CS colorscheme
  { "Abstract-IDE/Abstract-cs" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight",
      -- colorscheme = "industry",
      -- colorscheme = "elflord",
      colorscheme = "abscs",
    },
  },

  -- it won't work if you only add the below contents to autocmd.lua file
  -- uncomment below ten lines to make the backgroung black
  -- vim.api.nvim_exec(
  -- 	[[
  -- autocmd VimEnter * hi Normal guibg=#000000 ctermbg=16
  -- autocmd VimEnter * hi NormalNC guibg=#000000 ctermbg=16
  -- autocmd VimEnter * hi VertSplit guibg=#000000 ctermbg=16
  -- autocmd VimEnter * hi StatusLine guibg=#000000 ctermbg=16
  -- autocmd VimEnter * hi StatusLineNC guibg=#000000 ctermbg=16
  -- ]],
  -- 	false
  -- ),
}
