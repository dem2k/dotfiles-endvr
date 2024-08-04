-- scroll window
vim.keymap.set("n", "<C-Up>", "<C-Y>", { desc = "Scroll Window up" })
vim.keymap.set("n", "<C-Down>", "<C-E>", { desc = "Scroll Window down" })

-- -- Move Lines (use mini.move.  https://github.com/echasnovski/mini.nvim/)
-- vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
-- vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
-- vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
-- vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
-- vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })

-- ctrl-s to save file
vim.keymap.set("n", "<c-s>", "<cmd>w<cr>", { desc = "Save Buffer" })
vim.keymap.set("i", "<c-s>", "<esc><cmd>w<cr>a", { desc = "Save Buffer" })

-- vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>e",  ":NeoTreeFloatToggle<cr>", { desc = "Open File Explorer" })
vim.keymap.set("n", "<leader>öw", ":set invwrap<cr>", { desc = "Toggle wrap Lines" })
-- vim.keymap.set("n", "<leader>öy", ':let @+ = @"<cr>', { desc = "Put yanked Text into System Clipboard" })
-- vim.keymap.set("n", "<leader>öc", ':let @" = @+<cr>', { desc = "Put System Clipboard into unnamed Register" })
vim.keymap.set("n", "<leader>öö", ':let @a=@+ | let @+=@" | let @"=@a<cr>', { desc = "Swap System Clipboard and Yank Register" })
vim.keymap.set("n", "<leader>öf", ":%!c:/scoop/apps/tidy/current/tidy.exe -xml -raw -indent -quiet -wrap 0<cr>", { desc = "Tidy XML" })
vim.keymap.set("n", "<leader>öv", 'vi""*p', { desc = "Put System Clipboard inside Quotes" })

vim.keymap.set("n", "<leader>su", ":set fileencoding=UTF-8 | write<cr>", { desc = "Save Buffer as UTF-8" })
vim.keymap.set("n", "<leader>sl", ":set fileencoding=ISO-8859-15 | write<cr>", { desc = "Save Buffer as ISO-8859-15" })
vim.keymap.set("n", "<leader>sd", ":set ff=dos | write<cr>", { desc = "Change Line Endings to DOS" })
vim.keymap.set("n", "<leader>sx", ":set ff=unix | write<cr>", { desc = "Change Line Endings to UNIX" })

-- show unsichtbare zeichen?
vim.keymap.set("n", "<leader>öp", ":set invlist<cr>", { desc = "Toggle show/hide all Characters" })

-- x löscht nicht ins clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "x does not change Clipboard" })

-- prev/next tab
vim.keymap.set("n", "<Tab>", ":bnext<cr>",{desc="Next Tab"})
vim.keymap.set("n", "<S-Tab>", ":bprev<cr>",{desc="Previous Tab"})
vim.keymap.set("n", "<leader>bn", ":bnext<cr>",{desc="Next Tab"})
vim.keymap.set("n", "<leader>bp", ":bprev<cr>",{desc="Previous Tab"})
vim.keymap.set("n", "<leader>bb", ":b#<cr>",{desc="Last opened Buffer"})
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>",{desc="Delete current Buffer"})

-- vim.keymap.set("n", "<c-v>", "P")

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.opt.guifont = "Hack NF:h12"
    vim.keymap.set({ "i", "c" }, "<c-v>", "<c-r>+", { desc = "CTRL-V isn't map in Neovide" })
    vim.keymap.set("n", "<c-v>", "i<c-r>+<esc>l", { desc = "CTRL-V isn't map in Neovide" })
end

-- move in long lines
vim.keymap.set("n", "<Up>", "gk", { desc = "Move Cursor up in a long Line" })
vim.keymap.set("n", "<Down>", "gj", { desc = "Move Cursor down in a long Line" })

-- vv aktiviert Lineweise selektieren
vim.keymap.set("n", "vv", "V")

-- i mostly use this with iw...
vim.keymap.set("n", "cw", "ciw")
-- vim.keymap.set("n", "cq", "ciq")
-- vim.keymap.set("n", "cb", "cib")
vim.keymap.set("n", "dw", "diw")
-- vim.keymap.set("n", "dq", "diq")
-- vim.keymap.set("n", "db", "dib")
vim.keymap.set("n", "vw", "viw")
-- vim.keymap.set("n", "vq", "viq")
-- vim.keymap.set("n", "vb", "vib")
vim.keymap.set("n", "yw", "yiw")
-- vim.keymap.set("n", "yq", "yiq")
-- vim.keymap.set("n", "yb", "yib")

-- 
vim.keymap.set("n", "<leader>n", ":%s///gn<cr>",{desc="Count search Matches"})

