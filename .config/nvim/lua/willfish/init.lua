require("willfish.opts")     -- Global, Window and Buffer configuration options
require("willfish.maps")     -- Normal, Insert, Visual, Terminal mode mappings
require("willfish.autocmds") -- Autocmds

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/tokyonight.nvim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  "nyoom-engineering/oxocarbon.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-lua/plenary.nvim",
      "tsakirist/telescope-lazy.nvim",
    }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-git",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "honza/vim-snippets",
      "SirVer/ultisnips",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "github/copilot.vim"
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    tag = "nightly"
  },
  {
    "junnplus/lsp-setup.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/nvim-lsp-installer",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
      "folke/neodev.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    }
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    }
  },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat",
      "ggandor/flit.nvim",
    },
  },
  "mboughaba/i3config.vim",
  "tpope/vim-bundler",
  "sheerun/vim-polyglot",
  "junegunn/vim-easy-align",
  "RRethy/nvim-treesitter-textsubjects",
  "RRethy/nvim-treesitter-endwise",
  { "kana/vim-textobj-line",           dependencies = "kana/vim-textobj-user" },
  { "whatyouhide/vim-textobj-xmlattr", dependencies = "kana/vim-textobj-user" },
  { "b4winckler/vim-angry",            dependencies = "kana/vim-textobj-user" },
  { "michaeljsmith/vim-indent-object", dependencies = "kana/vim-textobj-user" },
  { "tek/vim-textobj-ruby",            dependencies = "kana/vim-textobj-user" },
  "christoomey/vim-sort-motion",
  "tpope/vim-commentary",
  "andymass/vim-matchup",
  "kylechui/nvim-surround",
  "tpope/vim-dispatch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "stefandtw/quickfix-reflector.vim",
  "tpope/vim-unimpaired",
  "kevinhwang91/nvim-bqf",
  "christoomey/vim-tmux-navigator",
  "vim-test/vim-test",
  "nvim-treesitter/playground",
  'Wansmer/treesj',
  'norcalli/nvim-colorizer.lua',
  keys = { '<leader>j', '<leader>J' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
})
