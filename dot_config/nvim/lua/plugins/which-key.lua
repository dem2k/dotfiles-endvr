return {
    "folke/which-key.nvim",
    dependencies = {
        "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local wk = require("which-key")
        -- wk.setup({})
        wk.add({
            { "<leader>ö", group = "My custom Commands..." },
            -- ["<leader>ös"] = { name = "Save Buffer..." },
            { "<leader>f", group = "Telescope..." },
            { "<leader>s", group = "Save Buffer..." },
            { "<leader>b", group = "Buffer..." },
            { "<leader>g", group = "Git..." },
            { "<leader>l", group = "Language server..." },
            { "<leader>t", group = "Terminal..." },
        })
    end,
}

