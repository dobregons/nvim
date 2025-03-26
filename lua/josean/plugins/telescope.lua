return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- "nvim-tree/nvim-web-devicons",
    -- "folke/todo-comments.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    -- local lga_actions = require('telescope-live-grep-args.actions')
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = { height = 0.95 },
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            -- mappings = {         -- extend mappings
            --   i = {
            --     ["<C-k>"] = lga_actions.quote_prompt(),
            --     ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            --   },
            -- },
          }
        }
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers in current instance" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
    keymap.set("n", "<leader>fl", "<cmd>Telescope live_grep_args<cr>", { desc = "Find string in cwd with args" })
    keymap.set("n", "<leader>fr", function()
      require("telescope.builtin").lsp_references()
    end, { desc = "Find references" })
    keymap.set("n", "<leader>ch", "<cmd>Telescope command_history<cr>", { desc = "Command history" })

    -- Telescope git commands
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
    keymap.set("n", "<leader>gd", "<cmd>Telescope git_diff<cr>", { desc = "Git diff" })
    keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Git bcommits" })
  end,
}
