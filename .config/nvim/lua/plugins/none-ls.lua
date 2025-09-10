--[[ This is a tool which allows you to use CLI tools, such as formatters and linters with neovim  ]]
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- An opinionated code formatter for Lua.
				null_ls.builtins.formatting.stylua,

				-- Python formatting
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,

				-- Spell suggestions completion source.
				null_ls.builtins.completion.spell,
			},
		})

		-- Format .lua files with stylua formatter - installed via Mason
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
