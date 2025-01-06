return {
    -- Manager UI for LSPs, Linters, and other external tools
    {
        "williamboman/mason.nvim",
        -- Mason recommends it should not be lazy loaded
        lazy = false,
        opts = {},
    },
    -- Bridges the gap between lspconfig and mason
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            -- List of allowed values:
            -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
            ensure_installed = {
                "lua_ls",
                -- I want to install this lua formatter, and it exists in Mason's list, but it can't be referenced by this name?
                -- "stylua",
                "rust_analyzer",
                "gopls",
                "ruby_lsp",
                "rubocop",
                "ts_ls",
                -- Formatters like this don't seem to be available even if Mason knows about them???
                -- "prettierd",
            },
        },
    },
    -- Official plugin with prebuilt configurations for languages
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        init = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            require("lspconfig").lua_ls.setup({ capabilities = capabilities })
        end,
    },
    -- lazydev.nvim is a plugin that properly configures LuaLS for editing
    -- your Neovim config
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
    -- Autocompletion fanciness
    {
        "saghen/blink.cmp",
        version = "*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "default" },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
    -- LSP-aware formatting with easily configurable format-on-save
    {
        "stevearc/conform.nvim",
        -- Their recommended lazy loading configuration
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- typescript = { "prettierd" },
                -- typescriptreact = { "prettierd" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },
}
