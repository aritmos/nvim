local dapui = require("dapui")

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
