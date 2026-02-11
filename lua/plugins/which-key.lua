return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register key groups using the new spec format
    wk.add({
      { "<leader>b", group = "Buffers" },
      { "<leader>f", group = "Files" },
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Refactor" },
      { "g", group = "Go to" },
      { "[", group = "Previous" },
      { "]", group = "Next" },
    })

    -- Register LSP mappings when LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        wk.add({
          { "gd", desc = "Go to definition", buffer = event.buf },
          { "gD", desc = "Go to declaration", buffer = event.buf },
          { "gi", desc = "Go to implementation", buffer = event.buf },
          { "gr", desc = "Go to references", buffer = event.buf },
          { "gt", desc = "Go to type definition", buffer = event.buf },
        }, { buffer = event.buf })
      end,
    })
  end,
}