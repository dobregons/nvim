return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	opts = {
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				width = { padding = 0 },
				height = { padding = 0 },
				preview_width = 0.5,
			},
		},
		sorting_strategy = "ascending",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function()
				trouble.toggle("quickfix")
			end,
		})

		local function normalize_path(path)
			return path:gsub("\\", "/")
		end

		local function normalize_cwd()
			return normalize_path(vim.loop.cwd()) .. "/"
		end

		local function is_subdirectory(cwd, path)
			return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
		end

		local function split_filepath(path)
			local normalized_path = normalize_path(path)
			local normalized_cwd = normalize_cwd()
			local filename = normalized_path:match("[^/]+$")

			if is_subdirectory(normalized_cwd, normalized_path) then
				local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
				return stripped_path, filename
			else
				local stripped_path = normalized_path:sub(1, -(#filename + 1))
				return stripped_path, filename
			end
		end

		local function path_display(_, path)
			local stripped_path, filename = split_filepath(path)
			if filename == stripped_path or stripped_path == "" then
				return filename
			end
			return string.format("%s ~ %s", filename, stripped_path)
		end

		telescope.setup({
			defaults = {
				path_display = path_display,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
					},
				},
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

		-- Telescope git commands
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
		keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
		keymap.set("n", "<leader>gd", "<cmd>Telescope git_diff<cr>", { desc = "Git diff" })
		keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Git bcommits" })
	end,
}
