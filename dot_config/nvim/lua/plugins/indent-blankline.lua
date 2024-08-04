if true then return {} end

-- https://github.com/lukas-reineke/indent-blankline.nvim
--
-- replace with? https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
--
return  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    main="ibl",
    opts = {
      -- char = "┊",
      -- show_end_of_line = true,
      -- show_trailing_blankline_indent = false,
      -- show_current_context = true,
      -- show_current_context_start = false,
    },
  }
