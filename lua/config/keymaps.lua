local M = {}

M.setup = function()
    -- Mini Pick keymaps
    vim.keymap.set("n", "<Leader>ff", '<cmd>Pick files<cr>', { desc = "Search Files" })
    vim.keymap.set("n", "<Leader>/", '<cmd>Pick grep_live<cr>', { desc = "Search Grep" })
    vim.keymap.set("n", "<Leader>bb", '<cmd>Pick buffers<cr>', { desc = "Search Buffers" })
    vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<cr>', {desc = 'Search help tags'})
    vim.keymap.set('n', '<leader>fr', '<cmd>Pick resume<cr>', {desc = 'Resume search'})

    -- Mini Files keymaps
    -- Note: Additional keymaps for mini.files are configured in lua/plugins/mini-files.lua
    -- These include: <C-s> split, <C-v> vsplit, <C-t> tab, yy/yp/Y copy commands
    -- They only work inside mini.files buffers

end

return M
