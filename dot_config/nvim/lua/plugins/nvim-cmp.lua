-- https://github.com/hrsh7th/nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  -- opt = {}, -- same as require("blabla").setup({}) ?
  dependencies = {
    -- Autocompletion
    "hrsh7th/cmp-nvim-lsp", -- Required
    "L3MON4D3/LuaSnip",     -- Required
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    local cmp = require("cmp")
    cmp.setup({
      --
      -- preselect = "item", completion = { completeopt = "menu,menuone,noinsert" },
      --
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer",   keyword_length = 2 },
        { name = "luasnip" }, { name = "nvim_lsp_signature_help" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
          select = false, -- Set `select` to `false` to only confirm explicitly selected items.
          behavior = cmp.ConfirmBehavior.Replace,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })
  end,
}
