vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.remap")
require("config.set")

vim.cmd[[colorscheme kanagawa-wave]]
vim.cmd[[set tabstop=4]]


