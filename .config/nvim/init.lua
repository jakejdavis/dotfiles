vim.g.python3_host_prog = "/Users/jakedavis/.virtualenvs/py3nvim/bin/python"

vim.opt.encoding = "utf-8"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.laststatus = 2
vim.opt.termguicolors = true

-- performance
vim.opt.timeout = false
vim.opt.timeoutlen = 1000
vim.opt.foldlevel = 0
vim.opt.foldmethod = "manual"

vim.opt.backspace = "indent,eol,start"
vim.opt.mouse = ""

vim.opt.ttyfast = true
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt_global.shortmess:remove("F")
vim.g.mapleader = ";"
vim.g.tex_flavor = "latex"

-- disable builtin vim plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_spec = 0

require("plugins")

require("mapx").setup({ global = true })

require("nvim-tree").setup({})

local notify = require("notify")
-- notify.setup({
--     background_colour = "#1e222a",
-- })
vim.notify = notify

nnoremap("H", "^")
nnoremap("L", "^")

-- map buffer next
nnoremap("<leader>gn", ":bn<CR>")
nnoremap("<leader>gp", ":bp<CR>")
nnoremap("<leader>gd", ":bd<CR>")

noremap("<Esc>", "<C-\\><C-n>")

--require("leap").set_default_keymaps()

-- move.nvim
require('move').setup({})
nnoremap("<A-j>", ":MoveLine(1)<CR>", { silent = true })
nnoremap("<A-k>", ":MoveLine(-1)<CR>", { silent = true })
vnoremap("<A-j>", ":MoveBlock(1)<CR>", { silent = true })
vnoremap("<A-k>", ":MoveBlock(-1)<CR>", { silent = true })
nnoremap("<A-l>", ":MoveHChar(1)<CR>", { silent = true })
nnoremap("<A-h>", ":MoveHChar(-1)<CR>", { silent = true })
vnoremap("<A-l>", ":MoveHBlock(1)<CR>", { silent = true })
vnoremap("<A-h>", ":MoveHBlock(-1)<CR>", { silent = true })

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end)

vim.keymap.set("n", "<leader>hk", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hj", function() harpoon:list():next() end)

-- basic telescope configuration

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- Disable arrow keys
noremap("<Up>", "<Nop>")
noremap("<Down>", "<Nop>")
noremap("<Left>", "<Nop>")
noremap("<Right>", "<Nop>")

require("neoscroll").setup({
    easing_function = "quadratic",
})

require("impatient")

require("masonlsp_config")
require("cmp_config")
require("treesitter_config")
require("dap_config")
require("telescope_config")

require("snippets")


require('vscode').setup({
    transparent = false,
    italic_comments = true,
})

require('boole').setup({
    mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
    }
})
require('Comment').setup()

vim.cmd([[
    set background=dark
    colorscheme vscode
]])

require("lualine").setup({
    options = {
        theme = "vscode",
    },
})
