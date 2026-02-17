local builtin = require('telescope.builtin') 
vim.g.mapleader = ' '  -- Space as leader

-- oil 
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })


vim.api.nvim_set_keymap('n', '<leader>x', '<Plug>VimwikiToggleListItem', {})

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
-- Go to previous buffer
vim.keymap.set('n', '<Tab>', ':bp<CR>', { desc = "Previous buffer" })

-- Go to next buffer
vim.keymap.set('n', '<S-Tab>', ':bn<CR>', { desc = "Next buffer" })

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('v', 'jk', '<Esc>') 
-- Vertical jump
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Quick save
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Clear search highlights
vim.keymap.set('n', '<leader><space>', 'za')

-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Make Y behave like D (copy to end of line)
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+y$')

-- Quick escape in terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Stay in visual mode when indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Resize splits with Ctrl + Arrow
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('x', '<leader>p', '\"_dP')




-- LSP settings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover info" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show error" })






-- Harpoon Setup
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- Fixed removal command
vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end) 
vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.keymap.set("n", "}", function()
  local lnum = vim.fn.line(".") + 1
  local last = vim.fn.line("$")
  while lnum <= last do
    local line = vim.fn.getline(lnum)
    if line:match("^%s*$") then
      vim.api.nvim_win_set_cursor(0, { lnum, 0 })
      return
    end
    lnum = lnum + 1
  end
end, { desc = "Jump to next blank or whitespace-only line" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "vimwiki" },
  callback = function()
    vim.keymap.set('n', '<Tab>', ':bp<CR>', { desc = "Previous buffer" })
    vim.keymap.set('n', '<S-Tab>', ':bn<CR>', { desc = "Next buffer" })
    vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { buffer = true })
  end,
})


