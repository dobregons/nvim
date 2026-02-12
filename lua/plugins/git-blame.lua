return {
	"f-person/git-blame.nvim",
	event = "BufRead",
	config = function()
		require("gitblame").setup({
			enabled = false, -- Start disabled, toggle with :GitBlameToggle
			message_template = "<author> • <date> • <summary>",
			date_format = "%r", -- Relative date
			virtual_text_column = 1,
			delay = 500, -- Delay in ms before showing blame
			ignored_filetypes = { "NvimTree", "minifiles", "Trouble", "help" },
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle git blame" })
		vim.keymap.set("n", "<leader>go", "<cmd>GitBlameOpenCommitURL<cr>", { desc = "Open commit URL" })
		vim.keymap.set("n", "<leader>gc", "<cmd>GitBlameCopySHA<cr>", { desc = "Copy commit SHA" })
	end,
}

