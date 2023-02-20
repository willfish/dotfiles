local packer_exists = pcall(vim.cmd, "packadd packer.nvim")

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes) ") ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

  vim.fn.mkdir(directory, "p")

  vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print("Downloading packer.nvim...")

  vim.cmd("packadd packer.nvim")
end

require("packer").startup(
  function(use)
    use {
      "ggandor/leap.nvim",
      requires = {
        "tpope/vim-repeat",
        "ggandor/flit.nvim",
      },
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = {
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
        "folke/neodev.nvim"
      }
    } -- Autocompletion
    use "github/copilot.vim" -- AI sources for autocompletion (uses tab for completion as these are special)
    use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } } -- Insanely fast statusline
    use "folke/tokyonight.nvim"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- Symbolic syntax highlighting
    use "mboughaba/i3config.vim" -- i3 config syntax highlighting
    use "tpope/vim-bundler" -- Gemfile syntax highlighting

    use "junegunn/vim-easy-align" -- Align stuff
    use "vim-test/vim-test" -- Run tests
    use "jose-elias-alvarez/null-ls.nvim" -- native lsp integration for diagnostics feedback from linters and formatters

    use "nvim-telescope/telescope.nvim" -- Fuzzy list popups - branches, files, strings
    use "nvim-telescope/telescope-github.nvim" -- Telescope integration for the github cli
    use "nvim-telescope/telescope-fzy-native.nvim" -- Compiled and significantly faster fzf sorter for telescope
    use "nvim-telescope/telescope-live-grep-args.nvim" -- Filterable live grep
    use "nvim-lua/popup.nvim" -- Handy popup api written in lua
    use "nvim-lua/plenary.nvim" -- Brings in convenience functions for common lua behaviour
    use {
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      tag = "nightly"
    }

    use {
      "junnplus/lsp-setup.nvim",
      requires = {
        "neovim/nvim-lspconfig",
        "williamboman/nvim-lsp-installer",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "b0o/SchemaStore.nvim",
        "folke/neodev.nvim"
      }
    }

    use "RRethy/nvim-treesitter-textsubjects" -- textobj expansion using treesitter symbols
    use "kana/vim-textobj-user" -- Api for textobj creation - required for all textobj plugins
    use "kana/vim-textobj-line" -- Line textobj al/il
    use "whatyouhide/vim-textobj-xmlattr" -- Xml Attribute textobj ax/ix
    use "vimtaku/vim-textobj-keyvalue" -- Key value textobj - ak/ik av/iv
    use "idbrii/textobj-word-column.vim" -- Word column textobj - ac/ic
    use "b4winckler/vim-angry" -- Argument textobj - aa/ia
    use "michaeljsmith/vim-indent-object" -- Indent textobj ii/ai
    use "nelstrom/vim-textobj-rubyblock" -- Convenience textobj for ruby blocks ar/ir

    use "christoomey/vim-sort-motion" -- Sort motion
    use "tpope/vim-commentary" -- Comment motion
    use { "AckslD/nvim-revJ.lua", requires = { "sgur/vim-textobj-parameter" } } -- Reverse join
    use "RRethy/nvim-treesitter-endwise" -- Endwise for treesitter
    use "andymass/vim-matchup" -- Matchup for treesitter
    use({ "kylechui/nvim-surround", tag = "*" }) -- Modern implementation of vim-surround

    use "tpope/vim-dispatch" -- Asynchronous arbitrary shell execution
    use "tpope/vim-fugitive" -- Git integrations
    use "tpope/vim-rhubarb" -- Open browser with git object under cursor - context aware

    use "stefandtw/quickfix-reflector.vim" -- Makes quickfix writeable - for example for a dynamic find and replace
    use "tpope/vim-unimpaired" -- Navigate quickfix with ]q (next) [q (previous) entry shortcut


    use "kevinhwang91/nvim-bqf" -- Enhanced quickfix - especially filtering

    -- Experimental
    use "christoomey/vim-tmux-navigator"
    use({ "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" } })
    use(
      {
        "folke/noice.nvim",
        requires = {
          "MunifTanjim/nui.nvim",
          "rcarriga/nvim-notify"
        }
      }
    )
  end
)
