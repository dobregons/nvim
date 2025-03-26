return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local sqlfluff_formatter = {
      formatCommand = "sqlfluff fix --force --no-progress",
      formatStdin = true,
    }

    -- Function to dynamically select formatter
    local function select_formatter(filetype)
      -- Use a SQL formatter if the filetype is "sql".
      if filetype == "sql" then
        return { sqlfluff_formatter } -- Change to your SQL formatter if needed.
      end

      local project_root = vim.fn.getcwd()

      -- Define repositories for Biome
      local biome_projects = {
        "/Users/pato.admi/GitProjects/integrations",
      }

      -- Check if current project matches any Biome project
      for _, biome_project in ipairs(biome_projects) do
        if project_root:find(biome_project, 1, true) then
          return filetype == "javascript"
              or filetype == "typescript"
              or filetype == "javascriptreact"
              or filetype == "typescriptreact" and { "biome" }
              or { "prettier" }
        end
      end

      -- Default to Prettier
      return { "prettier" }
    end

    conform.setup({
      formatters_by_ft = setmetatable({}, {
        __index = function(_, filetype)
          return select_formatter(filetype)
        end,
      }),
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
