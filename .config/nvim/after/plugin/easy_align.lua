local easy_align_delimiters = {}

easy_align_delimiters["-"] = {pattern = "\\-\\+", delimiter_align = "l", ignore_groups = {"!Comment"}}

vim.g.easy_align_delimiters = easy_align_delimiters
