if true then return {} end

-- https://github.com/VonHeikemen/fine-cmdline.nvim
return {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        local fineline = require('fine-cmdline')
        fineline.setup({
            cmdline = {
                prompt = ': ',
                smart_history = true,
                enable_keymaps = true,
            },
            popup = {
                position = {
                    row = '85%',
                    col = '50%',
                },
                size = {
                    width = '75%',
                },
                border = {
                    style = 'rounded',
                    text = {
                        top = ' Command ',
                        top_align = 'left',
                    },
                },
                win_options = {
                    -- winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
                },
            },
            hooks = {
                before_mount = function(input)
                    -- code
                end,
                after_mount = function(input)
                    -- make escape go to normal mode
                    -- vim.keymap.set('i', '<Esc>', '<cmd>stopinsert<cr>', { buffer = input.bufnr })
                end,
                set_keymaps = function(imap, feedkeys)
                    -- imap('<Esc>', fineline.fn.close)
                    -- imap('<Up>', fineline.fn.up_search_history)
                    -- imap('<Down>', fineline.fn.down_search_history)
                end
            }
        })
        vim.api.nvim_set_keymap('n', ':', ':FineCmdline<cr>', { noremap = true })
    end
}
