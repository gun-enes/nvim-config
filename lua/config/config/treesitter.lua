return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- 1. SETUP CALL (This was the fix for your error)
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "lua", "rust", "java",
                    "jsdoc", "bash",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false, -- Recommended false for faster startup

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                indent = {
                    enable = true
                },

                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        if lang == "html" then
                            return true
                        end

                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    additional_vim_regex_highlighting = { "markdown" },
                },
            })

            -- 2. Custom Parser Config (Templ)
            local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            treesitter_parser_config.templ = {
                install_info = {
                    url = "https://github.com/vrischmann/tree-sitter-templ.git",
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "master",
                },
            }
            vim.treesitter.language.register("templ", "templ")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        -- 'after' is invalid in Lazy.nvim. Use 'dependencies' to ensure loading order.
        dependencies = { "nvim-treesitter/nvim-treesitter" }, 
        config = function()
            require('treesitter-context').setup {
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = 'outer',
                mode = 'cursor',
                separator = nil,
                zindex = 20,
            }
        end
    }
}
