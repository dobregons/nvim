return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	event = "InsertEnter",
	dependencies = {
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
	},
	build = ":COQdeps",
	init = function()
		vim.g.coq_settings = {
			auto_start = "shut-up",
			keymap = {
				recommended = false,
				jump_to_mark = "<C-n>",
			},
			display = {
				preview = {
					border = "rounded",
				},
			},
		}
	end,
	config = function()
		local coq = require("coq")
		coq.Now()

		-- Keymaps for completion
		-- - Tab: Accept completion
		-- DIsabled Ctrl-j/k since that interfers with other commands
		-- - Ctrl-j/k: Navigate down/up in completion menu
		-- - Ctrl-Space: Trigger/cancel completion
		vim.keymap.set("i", "<Tab>", function()
			return vim.fn.pumvisible() == 1 and "<C-y>" or "<Tab>"
		end, { expr = true, silent = true })

		-- vim.keymap.set("i", "<C-j>", function()
		-- 	return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
		-- end, { expr = true, silent = true })

		-- vim.keymap.set("i", "<C-k>", function()
		-- 	return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
		-- end, { expr = true, silent = true })

		vim.keymap.set("i", "<C-Space>", function()
			return vim.fn.pumvisible() == 1 and "<C-e>" or "<C-x><C-o>"
		end, { expr = true, silent = true })
	end,
}
