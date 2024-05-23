local dap = require("dap")
local dapui = require("dapui")

-- dap.adapters.delve = {
--     type = 'server',
--     port = '${port}',
--     executable = {
--         command = 'dlv',
--         args = { 'dap', '-l', '127.0.0.1:${port}' },
--     }
-- }
--
-- -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.go = {
--     {
--         type = "delve",
--         name = "Debug",
--         request = "launch",
--         program = "${file}"
--     },
--     {
--         type = "delve",
--         name = "Debug test", -- configuration for debugging test files
--         request = "launch",
--         mode = "test",
--         program = "${file}"
--     },
--     -- works with go.mod packages and sub packages
--     {
--         type = "delve",
--         name = "Debug test (go.mod)",
--         request = "launch",
--         mode = "test",
--         program = "./${relativeFileDirname}"
--     }
-- }

dapui.setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.40
                },
                {
                    id = "repl",
                    size = 0.30
                },
                {
                    id = "watches",
                    size = 0.30
                }

            },
            position = "top",
            size = 12
        },
        {
            elements = {
                {
                    id = "stacks",
                    size = 0.40
                },
                {
                    id = "breakpoints",
                    size = 0.30
                },
                {
                    id = "console",
                    size = 0.30
                },
            },
            position = "top",
            size = 8
        },
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
