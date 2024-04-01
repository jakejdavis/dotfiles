require("dapui").setup()
require("mason-nvim-dap").setup({
    automatic_setup = true,
})
require 'mason-nvim-dap'.setup {}

--require("dap-python").setup(vim.fn.environ()['CONDA_PREFIX'] .. "/bin/python")

local dap = require("dap")
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/local/Cellar/llvm/13.0.0/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}
dap.adapters.codelldb = function(on_adapter)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)

    local cmd = "/Users/jakedavis/Other/codelldb/adapter/codelldb"

    local handle, pid_or_err
    local opts = {
        stdio = { nil, stdout, stderr },
        detached = true,
    }
    handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
        stdout:close()
        stderr:close()
        handle:close()
        if code ~= 0 then
            print("codelldb exited with code", code)
        end
    end)
    assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            local port = chunk:match("Listening on port (%d+)")
            if port then
                vim.schedule(function()
                    on_adapter({
                        type = "server",
                        host = "127.0.0.1",
                        port = port,
                    })
                end)
            else
                vim.schedule(function()
                    require("dap.repl").append(chunk)
                end)
            end
        end
    end)
    stderr:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require("dap.repl").append(chunk)
            end)
        end
    end)
end

local program = ""

local set_program = function()
    program = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "lldb",
        request = "launch",
        program = function()
            if program == "" then
                set_program()
            end
            return program
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

nnoremap("<F5>", ":lua require'dap'.continue()<CR>", { silent = true })
nnoremap("<F10>", ":lua require'dap'.step_over()<CR>", { silent = true })
nnoremap("<F11>", ":lua require'dap'.step_into()<CR>", { silent = true })
nnoremap("<F12>", ":lua require'dap'.step_out()<CR>", { silent = true })
nnoremap("<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
nnoremap("<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
nnoremap(
    "<leader>lp",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { silent = true }
)
nnoremap("<leader>dr", ":lua require'dap'.repl.open()<CR>", { silent = true })
nnoremap("<leader>dl", ":lua require'dap'.run_last()<CR>", { silent = true })

nnoremap("<leader>dn", ":lua require('dap-python').test_method()<CR>", { silent = true })
nnoremap("<leader>df", ":lua require('dap-python').test_class()<CR>", { silent = true })
vnoremap("<leader>ds", ":lua require('dap-python').debug_selection()<CR>", { silent = true })

nnoremap("<leader>dd", ":lua require'dap'.disconnect({ terminateDebugee = true })<CR>", { silent = true })
nnoremap("<leader>dc", ":lua require'dap'.close()<CR>", { silent = true })
nnoremap("<leader>dp", ":lua set_program()<CR>", { silent = true })

nnoremap("<leader>du", ":lua require('dapui').toggle()<CR>", { silent = true })
