return {
    {
        "tpope/vim-fugitive",
        config = function()
            local noremap = { noremap = true }
            vim.keymap.set("n", "<leader>gs", ":Git<CR>", noremap)
            vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", noremap)
            vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", noremap)
            vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", noremap)
        end,
    },
}
