return require("packer").startup(function(use)
    local function use_local(plugin)
        local home = os.getenv("HOME")
        use(string.format("%s/dev/plugins/%s", home, plugin))
    end

    use_local("postfix-completion.nvim")

    -- fast startups
    use("lewis6991/impatient.nvim")
    use("dstein64/vim-startuptime")

    use("wbthomason/packer.nvim")
    use("tjdevries/colorbuddy.vim")
    use("tjdevries/gruvbuddy.nvim")
    use("norcalli/nvim-colorizer.lua")
    use({
        "kyazdani42/nvim-web-devicons",
        module = "nvim-web-devicons",
    })
    use("kyazdani42/nvim-tree.lua")
    use("rcarriga/nvim-notify")
    use("nvim-lualine/lualine.nvim")

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("windwp/nvim-ts-autotag")
    use("nvim-treesitter/playground")

    use("windwp/nvim-autopairs")

    -- lsp
    use({
        "neovim/nvim-lspconfig",
        "williamboman/nvim-lsp-installer",
    })
    use("hrsh7th/nvim-cmp") -- Autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
    use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
    use("L3MON4D3/LuaSnip") -- Snippets plugin
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-ui-select.nvim" })
    -- use("nvim-telescope/telescope-fzy-native.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-telescope/telescope-project.nvim")
    use("nvim-telescope/telescope-node-modules.nvim")
    use("nvim-telescope/telescope-dap.nvim")
    use("dhruvmanila/telescope-bookmarks.nvim")
    use("xiyaowong/telescope-emoji.nvim")
    use({
        "nvim-telescope/telescope-github.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    })

    use("ThePrimeagen/harpoon")
    use("ThePrimeagen/refactoring.nvim")

    -- comments
    use("tjdevries/vim-inyoface")
    use("numToStr/Comment.nvim")

    -- Terminal
    use({ "akinsho/toggleterm.nvim" })

    -- Git
    use("tpope/vim-fugitive")

    -- Debugging
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")

    -- Testing
    use("vim-test/vim-test")
end)
