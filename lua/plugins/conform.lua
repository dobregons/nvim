return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      python = { "black" },
      lua = { "stylua" },
      go = { "gofmt", "goimports" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      prettier = {
        prepend_args = { "--single-quote", "--jsx-single-quote" },
      },
    },
  },
}
