return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		delay = 150,
		large_file_cutoff = 2000,
		large_file_overrides = {
			providers = { "lsp" },
		},
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		-- Ensure clearly visible highlights across dark background
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3e4451", underline = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3e4451", underline = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3e4451", underline = true })

		local function map(key, dir)
			vim.keymap.set({ "n", "v" }, key, function()
				require("illuminate")["goto_" .. dir .. "_reference"](true)
			end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference" })
		end

		-- Vim-idiomatic bracket and leader fallbacks (guaranteed across all terminals/Wayland)
		map("]r", "next")
		map("[r", "prev")
	end,
}
