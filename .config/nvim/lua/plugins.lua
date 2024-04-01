local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        {
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
        },

        'Mofiqul/vscode.nvim',

        {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        },
        "nvim-treesitter/nvim-treesitter-textobjects",
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        {
            "hrsh7th/nvim-cmp",
            requires = { "onsails/lspkind-nvim" },
        },
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        {
            "smjonas/inc-rename.nvim",
            config = function()
                require("inc_rename").setup()
            end,
        },
        {
            "smjonas/snippet-converter.nvim",
            config = function()
                local template = {
                    sources = {
                        ultisnips = {
                            vim.fn.stdpath("config") .. "/snippets",
                        },
                    },
                    output = {
                        vscode_luasnip = {
                            vim.fn.stdpath("config") .. "/lua_snippets",
                        },
                    },
                }

                require("snippet_converter").setup {
                    templates = { template },
                }
            end
        },
        "jose-elias-alvarez/null-ls.nvim",
        {
            'numToStr/Comment.nvim',
            opts = {
            },
            lazy = false,
        },
        'lukas-reineke/lsp-format.nvim',
        'onsails/lspkind.nvim',
        "nathom/filetype.nvim",
        "lewis6991/impatient.nvim",
        {
            "zbirenbaum/copilot.lua",
            event = { "VimEnter" },
            config = function()
                vim.defer_fn(function()
                    require("copilot").setup()
                end, 100)
            end,
        },
        {
            "zbirenbaum/copilot-cmp",
            after = { "copilot.lua" },
            config = function()
                require("copilot_cmp").setup()
            end
        },
        "lewis6991/gitsigns.nvim",
        "qpkorr/vim-bufkill",
        "karb94/neoscroll.nvim",

        "nat-418/boole.nvim",
        {
            "hedyhli/outline.nvim",
            config = function()
                vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                    { desc = "Toggle Outline" })

                require("outline").setup {}
            end,
        },
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",

        "nvim-lua/plenary.nvim",
        "rcarriga/nvim-notify",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "benfowler/telescope-luasnip.nvim",

        "kassio/neoterm",
        "romgrk/barbar.nvim",
        "fedepujol/move.nvim",

        "terryma/vim-expand-region",
        {
            "folke/flash.nvim",
            event = "VeryLazy",
            ---@type Flash.Config
            opts = {},
            -- stylua: ignore
            keys = {
                { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
                {
                    "S",
                    mode = { "n", "o", "x" },
                    function() require("flash").treesitter() end,
                    desc =
                    "Flash Treesitter"
                },
                {
                    "r",
                    mode = "o",
                    function() require("flash").remote() end,
                    desc =
                    "Remote Flash"
                },
                {
                    "R",
                    mode = { "o", "x" },
                    function() require("flash").treesitter_search() end,
                    desc =
                    "Treesitter Search"
                },
                {
                    "<c-s>",
                    mode = { "c" },
                    function() require("flash").toggle() end,
                    desc =
                    "Toggle Flash Search"
                },
            },
        },
        "b0o/mapx.nvim",
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" }
        },

        {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            config = function()
                require("lsp_lines").setup()
                vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
            end,
        },
        "nvim-tree/nvim-tree.lua",
        "nvim-tree/nvim-web-devicons",

        {
            "tversteeg/registers.nvim",
            name = "registers",
            keys = {
                { "\"",    mode = { "n", "v" } },
                { "<C-R>", mode = "i" }
            },
            cmd = "Registers",
        },

        "tidalcycles/vim-tidal",
    },
    defaults = {
        lazy = false,
        version = false,
    },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
