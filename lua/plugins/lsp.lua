return {
	-- Mason for automatic LSP server installation
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"pyright",
					"rust_analyzer",
					"lua_ls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local coq = require("coq")

			-- Configure lua_ls with vim global
			vim.lsp.config.lua_ls = coq.lsp_ensure_capabilities({
				cmd = { "lua-language-server" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim", "MiniPick" }
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			-- Configure other servers
			vim.lsp.config.ts_ls = coq.lsp_ensure_capabilities({
				cmd = { "typescript-language-server", "--stdio" },
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			})

			vim.lsp.config.pyright = coq.lsp_ensure_capabilities({
				cmd = { "pyright-langserver", "--stdio" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
			})

			vim.lsp.config.rust_analyzer = coq.lsp_ensure_capabilities({
				cmd = { "rust-analyzer" },
				root_markers = { "Cargo.toml", "rust-project.json", ".git" },
			})

			-- Enable configured servers
			vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "rust_analyzer" })
		end,
	},
}
