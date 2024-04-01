local telescope = require("telescope")

vim.api.nvim_set_keymap(
    "n",
    "<leader>fr",
    "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
    { noremap = true }
)
telescope.setup({
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    defaults = {
        file_ignore_patterns = {
            "node_modules/",
            ".bundle/",
            ".expo/",
        }
    },
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")
telescope.load_extension('luasnip')

nnoremap("<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", { silent = true })
nnoremap("<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", { silent = true })
nnoremap("<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", { silent = true })
nnoremap("<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", { silent = true })
nnoremap("<leader>ft", ":lua require('telescope.builtin').dash_search()<CR>", { silent = true })
nnoremap("<leader>fc", ":lua require('telescope.builtin').treesitter()<CR>", { silent = true })
nnoremap("<leader>fl", ":Telescope luasnip<CR>", { silent = true })
nnoremap("<leader>fs", ":lua require('telescope.builtin').lsp_document_symbols()<CR>", { silent = true })
nnoremap("<leader>fw", ":lua require('telescope.builtin').lsp_workspace_symbols()<CR>", { silent = true })
nnoremap("<leader>fr", ":lua require('telescope.builtin').registers()<CR>", { silent = true })
nnoremap("<leader>f<space>", ":lua require('telescope.builtin').resume()<CR>", { silent = true })


local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>fm", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
