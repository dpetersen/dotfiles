return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            -- Just a treesitter-aware port of tpope/endwise that works in a few languages
            "RRethy/nvim-treesitter-endwise",
        },
        config = function()
            require("nvim-treesitter").setup({})

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)

                    -- Enable treesitter-based folding, but start with all folds open
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo.foldlevel = 99
                end,
            })
        end,
        build = ":TSUpdate",
    },
    {
        -- A treesitter-aware version of matchit. Can work without treesitter but it's
        -- significantly faster with treesitter enabled in large files.
        "andymass/vim-matchup",
        config = function()
            require("match-up").setup({
                treesitter = { enable = true },
            })
        end,
    },
}
