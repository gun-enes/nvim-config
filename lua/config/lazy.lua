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
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` library is used
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        { import = "config.plugins" },
    },

    -- Your other settings remain unchanged
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})
