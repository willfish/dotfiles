-- Folding can be expensive in larger files so I've moved to invoking this as I need it

vim.api.nvim_set_keymap("n", "<Leader>z", ":AnyFoldActivate<CR>", {noremap = true, silent = true})
vim.o.foldlevel = 1

