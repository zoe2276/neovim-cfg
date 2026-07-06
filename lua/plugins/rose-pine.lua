vim.pack.add({
    {
        src = gh("/rose-pine/neovim"),
        name = "rose-pine"
    }
})

require("rose-pine").setup({
    variant = "moon"
})

vim.cmd("colorscheme rose-pine")
