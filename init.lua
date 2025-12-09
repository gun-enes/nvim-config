require("config.lazy")
require("config.config.treesitter")
require("config.remap")
require("config.set")

vim.cmd[[colorscheme kanagawa-wave]]
vim.cmd[[set tabstop=4]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "vimwiki" },
  callback = function()
    vim.keymap.set('n', '<Tab>', ':bp<CR>', { desc = "Previous buffer" })
    vim.keymap.set('n', '<S-Tab>', ':bn<CR>', { desc = "Next buffer" })
    vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { buffer = true })
  end,
})


