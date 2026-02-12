return {
	"kokusenz/deltaview.nvim",
	cmd = { "DeltaMenu", "DeltaView", "Delta" },
	keys = {
		{ "<leader>dm", "<cmd>DeltaMenu<cr>", desc = "Delta Menu" },
		{ "<leader>dl", "<cmd>DeltaView<cr>", desc = "Delta View" },
		{ "<leader>da", "<cmd>Delta<cr>", desc = "Delta" },
	},
	config = function()
		require("deltaview").setup({
			-- Show both previous and next filenames when navigating
			show_verbose_nav = false,

			-- Configures the position of the quick select
			-- 'hsplit': horizontal split window
			-- 'center': centered floating window
			-- 'bottom': centered at the bottom, floating window
			quick_select_view = "hsplit",

			-- Number of files threshold for switching to fzf
			-- When the number of modified files >= this value, use fzf instead of quickselect
			fzf_threshold = 6,

			-- Custom keybindings
			keyconfig = {
				-- Global keybind to toggle DeltaMenu
				dm_toggle_keybind = "<leader>dm",

				-- Global keybind to toggle DeltaView (and exit diff if open)
				dv_toggle_keybind = "<leader>dl",

				-- Global keybind to toggle Delta (and exit diff if open)
				d_toggle_keybind = "<leader>da",

				-- Navigate between hunks in a diff
				next_hunk = "<Tab>",
				prev_hunk = "<S-Tab>",

				-- Navigate between files (when opened from DeltaMenu)
				next_diff = "]f",
				prev_diff = "[f",

				-- Change diff menu view to quickselect (when in fzf mode)
				fzf_toggle = "alt-;",

				-- Jump to line in view opened by Delta
				jump_to_line = "<CR>",
			},
		})
	end,
}

