-- Bootstrap lazy.nvim
local plugin_root = vim.fn.expand('<sfile>:p:h:h:h')
local lazypath = plugin_root .. "/test/config/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before lazy
vim.g.mapleader = ","
vim.g.maplocalleader = "-"

-- Setup plugins with lazy.nvim
require("lazy").setup({
  {
    "strottos/nvim-oxi-template",
    dir = vim.fn.expand(plugin_root),
    config = function()
      require("nvim_oxi_template").setup({})
    end,
    build = "cargo build --release",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
})

-- Optional: Add any additional Neovim settings below
vim.opt.number = true
