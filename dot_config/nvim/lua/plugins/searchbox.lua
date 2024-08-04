if true then return {} end

--
-- :SearchBoxMatchAll mode=fuzzy clear_matches=false
--
return {
    "VonHeikemen/searchbox.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        -- require("searchbox").setup()
    end
}

