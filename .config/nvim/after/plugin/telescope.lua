local default_map_opts = {noremap = true, silent = true}

require("telescope").setup {
    defaults = {
        file_ignore_patterns = {"node_modules", "package-lock.json"},
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " > ",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = require("telescope.actions").send_to_qflist
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        }
    }
}
require("telescope").load_extension("gh")
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("live_grep_args")

vim.api.nvim_set_keymap(
    "n",
    "<C-f>",
    ":lua require('telescope.builtin').git_files()<CR>",
    default_map_opts
)

vim.api.nvim_set_keymap(
    "n",
    "<C-g>",
    ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
    default_map_opts
)

vim.api.nvim_set_keymap(
    "n",
    "<Leader>fp",
    ":lua require('telescope').extensions.gh.pull_request()<CR>",
    default_map_opts
)

vim.api.nvim_set_keymap(
    "n",
    "<C-t>",
    ":Telescope<CR>",
    default_map_opts

)
