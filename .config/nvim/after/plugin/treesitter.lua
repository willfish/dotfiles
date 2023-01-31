local default_map_opts = {noremap = true, silent = true}

require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = {
        enable = true
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart"
        }
    },
    endwise = {
        enable = true
    }
}

