-- return {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     opts = {
--         ensure_installed = {
--             "c",
--             "lua",
--             "vim",
--             "vimdoc",
--             "query",
--             "javascript",
--             "html",
--             "python",
--             "markdown",
--             "markdown_inline",
--             "terraform",
--         },
--         sync_install = false,
--         highlight = { enable = true },
--         indent = { enable = true },
--     },
-- }

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "html",
            "python",
            "markdown",
            "markdown_inline",
            "terraform",
        },
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    },
}
