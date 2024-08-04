return {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- "linrongbin16/lsp-progress.nvim",
  },
  opts = {
    options = {
      icons_enabled = false,
      section_separators = " ",
      component_separators = "|",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename","filesize" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" }
    },
  },
  --    config = function ()
  --      -- require("lualine").setup({})
  --      -- refresh lualine
  -- vim.cmd([[
  -- augroup lualine_augroup
  --     autocmd!
  --     autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
  -- augroup END
  -- ]])
  --      end,
}
