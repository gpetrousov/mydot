return {
    "kevalin/mermaid.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        format = {
            shift_width = 4,
        },
        lint = {
            enabled = false,
        },
        preview = {
            port = 0,
            renderer = "mermaid.js",
            theme = "default",
        },
    },
    keys = {
        { "<leader>mp", "<cmd>MermaidPreview<cr>", desc = "Mermaid preview" },
    },
}
