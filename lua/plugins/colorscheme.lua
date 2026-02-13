return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = true, -- Enable transparency
			show_end_of_buffer = false, -- Don't show '~' after buffer end
			integrations = {
				cmp = true,
				gitsigns = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.subtext0 }, -- Change line number color
					CursorLineNr = { fg = colors.yellow }, -- Change current line number color
					-- Number = { fg = colors.red }, -- This is for numeric literals in code
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
