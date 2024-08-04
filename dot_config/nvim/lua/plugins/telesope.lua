-- if true then return {} end

-- https://github.com/nvim-telescope/telescope.nvim -- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                -- layout_strategy = "horizontal",
                layout_config = {
                    width = 0.95,
                    height = 0.85,
                    -- preview_cutoff = 120,  --default?
                    -- preview_width = 0.65,
                },
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    -- https://github.com/nvim-telescope/telescope-ui-select.nvim
                    require("telescope.themes").get_cursor {
                          layout_config = {
                            height=18,
                        },
                    },

                     -- require("telescope.themes").get_dropdown {
                     --    -- even more opts
                     --    },

                }
            }
        })

        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")

        -- See `:help telescope.builtin`
        vim.keymap.set("n", "<leader>?", function()
            require("telescope.builtin").current_buffer_fuzzy_find(
                require("telescope.themes").get_dropdown { previewer = false, }
            )
        end, { desc = "Fuzzy Find in current Buffer" })

        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fb", telescope_builtin.builtin, { desc = "Built-in Pickers" })
        vim.keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, { desc = "Recently opened Files" })
        vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Files" })
        vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<leader>fw", telescope_builtin.grep_string, { desc = "Current Word in Files" })
        vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "Diagnostics" })
        vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, { desc = "Find Git Files" })
        vim.keymap.set("n", "<leader>gc", telescope_builtin.git_commits, { desc = "Commits" })
        vim.keymap.set("n", "<leader>gb", telescope_builtin.git_branches, { desc = "Branches" })
        vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, { desc = "Status" })
        vim.keymap.set('n', '<leader>fk', telescope_builtin.keymaps, { desc = 'Search [K]eymaps' })
        vim.keymap.set('n', '<leader>fr', telescope_builtin.resume, { desc = 'Search [R]esume' })
        vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Existing Buffers" })
    end,
}
