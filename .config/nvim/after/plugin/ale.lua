local default_map_opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>a", ":ALEFix<CR>", default_map_opts)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fa",
    ":Dispatch git ls-files -m | grep '.rb' | xargs bundle exec rubocop -A<CR>",
    default_map_opts
)
vim.g.ale_ruby_rubocop_executable = "bundle"
vim.g.ale_ruby_rubocop_options = "-c .rubocop.yml"
vim.g.ale_set_highlights = 0
vim.g.ale_lint_delay = 2000

local ale_linters = {}
local ale_fixers = {}

ale_fixers["*"] = {"remove_trailing_lines", "trim_whitespace"}
ale_fixers["bash"] = {"shfmt"}
ale_fixers["css"] = {"prettier"}
ale_fixers["elixir"] = {"mix_format"}
ale_fixers["erb"] = {"erblint"}
ale_fixers["go"] = {"gofmt"}
ale_fixers["haml"] = {"haml-lint"}
ale_fixers["html"] = {"prettier"}
ale_fixers["javascript"] = {"eslint"}
ale_fixers["json"] = {"prettier"}
ale_fixers["lua"] = {"luafmt"}
ale_fixers["markdown"] = {"prettier"}
ale_fixers["python"] = {"black", "autoflake"}
ale_fixers["ruby"] = {"rubocop"}
ale_fixers["rust"] = {"rustfmt"}
ale_fixers["scss"] = {"prettier"}
ale_fixers["sh"] = {"shfmt"}
ale_fixers["sql"] = {"pgformatter"}
ale_fixers["terraform"] = {"terraform"}
ale_fixers["yaml"] = {"prettier"}

ale_linters["javascript"] = {"eslint"}

vim.g.ale_fixers = ale_fixers
vim.g.ale_linters = ale_linters
