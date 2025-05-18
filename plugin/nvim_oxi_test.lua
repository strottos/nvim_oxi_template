if vim.g.loaded_oxi_template then
    return
end
vim.g.loaded_oxi_template = true

if vim.fn.has("nvim-0.10") == 0 then
  vim.api.nvim_echo({
    { "Nards requires at least nvim-0.10", "ErrorMsg" },
    { "Please upgrade your neovim version", "WarningMsg" },
    { "Press any key to exit", "ErrorMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
end
