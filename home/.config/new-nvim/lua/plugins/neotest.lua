return {
    {
        -- Run specs from inside Neovim
        "nvim-neotest/neotest",
        keys = { "<leader>t" },
        dependencies = {
            -- Their documented dependencies
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

            -- Adapters I use
            "olimorris/neotest-rspec",
        },
        -- Can't be ops because the adapters block tries to evaluate before the dependencies are installed
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-rspec")
                },
            })

            local nrs = { noremap = true, silent = true }

            -- Toggle summary sidebar
            vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, nrs)
            -- Toggle output panel
            -- TODO: decide if you want the floating output thing or maybe diagnostics? Do you need to install the neotest rspec adapter?
            vim.keymap.set("n", "<leader>to", neotest.output_panel.toggle, nrs)

            -- Test Neartest to cursor
            vim.keymap.set("n", "<leader>tn", neotest.run.run, nrs)
            -- Re-run last test
            vim.keymap.set("n", "<leader>tt", neotest.run.run_last, nrs)
            -- Run whole file
            vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, nrs)
            -- Stop running
            vim.keymap.set("n", "<leader>ts", neotest.run.stop, nrs)
        end,
    },
}
