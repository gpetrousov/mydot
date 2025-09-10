return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Install more language servers here
					"lua_ls",
					"pylsp",
					"gopls",
					"terraformls",
					"html",
					"jinja_lsp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				vim.diagnostic.config({
					virtual_text = {
					--     -- This needs to be true to show inline messages
					--     -- You can customize prefix, etc., here if desired
					    prefix = "● ",
					},
					signs = true,
					underline = true,
					update_in_insert = false,
					float = {
						focusable = false,
						style = "minimal",
						border = "rounded",
						source = "always",
						header = "",
						prefix = "",
					},
				}, bufnr) -- Apply these settings specifically to the current buffer

				-- Your keymaps here (e.g., <Leader>d, K, [d, ]d)
				vim.keymap.set( "n", "<Leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" })
				vim.keymap.set( "n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover (includes diagnostics)" })
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" })
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
			end

			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			require("lspconfig").pylsp.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								maxLineLength = 120,
							},
						},
					},
				},
			})

			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})

			require("lspconfig").html.setup({
				capabilities = capabilities,
			})

			require("lspconfig").jinja_lsp.setup({
				capabilities = capabilities,
			})

			require("lspconfig").terraformls.setup({})

			-- Shift+k for definition+docs
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- GoTo definition - Jumps to the definition of the symbol under the cursor.
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)

			-- Get references
			vim.keymap.set("n", "gr", vim.lsp.buf.references)

			-- Get symbol - Jumps to the declaration of the symbol under the cursor.
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

			-- Code actions - suggestions on errors and warnings
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

			-- Show document symbols
			vim.keymap.set("n", "<leader>os", vim.lsp.buf.document_symbol, { desc = "󰌵 Document Symbols" })
		end,
	},
}
