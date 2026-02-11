local M = {}

M.setup = function()
    -- Mini Pick keymaps
    vim.keymap.set("n", "<Leader>ff", '<cmd>Pick files<cr>', { desc = "Search Files" })
    vim.keymap.set("n", "<Leader>/", '<cmd>Pick grep_live<cr>', { desc = "Search Grep" })
    vim.keymap.set("n", "<Leader>bb", '<cmd>Pick buffers<cr>', { desc = "Search Buffers" })
    vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<cr>', {desc = 'Search help tags'})
    vim.keymap.set('n', '<leader>fr', '<cmd>Pick resume<cr>', {desc = 'Resume search'})

    -- Mini Files keymaps (only work inside mini.files buffers)
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        -- Copy filename
        vim.keymap.set("n", "yy", function()
          local entry = require("mini.files").get_fs_entry()
          if entry then
            local filename = vim.fn.fnamemodify(entry.path, ":t")
            vim.fn.setreg("+", filename)
            vim.notify("Copied: " .. filename)
          end
        end, { buffer = buf_id, desc = "Copy filename" })

        -- Copy absolute path
        vim.keymap.set("n", "yp", function()
          local entry = require("mini.files").get_fs_entry()
          if entry then
            vim.fn.setreg("+", entry.path)
            vim.notify("Copied: " .. entry.path)
          end
        end, { buffer = buf_id, desc = "Copy absolute path" })

        -- Copy relative path
        vim.keymap.set("n", "Y", function()
          local entry = require("mini.files").get_fs_entry()
          if entry then
            local relative = vim.fn.fnamemodify(entry.path, ":.")
            vim.fn.setreg("+", relative)
            vim.notify("Copied: " .. relative)
          end
        end, { buffer = buf_id, desc = "Copy relative path" })
      end,
    })

    -- FZF keymaps
    -- vim.keymap.set("n", "<Leader>ff", "<Cmd>Files<CR>", { desc = "Find files" })
    -- vim.keymap.set("n", "<Leader>bb", "<Cmd>Buffers<CR>", { desc = "Find buffers" })
    -- vim.keymap.set("n", "<Leader>/", "<Cmd>Rg<CR>", { desc = "Search text in project" })
end

return M
