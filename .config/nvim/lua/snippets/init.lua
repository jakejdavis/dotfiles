local ls = require('luasnip')

local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local snippet = ls.s

ls.add_snippets('all', {
    snippet('date', {
        f(function()
            return string.format(string.gsub(vim.bo.commentstring, '%%s', ' %%s'), os.date())
        end, {}),
    }),
    snippet('todo', {
        c(1, {
            t('TODO: (jakejdavis) - '),
            t('NOTE: (jakejdavis) - '),
            t('FIX: (jakejdavis) - '),
            t('WARNING: (jakejdavis) - '),
            t('HACK: (jakejdavis) - '),
            t('PERF: (jakejdavis) - '),
        })
    })
})

require "snippets.tex"
require "snippets.tex_math"
require "snippets.javascript"
