-- Set <space> as the leader key. See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader          = " "
vim.g.maplocalleader     = " "

-- disable some plugins and providers we dont need.
vim.g.loaded_netrw         = 1
vim.g.loaded_netrwPlugin   = 1
vim.g.loaded_perl_provider = 0

-- netrw settings like NERDtree
vim.g.netrw_banner       = 1
vim.g.netrw_liststyle    = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv         = 1
vim.g.netrw_winsize      = 25

-- install python and run:  python3.exe -m pip install --user --upgrade pynvim
--vim.g.python3_host_prog  = vim.env.SCOOP .. "/apps/python/current/python.exe"
local lazypath           = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    -- version = false, -- always use the latest git commit
    version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "tokyonight-night" },
  },
  checker = { enabled = false }, -- automatically check for plugin updates
  change_detection = {
        enabled = false, -- automatically check for config file changes and reload the ui
        notify = true, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- [[ Highlight on yank ]] -- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
--  pattern = "*",
--  desc = 'Highlight when yanking (copying) text',
--  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
})

require("options")
require("keymaps")
