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
        vim.g.vimwiki_list = {{
          path = '~/notes',       -- 📁 change this to where your wiki folder is
          syntax = 'markdown',      -- 📝 use markdown syntax
          ext = '.md',              -- 📄 use .md as default file extension
        }}
        vim.g.vimwiki_global_ext = 0 -- prevent Vimwiki from treating all .md as wiki files
      end,
    },
    { "maxmellon/vim-jsx-pretty" },
    { "mg979/vim-visual-multi" },
    { "folke/which-key.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "charlespascoe/vim-go-syntax" },
    { import = "config.plugins" },
  },
  
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
