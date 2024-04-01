local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt

local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local snippet = ls.s

local typescript_snippets = {
    snippet('iar', t("import * as React from 'react'")),
    snippet('log', fmt('console.log({})', { i(1) })),
    snippet('logging', fmt("console.log('logging {}: ', {})", {
        f(function(import_name)
            local parts = vim.split(import_name[1][1], '.', { plain = true })
            return parts[#parts] or ''
        end, { 1 }),
        i(1)
    })),
    snippet('rsc', { c(1, { t("'use server'"), t("'use client'") }) }),
    snippet('func', {
        c(1, {
            fmt([[function {}({}) {{
  {}
}}]], { i(1), i(2), i(3) }),
            fmt([[async function {}({}) {{
  {}
}}]], { i(1), i(2), i(3) }),
        })
    }),
}

local react_snippets = {
    snippet('rc', {
        c(1, {
            fmt([[import * as React from 'react'

export function {}() {{
  return <div />{}
}}]], { i(1), i(2) }),
            fmt([[import * as React from 'react'

type Props = {{
  {}
}}

export function {}({{{}}}: Props) {{
  return <div />{}
}}]], { i(1), i(2), i(3), i(4) }),
        })
    }),
    snippet('izod', t("import {z} from 'zod'")),
    snippet('ust', fmt('const [{}] = React.useState{}({})', { i(1), i(2), i(3) })),
    snippet('uef', fmt([[React.useEffect(() => {{
  {}
}}, [])]], { i(1) })),
}

local merged_snippets = {}
for _, v in ipairs(typescript_snippets) do
    table.insert(merged_snippets, v)
end

for _, v in ipairs(react_snippets) do
    table.insert(merged_snippets, v)
end

ls.add_snippets('typescript', typescript_snippets)
ls.add_snippets('javascript', typescript_snippets)
ls.add_snippets('typescriptreact', merged_snippets)
ls.add_snippets('javascriptreact', merged_snippets)
