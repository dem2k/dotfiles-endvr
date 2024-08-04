if true then return {} end

-- actually using mini.comment, not this plugin
-- https://github.com/numToStr/Comment.nvim
return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end
}

