local M = {}

M.setup = function()
	vim.keymap.set("i", "jk", "<Esc>")

	vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

	-- window management
	vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
	vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
	vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
	vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

	-- quit!
	vim.keymap.set("n", "<leader>qq", "<Cmd>:qa<cr>")

	-- buffer
	vim.keymap.set("n", "<leader>bd", "<Cmd>bd<cr>", { desc = "Close buffer" })

	-- quickfix
	vim.keymap.set("n", "<leader>qc", "<Cmd>cclose<cr>", { desc = "Close quickfix" })
	vim.keymap.set("n", "<leader>qo", "<Cmd>copen<cr>", { desc = "Open quickfix" })

	-- Mini Pick keymaps
	vim.keymap.set("n", "<Leader>ff", "<cmd>Pick files<cr>", { desc = "Search Files" })
	vim.keymap.set("n", "<Leader>/", "<cmd>Pick grep_live<cr>", { desc = "Search Grep" })
	vim.keymap.set("n", "<Leader>bb", "<cmd>Pick buffers<cr>", { desc = "Search Buffers" })
	vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Search help tags" })
	vim.keymap.set("n", "<leader>fr", "<cmd>Pick resume<cr>", { desc = "Resume search" })

	-- Custom grep excluding test files and js files
	vim.keymap.set("n", "<leader>sg", function()
		MiniPick.builtin.grep_live({
			tool = "rg",
			extra_args = { "--glob", "!*.test.*", "--glob", "!*.js" },
		})
	end, { desc = "Search (no tests/js)" })

	-- Mini Files keymaps
	-- Note: Additional keymaps for mini.files are configured in lua/plugins/mini-files.lua
	-- These include: <C-s> split, <C-v> vsplit, <C-t> tab, yy/yp/Y copy commands
	-- They only work inside mini.files buffers

	-- LSP keymaps (attached when LSP is active)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local opts = { buffer = args.buf, silent = true }

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "Go to declaration" })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "Go to implementation" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Go to references" })
			vim.keymap.set(
				"n",
				"gt",
				vim.lsp.buf.type_definition,
				{ buffer = args.buf, desc = "Go to type definition" }
			)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover documentation" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ buffer = args.buf, desc = "Code action" }
			)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, { buffer = args.buf, desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, { buffer = args.buf, desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = args.buf, desc = "Show diagnostic" })
			-- Note: <leader>lf formatting is handled by conform.nvim in lua/plugins/conform.lua
		end,
	})
end

return M
