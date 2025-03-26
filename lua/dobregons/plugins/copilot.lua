return {
	"github/copilot.vim",
	event = "InsertEnter", -- Lazy-load Copilot when entering insert mode
	config = function()
		-- Optionally configure Copilot settings here
		-- vim.g.copilot_no_tab_map = true -- Disable default `<Tab>` mapping
		vim.g.copilot_assume_mapped = true
		vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	end,
}
