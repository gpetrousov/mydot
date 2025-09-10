return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
        highlight = { enable = true },
        indent = { enable = true },
    },
}
