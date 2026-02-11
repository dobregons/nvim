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
    })
  end,
}