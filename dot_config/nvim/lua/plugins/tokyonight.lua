return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup {
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments  = { italic = false },
        keywords  = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        floats    = "dark", -- style for floating windows
        sidebars  = "dark", -- style for sidebars, see below
      },
      on_colors = function(colors)
        -- colors.warning = "#004d99"
        -- colors.warning = "#003366"
        colors.bg_visual = colors.blue0
      end,
    }
    vim.cmd.colorscheme "tokyonight-night"
  end,
}

