return {
  -- Add FZF binary
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  -- Add FZF for Neovim integration
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
  },
}
