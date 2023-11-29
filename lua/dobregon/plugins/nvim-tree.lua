local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loader = 1
vim.g.loader_netrwPLugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

nvimtree.setup({
	update_focused_file = {
		enable = true,
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					-- font installed in iterm2 is applied here - font installed is mononoki
					arrow_closed = "→", -- arrow when folder is closed
					arrow_open = "↓", -- arrow when folder is open
				},
			},
		},
	},
	-- Make file explorer and window splits work properly
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
