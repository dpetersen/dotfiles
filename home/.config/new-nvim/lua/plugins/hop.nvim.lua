return {
    {
        'smoka7/hop.nvim',
        keys = { "<leader>h" },
        config = function()
            local hop = require("hop")
            hop.setup()

            vim.keymap.set("n", "<Leader>hw", hop.hint_words, { noremap = true })
            vim.keymap.set("n", "<Leader>hW", function() hop.hint_words({ multi_windows = true }) end, { noremap = true })
        end
    },
}
