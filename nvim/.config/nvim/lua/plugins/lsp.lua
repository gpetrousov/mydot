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
					"pyright",
					"gopls",
					"terraformls",
					"html",
					"jinja_lsp",
                    "rust_analyzer"
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

			local function get_python_path(workspace)
				-- 1. Check if an active virtual environment is set in the shell (e.g. VIRTUAL_ENV)
				if vim.env.VIRTUAL_ENV then
					local env_path = vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
					if vim.uv.fs_stat(env_path) then
						return env_path
					end
				end

				-- 2. Look for project-local virtual environments (.venv or venv) in workspace or upward
				if workspace then
					local venv = vim.fs.find({ ".venv", "venv" }, { path = workspace, upward = true, type = "directory" })[1]
					if venv then
						local venv_python = vim.fs.joinpath(venv, "bin", "python")
						if vim.uv.fs_stat(venv_python) then
							return venv_python
						end
					end
				end

				-- 3. Fallback to system python3 or default python
				return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
			end

			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				before_init = function(_, config)
					config.settings = config.settings or {}
					config.settings.python = config.settings.python or {}
					config.settings.python.pythonPath = get_python_path(config.root_dir)
				end,
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
