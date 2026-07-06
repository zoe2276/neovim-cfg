vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then vim.cmd("TSUpdate") end
    end
})

vim.pack.add({
    gh("/nvim-treesitter/nvim-treesitter"),
    -- deps
    gh("/neovim-treesitter/treesitter-parser-registry")
})

-- require("nvim-treesitter").install({ "rust", "javascript", "typescript", "tsx", "powershell" })

