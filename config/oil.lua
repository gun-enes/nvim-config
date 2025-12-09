require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    columns = {{'icon', directory = '🚀', default_file = '🚀' }},
    skip_confirm_for_simple_edits = true,
    view_options = {
        is_hidden_file = function (name, buffnr)
            return vim.startswith(name, ".")
        end,
        show_hidden = true,
    },
    float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
    },
    win_options = {
        wrap = true,
        signcolumn = 'yes:1',
        winblend = 0,
    },
});
