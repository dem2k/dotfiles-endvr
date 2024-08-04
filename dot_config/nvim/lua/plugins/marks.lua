-- if true then return {} end

-- https://github.com/chentoast/marks.nvim
return {
    "chentoast/marks.nvim",
    config = function()
        require("marks").setup({
            -- which builtin marks to show. default {}
            builtin_marks = { ".", "<", ">", "^" },
        })
    end
}
