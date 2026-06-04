require("lazy").setup({

    -- Colorscheme -- Kanagawa, cold/dark, cyberpunk-adjacent
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                compile = false,
                undercurl = true,
                transparent = false,
                dimInactive = true,
                terminalColors = true,
                theme = "wave",
                overrides = function(colors)
                    return {
                        Cursor = { bg = "#5a9fd4", fg = "#0a0d14" }, -- Blue block cursor
                        Visual = { bg = "#c8951a", fg = "#0a0d14" }, -- Gold visual highlight
                        DapBreakpoint = { fg = "#cc3333", bold = true },
                        DapBreakpointCondition = { fg = "#cc3333", bold = true },
                        DapLogPoint = { fg = "#3d7ab5", bold = true },
                        DapStopped = { fg = "#f0b429", bold = true },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa-wave")
            
            -- Set up DAP signs
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "debugPC", numhl = "debugPC" })
        end,
    },

    -- Dashboard — Bugg Neo Vim
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            vim.api.nvim_set_hl(0, "BNVHeader",   { fg = "#5a9fd4", bold = true })
            vim.api.nvim_set_hl(0, "BNVSubtitle", { fg = "#f0b429" })

            dashboard.section.header.val = {
                "                                              ",
                "  ██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗  ",
                "  ██╔══██╗████╗  ██║██║   ██║██║████╗ ████║  ",
                "  ██████╔╝██╔██╗ ██║██║   ██║██║██╔████╔██║  ",
                "  ██╔══██╗██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
                "  ██████╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
                "  ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
                "                                              ",
                "           B u g g   N e o   V i m           ",
            }
            dashboard.section.header.opts.hl = "BNVHeader"

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file",    ":Telescope find_files <CR>"),
                dashboard.button("n", "  New file",     ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", "  Find text",    ":Telescope live_grep <CR>"),
                dashboard.button("c", "  Config",       ":e $MYVIMRC <CR>"),
                dashboard.button("q", "  Quit",         ":qa<CR>"),
            }

            dashboard.section.footer.val = "Bugg Neo Vim"
            dashboard.section.footer.opts.hl = "BNVSubtitle"

            alpha.setup(dashboard.opts)
        end
    },,

    -- Primeagen Essentials
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("harpoon"):setup() end,
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    -- VSCode-like Bufferline (Tabs)
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    separator_style = "slant",
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        }
                    },
                }
            })
        end,
    },

    -- Keybinding hints (VSCode-like discovery)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function() require("which-key").setup() end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "c", "cpp", "lua", "python", "bash", "json", "yaml" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls" },
            })
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- clangd for C/C++/Assembly
            lsp.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            })
            -- Lua LSP
            lsp.lua_ls.setup({
                capabilities = capabilities,
                settings = { Lua = { diagnostics = { globals = { "vim" } } } }
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item()
                        else fallback() end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- DAP (debugger)
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            -- gdb adapter for C/C++
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" },
            }
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    sorting_strategy = "ascending",
                    layout_config = { prompt_position = "top" },
                },
            })
        end,
    },

    -- File tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true,
                },
                window = {
                    width = 30,
                    mappings = {
                        ["<space>"] = "none", -- disable space in tree to not conflict with leader
                    }
                }
            })
        end,
    },

    -- Terminal integration (Claude/CLI support)
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                shade_terminals = true,
                direction = "float",
                float_opts = { border = "curved" },
            })
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "kanagawa",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "│", right = "│" },
                },
            })
        end,
    },

    -- Git signs in gutter
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("nvim-autopairs").setup() end,
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end,
    },

}, {
    ui = { border = "single" },
})
