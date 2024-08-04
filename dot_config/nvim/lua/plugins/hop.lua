-- if true then return {} end

-- using mini.jump2d ?
-- https://github.com/smoka7/hop.nvim
return {
  'smoka7/hop.nvim',
    version = "*",
    config = function()
        require("hop").setup()
        -- vim.keymap.set("n", "<cr>", ":HopWord<cr>")
        vim.keymap.set("n", "<leader>w", ":HopWord<cr>")
    end
}

