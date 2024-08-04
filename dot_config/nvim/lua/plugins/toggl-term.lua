return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
    },
    config = function()
        require("toggleterm").setup({})
        local Terminal = require("toggleterm.terminal").Terminal

        local pwsh     = Terminal:new({
            cmd = "pwsh",
            direction = "tab",
            float_opts = {
                -- border = "single",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        local lazygit  = Terminal:new({
            cmd = "lazygit",
            -- hidden = true,
            -- dir = "git_dir",
            direction = "float",
            float_opts = {
                -- border = "single",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd(":wall")
                vim.cmd("startinsert!")
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        local pwshrun  = Terminal:new({
            -- cmd = "pwsh.exe -command 'pwd ; pause ; & " .. vim.fn.expand('%:p') .. "'",
            cmd = "pwsh -command 'pwd;pause;" .. vim.fn.expand('%:p') .. "'",
            -- hidden = true,
            -- dir = "git_dir",
            -- direction = "tab",
            float_opts = {
                -- border = "single",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                -- vim.cmd("startinsert!")
                -- vim.cmd("w")
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                -- vim.cmd("startinsert!")
            end,
        })

        function _lazygit_term()
            lazygit:toggle()
        end

        function _pwsh_term()
            pwsh:toggle()
        end

        function _pwshrun_term()
            pwshrun:toggle()
        end

        vim.keymap.set("n", "<leader>ts", "<cmd>:TermSelect<cr>",
            { desc = "Select Terminal", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gg", "<cmd>:lua _lazygit_term()<cr>",
            { desc = "LazyGit", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>tt", "<cmd>:lua _pwsh_term()<cr>",
            { desc = "Toggle Pwsh Terminal", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>tr", "<cmd>:lua _pwshrun_term()<cr>",
            { desc = "Toggle Pwsh run current file", noremap = true, silent = true })
    end
}
