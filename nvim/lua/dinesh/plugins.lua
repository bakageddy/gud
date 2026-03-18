---@diagnostic disable: unknown-cast-variable
vim.cmd [[ packadd packer.nvim ]]

-- TODO: Refactor to lazy.nvim
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Tmux
    use 'tmux-plugins/vim-tmux'
    use 'jedrzejboczar/possession.nvim'
	-- use 'vimpostor/vim-tpipeline'
	use 'jlfwong/vim-mercenary'

    -- Git
    use {
        'NeogitOrg/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim'
        }
    }

    use 'sindrets/diffview.nvim'

    use 'lewis6991/gitsigns.nvim'

    use 'folke/todo-comments.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
    }

    use {
        'nvim-telescope/telescope-file-browser.nvim',
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        requires = { 'nvim-telescope/telescope.nvim' },
    }


    -- Terminal
    use 'akinsho/toggleterm.nvim'
    use 'pocco81/true-zen.nvim'


    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter"
    }

    use {
        "windwp/nvim-autopairs",
        after = "nvim-treesitter",
    }

    use {
        "numToStr/Comment.nvim",
        after = "nvim-treesitter",
    }

    -- Neovim tree
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    })

    -- LSP Support
    use { 'neovim/nvim-lspconfig' }
    use { 'mason-org/mason.nvim' }
    use { 'mason-org/mason-lspconfig.nvim' }
    use { 'folke/lazydev.nvim' }

    -- Autocompletion
    use { 'saghen/blink.cmp' }

    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

	-- Debugger
    use {
        "mfussenegger/nvim-dap",
        requires = {
            { 'igorlfs/nvim-dap-view' },
            { 'nvim-neotest/nvim-nio' },
            { 'williamboman/mason.nvim' },
            { 'jay-babu/mason-nvim-dap.nvim' },
        }
    }

    use {
        "nvimtools/none-ls.nvim"
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter',
    }

    use {
        'nvim-treesitter/playground',
        after = 'nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter',
    }

    use "stevearc/conform.nvim"

    use {
        'nvimdev/indentmini.nvim',
    }

    use {
        "jay-babu/mason-null-ls.nvim",
        requires = {
            "mason-org/mason.nvim",
            "nvimtools/none-ls.nvim",
        }
    }

    -- Impatient
    use 'lewis6991/impatient.nvim'

    -- Status Line
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'

    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- Colorscheme
    use 'ellisonleao/gruvbox.nvim'
	use 'arcticicestudio/nord-vim'
    use 'miikanissi/modus-themes.nvim'
    use 'craftzdog/solarized-osaka.nvim'
    use 'webhooked/kanso.nvim'
end)
