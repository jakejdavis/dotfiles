local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.opt.completeopt = "menu,menuone,noinsert,noselect"
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    --style = {
    --  winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    --},
    --window = {
    --  completion = {
    --    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    --    scrollbar = "║",
    --    winhighlight = 'Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None',
    --    autocomplete = {
    --      require("cmp.types").cmp.TriggerEvent.InsertEnter,
    --      require("cmp.types").cmp.TriggerEvent.TextChanged,
    --    },
    --  },
    --  documentation = {
    --    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    --    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    --    scrollbar = "║",
    --  },
    --},
    --window = {
    --    completion = cmp.config.window.bordered(),
    --    documentation = cmp.config.window.bordered(),
    --},
    mapping = {
        ["<PageUp>"] = function()
            for _ = 1, 10 do
                cmp.mapping.select_prev_item()(nil)
            end
        end,
        ["<PageDown>"] = function()
            for _ = 1, 10 do
                cmp.mapping.select_next_item()(nil)
            end
        end,
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-s>"] = cmp.mapping.complete({
            config = {
                sources = {
                    { name = "copilot" },
                },
            },
        }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    experimental = {
        ghost_text = true,
    },
    view = {
        entries = {
            native = true,
        },
    },
    sources = {
        { name = "luasnip",  group_index = 2 },
        { name = "copilot",  group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "path",     group_index = 2 },
        { name = "buffer",   group_index = 5 },
        { name = "nvim_lua", group_index = 2 },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        })
    },
    sorting = {
        comparators = {
            cmp.config.compare.recently_used,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    preselect = cmp.PreselectMode.None,
})

vim.keymap.set({ "i", "s" }, "<leader>sn", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)
vim.keymap.set({ "i", "s" }, "<leader>sp", function()
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    end
end)

--set max height of items
vim.cmd([[ set pumheight=6 ]])
--set highlights
--local highlights = {
-- type highlights
--    CmpItemKindText = { fg = "LightGrey" },
--    CmpItemKindFunction = { fg = "#C586C0" },
--    CmpItemKindClass = { fg = "Orange" },
--    CmpItemKindKeyword = { fg = "#f90c71" },
--    CmpItemKindSnippet = { fg = "#565c64" },
--    CmpItemKindConstructor = { fg = "#ae43f0" },
--    CmpItemKindVariable = { fg = "#9CDCFE", bg = "NONE" },
--   CmpItemKindInterface = { fg = "#f90c71", bg = "NONE" },
--    CmpItemKindFolder = { fg = "#2986cc" },
--    CmpItemKindReference = { fg = "#922b21" },
--    CmpItemKindMethod = { fg = "#C586C0" },
--    CmpItemMenu = { fg = "#C586C0", bg = "#C586C0" },
--    CmpItemAbbr = { fg = "#565c64", bg = "NONE" },
--    CmpItemAbbrMatch = { fg = "#569CD6", bg = "NONE" },
--    CmpItemAbbrMatchFuzzy = { fg = "#569CD6", bg = "NONE" },
--    CmpMenuBorder = { fg = "#263341" },
--    CmpMenu = { bg = "#10171f" },
--    CmpSelection = { bg = "#263341" },
--}
-- vim.api.nvim_set_hl(0, "CmpBorderedWindow_FloatBorder", { fg = "#565c64" })
--for group, hl in pairs(highlights) do
--   vim.api.nvim_set_hl(0, group, hl)
--end
