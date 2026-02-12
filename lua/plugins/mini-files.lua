return {
	"nvim-mini/mini.files",
	opts = {
		windows = {
			preview = true,
			width_focus = 30,
			width_preview = 50,
		},
		options = {
			use_as_default_explorer = true,
		},
		mappings = {
			close = "<Esc>",
			go_in_plus = "<CR>",
			go_out = "h",
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		-- Set up keymaps for mini.files buffers
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				-- Open in splits/tabs
				vim.keymap.set("n", "<C-s>", function()
					local entry = require("mini.files").get_fs_entry()
					if entry and entry.fs_type == "file" then
						local cur_target_window = require("mini.files").get_explorer_state().target_window
						require("mini.files").close()
						if cur_target_window then
							vim.api.nvim_set_current_win(cur_target_window)
							vim.cmd("split " .. vim.fn.fnameescape(entry.path))
						end
					end
				end, { buffer = buf_id, desc = "Open in horizontal split" })

				vim.keymap.set("n", "<C-v>", function()
					local entry = require("mini.files").get_fs_entry()
					if entry and entry.fs_type == "file" then
						local cur_target_window = require("mini.files").get_explorer_state().target_window
						require("mini.files").close()
						if cur_target_window then
							vim.api.nvim_set_current_win(cur_target_window)
							vim.cmd("vsplit " .. vim.fn.fnameescape(entry.path))
						end
					end
				end, { buffer = buf_id, desc = "Open in vertical split" })

				vim.keymap.set("n", "<C-t>", function()
					local entry = require("mini.files").get_fs_entry()
					if entry and entry.fs_type == "file" then
						vim.cmd("tabedit " .. vim.fn.fnameescape(entry.path))
						require("mini.files").close()
					end
				end, { buffer = buf_id, desc = "Open in new tab" })

				-- Copy keymaps
				vim.keymap.set("n", "yy", function()
					local entry = require("mini.files").get_fs_entry()
					if entry then
						local filename = vim.fn.fnamemodify(entry.path, ":t")
						vim.fn.setreg("+", filename)
						vim.notify("Copied: " .. filename)
					end
				end, { buffer = buf_id, desc = "Copy filename" })

				vim.keymap.set("n", "yp", function()
					local entry = require("mini.files").get_fs_entry()
					if entry then
						vim.fn.setreg("+", entry.path)
						vim.notify("Copied: " .. entry.path)
					end
				end, { buffer = buf_id, desc = "Copy absolute path" })

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
	end,
	keys = {
		{
			"<leader>e",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (Directory of Current File)",
		},
		{
			"<leader>ee",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
}
