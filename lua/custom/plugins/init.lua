-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>",function() ui.nav_file(1)end)
            vim.keymap.set("n", "<C-j>",function() ui.nav_file(2)end)
            vim.keymap.set("n", "<C-k>",function() ui.nav_file(3)end)
            vim.keymap.set("n", "<C-l>",function() ui.nav_file(4)end)
        end

    },
    {
        "mbbill/undotree",

        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
            vim.opt.undofile = true
            vim.opt.undodir = os.getenv("HOME") .. "/.local/undodir"
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

            local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

            local autocmd = vim.api.nvim_create_autocmd
            autocmd("BufWinEnter", {
                group = ThePrimeagen_Fugitive,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = {buffer = bufnr, remap = false}
                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git('push')
                    end, opts)

                    vim.keymap.set("n", "<leader>P", function()
                        vim.cmd.Git({'pull',  '--rebase'})
                    end, opts)

                    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
                end,
            })


            vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
        end
    }


}
