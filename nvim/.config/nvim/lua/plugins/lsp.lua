return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"zls",
					"ts_ls",
					"gopls",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			-- lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
					keymaps = {
						goto_definition = "gD",
						hover = "K",
						rename = "gR",
					},
				},
			})
			-- typescript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			-- yaml
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			-- tailwindcss
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({ capabilities = capabilities })
			--java
			lspconfig.jdtls.setup({
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "default",
									path = "",
									default = true,
								},
							},
						},
					},
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- list all methods in a file
			-- working with go confirmed, don't know about other, keep changing as necessary
			vim.keymap.set("n", "<leader>fm", function()
				local filetype = vim.bo.filetype
				local symbols_map = {
					python = "function",
					javascript = "function",
					typescript = "function",
					java = "class",
					lua = "function",
				}
				local symbols = symbols_map[filetype] or "function"
				require("telescope.builtin").lsp_document_symbols({ symbols = symbols })
			end, {})
		end,
	},
}
