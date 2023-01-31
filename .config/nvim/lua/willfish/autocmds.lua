local M = {}

function M.create_augroups_and_aucmds()
    local style_group_id = vim.api.nvim_create_augroup("Styles", {clear = true})

    vim.api.nvim_create_autocmd(
        "FileType",
        {
            pattern = {"help", "qf", "fugitive"},
            callback = function()
                vim.schedule(
                    function()
                        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", {noremap = true, silent = true})
                    end
                )
            end,
            group = style_group_id
        }
    )

    vim.api.nvim_create_autocmd(
        "TextYankPost",
        {
            pattern = "*",
            callback = function()
                vim.schedule(
                    function()
                        require("vim.highlight").on_yank()
                    end
                )
            end,
            group = style_group_id
        }
    )

    vim.api.nvim_create_autocmd(
        "VimEnter",
        {
            pattern = "*",
            nested = true,
            callback = function()
                vim.schedule(
                    function()
                        local os = require("os")
                        local default_map_opts = {noremap = true, silent = true}

                        if (os.execute("test -e .git/") == 0) then
                            vim.api.nvim_set_keymap(
                                "n",
                                "<C-f>",
                                ":lua require('telescope.builtin').git_files()<CR>",
                                default_map_opts
                            )
                        else
                            vim.api.nvim_set_keymap(
                                "n",
                                "<C-f>",
                                ":lua require('telescope.builtin').find_files()<CR>",
                                default_map_opts
                            )
                        end

                        vim.api.nvim_command("colorscheme oxocarbon")
                        -- TODO: Make active buffer non-transparent and inactive buffer transparent
                        vim.api.nvim_command("hi Normal guibg=NONE ctermbg=NONE")
                        vim.api.nvim_command("hi EndOfBuffer guibg=NONE ctermbg=NONE")
                    end
                )
            end,
            group = style_group_id
        }
    )
    vim.api.nvim_create_autocmd(
        "BufRead",
        {
            pattern = "/home/william/.i3/config",
            nested = true,
            callback = function()
                vim.api.nvim_command("set filetype=i3config")
            end,
            group = style_group_id
        }
    )
end

M.create_augroups_and_aucmds()

return M
