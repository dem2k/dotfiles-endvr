-- if true then return {} end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim",           opts = {} },
        { "williamboman/mason-lspconfig.nvim", opts = {} },
        { "j-hui/fidget.nvim",                 opts = {} }, -- Useful status updates for LSP
        { "folke/neodev.nvim",                 opts = {} }, -- Additional lua configuration, makes nvim stuff amazing!
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        local lspconfig = require("lspconfig")
        local lspdefault = lspconfig.util.default_config

        lspdefault.capabilities = vim.tbl_deep_extend(
            "force", lspdefault.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            -- group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            desc = "LSP Actions",
            callback = function(event)
                -- vim.lsp.set_log_level("debug")
                local keymap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                keymap("gD", ":lua vim.lsp.buf.declaration()<cr>", "Goto Declaration")
                keymap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")              -- keymap("gd", ":lua vim.lsp.buf.definition()<cr>", "Goto Definition")
                keymap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")      -- keymap("gI", ":lua vim.lsp.buf.implementation()<cr>", "Goto Implementation")
                keymap("gr", require("telescope.builtin").lsp_references, "Goto References")               -- keymap("gr", ":lua vim.lsp.buf.references()<cr>", "Goto References")
                keymap("<leader>lo", require("telescope.builtin").lsp_type_definitions, "Type Definition") -- keymap("go", ":lua vim.lsp.buf.type_definition()<cr>", "Type Definition")
                keymap("<leader>ls", ":lua vim.lsp.buf.signature_help()<cr>", "Signature Help")
                keymap("<leader>lr", ":lua vim.lsp.buf.rename()<cr>", "Rename")
                keymap("<leader>lj", ":lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic Message")
                keymap("<leader>lk", ":lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic Message")
                keymap('<leader>le', ":lua vim.diagnostic.open_float()<cr>", "Show Diagnostic Error Message")
                keymap("<leader>lq", require("telescope.builtin").diagnostics, "All Diagnostic Messages") -- keymap('<leader>lq', ":lua vim.diagnostic.setloclist()<cr>", "Open Diagnostic Quickfix List" )
                keymap("<leader>lh", ":lua vim.lsp.buf.hover()<cr>", "Hover Documentation")
                keymap("<leader>lf", ":lua vim.lsp.buf.format({})<cr>", "Format current Buffer")
                keymap("<leader>ld", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
                keymap("<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
                vim.keymap.set({ "n", "v" }, "<leader>ll", ":lua vim.lsp.buf.code_action()<cr>",
                    { buffer = event.buf, desc = "LSP: Code Action..." })

                keymap('<leader>lx1', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "add wsp fldr")
                keymap('<leader>lx2', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', "rm wsp fldr")
                keymap('<leader>lx3', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                    "list wsp fldr")
                keymap('<leader>lx5', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', "show line diagn")
            end
        })

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    },
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim", },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", false),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                }
            }
        })

--         -- powershell
--         local pwsh_home = vim.env.SCOOP or "/usr/lib/pwsh/default"
--         local pwsh_bin = vim.env.PWSH_BIN or (pwsh_home .. "/pwsh")
--         local pwsh_lsp_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
--         lspconfig.powershell_es.setup({
--             -- shell = "powershell.exe",
--             -- bundle_path = pwsh_lsp_path,
--             settings = {
--                 powershell = {
--                     codeFormatting = { Preset = 'OTBS' },
--                     -- codeFormatting = { settingsPath = vim.fn.stdpath("data") .. "/PSCodeFormatting.psd1" },
--                     scriptAnalysis = { settingsPath = vim.fn.stdpath("data") .. "/PSScriptAnalyzerSettings.psd1" },
--                 }
--             },
--             cmd = { pwsh_bin, "-NoLogo", "-NoProfile", "-Command",
--                 -- "& " ..
--                 pwsh_lsp_path .. "/PowerShellEditorServices/Start-EditorServices.ps1"
--                 .. " -BundledModulesPath '" .. pwsh_lsp_path .. "'"
--                 -- .. " -LogLevel 'Diagnostic' -LogPath '" .. vim.fn.stdpath("data") .. "/powershell.log'"
--                 .. " -SessionDetailsPath '" .. vim.fn.stdpath("data") .. "/powershell.session.json'"
--                 .. " -FeatureFlags @() -AdditionalModules @()"
--                 -- .. " -HostName 'nvim' -HostProfileId 'nvim' -HostVersion '1.0.0' -Stdio"
--                 .. " -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio"
--                 -- .. " -HostName 'nvim' -HostProfileId 0 -HostVersion '1.0.0' -Stdio"
--             },
--             root_dir = function(fname)
--                 return lspconfig.util.root_pattern(".git")(fname) or vim.fn.getcwd()
--             end,
--             on_attach = function(client, bufnr)
--                 vim.keymap.set('n', '<Leader>r', ":w | !powershell.exe ./%<cr>",
--                     { buffer = bufnr, desc = "Save and Run Powershell." })
--             end
--         }) -- end powershell

        -- java, last version of jdtls supports java 11 should be 1.12.0. how to download and install this particular verstion with mason? goddamn!
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local java_home = vim.env.JAVA_HOME or "/usr/lib/jvm/default"
        local jdtls_home = vim.env.JDTLS_HOME or (vim.fn.stdpath("data") .. "/mason/packages/jdtls")
        local jdtls_config = jdtls_home .. "/config_win"
        local jdtls_launcher = jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar"
        local data_tmp = vim.env.TEMP or "/tmp"

        lspconfig.jdtls.setup {
            cmd = {
                --
                java_home .. "/bin/java",
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",

                -- " -Dosgi.checkConfiguration=true",
                -- " -Dosgi.sharedConfiguration.area='c:/users/dkl/appdata/local/nvim-data/lsp/java/config_win'",
                -- " -Dosgi.sharedConfiguration.area.readOnly=true",
                -- " -Dosgi.configuration.cascaded=true",
                -- " -noverify",

                "-Dlog.level=ALL", "-Dlog.protocol=true",
                "-Xms1g", "-Xmx4g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                --
                "-javaagent:" .. jdtls_home .. "/lombok.jar",
                --
                "-jar", vim.fn.glob(jdtls_launcher),
                "-configuration", jdtls_config,
                -- "-data", (vim.fs.dirname(vim.fs.find({"pom.xml"}, { upward = true })[1]) or vim.fn.getcwd()) .. "/.jdtls"
                "-data", data_tmp .. "/.jdtls-" .. project_name
            },
            settings = {
                java = {
                    home = vim.env.JAVA_HOME,
                    signatureHelp = { enabled = true },
                    import = { enabled = true },
                    rename = { enabled = true },
                    eclipse = { downloadSources = true, },
                    maven = { downloadSources = true, },
                }
            },
            init_options = {
                bundles = {}
            },

            -- root_dir = function()
            --   return {
            --         "pom.xml", -- Maven
            --         "build.xml", -- Ant
            --       }          -- Multi-module projects { "build.gradle", "build.gradle.kts" },
            --       -- or vim.fn.getcwd()
            -- end,

            single_file_support = true,
        }
        -- lspconfig.jdtls.setup().find_root({ "pom.xml" })
        -- require("jdtls.setup").find_root({ "pom.xml" })

        -- local cmp = require("cmp")
        -- cmp.setup({
        --   mapping = {
        --     ["<CR>"] = cmp.mapping.confirm({ select = false }),
        --   }
        -- })
    end
}
