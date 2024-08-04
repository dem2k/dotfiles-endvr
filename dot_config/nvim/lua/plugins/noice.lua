if true then return {} end

-- https://github.com/folke/noice.nvim
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            cmdline = {
                enabled = true,
                view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                opts = {
                    position = {
                        row = '15%',
                        col = '50%',
                    },
                    size = {
                        width = '75%',
                    },
                },

                format = {
                    cmdline = { pattern = "^:", icon = "", lang = "vim" },
                },


            },
            messages = {
                -- NOTE: If you enable messages, then the cmdline is enabled automatically.
                -- This is a current Neovim limitation.
                enabled = true,            -- enables the Noice messages UI
                view = "notify",           -- default view for messages
                view_error = "notify",     -- view for errors
                view_warn = "notify",      -- view for warnings
                view_history = "messages", -- view for :messages
                view_search = "mini",      -- false, -- "virtualtext", -- view for search count messages. Set to `false` to disable
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                -- override = {
                -- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- ["vim.lsp.util.stylize_markdown"] = true,
                -- ["cmp.entry.get_documentation"] = true,
                -- },
                progress = {
                    enabled = false,
                    -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                    -- See the section on formatting for more details on how to customize.
                    --- @type NoiceFormat|string
                    format = "lsp_progress",
                    --- @type NoiceFormat|string
                    format_done = "lsp_progress_done",
                    throttle = 1000 / 30, -- frequency to update lsp progress message
                    view = "mini",
                },
            },
        })
    end
}
