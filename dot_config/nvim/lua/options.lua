-------------------------------------------------------------------------------------
-- vim.cmd("language en_US")  -- vim.opt.language = "en_US"              -- Set the language option
vim.opt.compatible = false -- Disable compatibility mode. You want Vim, not vi. We set it explicitely to make our position clear!
vim.cmd [[filetype plugin indent on]]   -- Load plugins according to detected filetype.

vim.opt.wrap = false                                -- Disable line wrap
vim.opt.linebreak = true
vim.opt.clipboard = "unnamedplus"                   -- Sync with system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- https://neovim.io/doc/user/options.html#'completeopt'
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "folds" }

-- vim.opt.formatoptions = "qrn1"
-- vim.opt.formatoptions = "jcroqlnt" -- default: tcqj
-- vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.hlsearch = true        -- Enable highlighting of search matches -- vim.cmd [[set hlsearch]]  -- Keep matches highlighted.
vim.opt.incsearch = true       -- Enable incremental search vim.cmd [[set incsearch]] -- Highlight while searching with / or ?.
vim.opt.wrapscan = true        -- Enable wrapping of searches to the beginning/end of the file -- vim.cmd [[set wrapscan]]
vim.opt.termguicolors = true   -- True color support

vim.opt.report = 0             --  vim.cmd [[set report     =0]]        -- Always report changed lines.
vim.opt.syntax = "on"          -- Enable syntax highlighting  --  vim.cmd [[syntax on]]
-- vim.opt.synmaxcol = 200     -- Set the maximum column for syntax highlighting (default=3000) -- vim.cmd [[set synmaxcol  =200]] -- Only highlight the first 200 columns.

vim.opt.backup = false         -- Disable backup files -- vim.cmd [[set nobackup]]
vim.opt.writebackup = false    -- Disable write backup files -- vim.cmd [[set nowritebackup]]
vim.opt.swapfile = false       -- Disable swap file -- vim.cmd [[set noswapfile]]
-- vim.opt.undofile = true
-- vim.opt.undolevels = 1000   -- default 1000.
-- vim.opt.updatetime = 5000   -- Save swap file and trigger CursorHold
vim.opt.hidden = true
-- vim.opt.autowrite = true    -- Enable auto write?
vim.opt.autowriteall = true    -- save all buffers when closing vim and hopping between windows.

-- vim.opt.conceallevel = 3    -- Hide * markup for bold and italic?
vim.opt.confirm = true         -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true      -- Enable highlighting of the current line
vim.opt.ignorecase = true      -- Ignore case
vim.opt.inccommand = "split"   -- preview incremental substitute

-- vim.opt.laststatus = 0
vim.opt.mouse = "a"            -- Enable mouse mode
vim.opt.number = true          -- Print line number
vim.opt.numberwidth = 5
vim.opt.relativenumber = true  -- Relative line numbers
-- vim.opt.pumblend = 10       -- Popup blend
vim.opt.pumheight = 16         -- Maximum number of entries in a popup
vim.opt.scrolloff = 4          -- Lines of context
vim.opt.sidescrolloff = 8      -- Columns of context
-- vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.showcmd = true         -- Show command in the command-line  -- vim.cmd [[set showcmd]]  -- Show already typed keys when more are expected.
vim.opt.showmode = true        -- Show current mode in command-line.
vim.opt.signcolumn = "yes:2"   -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true       -- Don't ignore case with capitals
vim.opt.autoindent = true      -- Enable auto-indentation -- vim.cmd [[set autoindent]]     -- Indent according to previous line.
vim.opt.breakindent = true     -- Enable break indent
vim.opt.smartindent = true     -- Insert indents automatically
-- vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true      -- Open new windows below the current window.
vim.opt.splitright = true      -- Open new windows right of current

vim.opt.shiftround = true      -- Round indent -- >> indents to next multiple of 'shiftwidth'.
vim.opt.tabstop = 4            -- Number of spaces tabs count for
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.shiftwidth = 4         -- Size of an indent by spaces
vim.opt.softtabstop = 4        -- Set the value of softtabstop -- vim.cmd [[set softtabstop =4]] -- Tab key indents by 4 spaces.

vim.opt.timeout = true
vim.opt.timeoutlen = 2500
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 8                -- Minimum window width
-- vim.opt.splitkeep = "screen"

-- unsichtbare zeichen?
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴" -- ¬
-- vim.opt.listchars = "eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,"
-- vim.opt.list = true --  See :help 'list' and :help 'listchars'
vim.opt.listchars = "space:⋅,eol:↴,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂"

-- Put all temporary files under the same directory.
-- vim.cmd[[set undodir     =$HOME/.vim/files/undo/]]
-- vim.cmd[[set directory   =$HOME/.vim/files/swap//]]
-- vim.cmd[[set viewdir     =$HOME/.vim/files/view/]]
-- vim.cmd[[set backupdir   =$HOME/.vim/files/backup/]]
-- vim.cmd[[set updatecount =100]]
-- vim.cmd[[set viminfo     ='100,n$HOME/.vim/files/info/viminfo]]
