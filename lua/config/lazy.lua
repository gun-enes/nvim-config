-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            "vimwiki/vimwiki",
            init = function()
                vim.g.vimwiki_list = {{ path = '~/notes', syntax = 'markdown', ext = '.md' }}
                vim.g.vimwiki_global_ext = 0
            end,
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        { "maxmellon/vim-jsx-pretty" },
        { "mg979/vim-visual-multi" },
        { "folke/which-key.nvim" },
        { "lewis6991/gitsigns.nvim" },
        { "charlespascoe/vim-go-syntax" },

    -- 👇 ADD SUPERMAVEN HERE 👇
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<Tab>", -- customize this if you want
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
          },
          ignore_filetypes = { cpp = true }, -- example: ignore specific filetypes
          color = {
            suggestion_color = "#888888",
            cterm = 244,
          }
        })
      end,
    },
    -- 👆 END SUPERMAVEN 👆

    { import = "config.plugins" },
  },
  
  -- Your other settings remain unchanged
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
