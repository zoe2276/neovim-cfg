-- config
vim.o.number = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.guifont = "Agave:h17"

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- helper funcs
gh = function(x) return "https://github.com" .. x end

-- load plugins
require("plugins.autoclose")
require("plugins.neo-tree")
require("plugins.nvim-treesitter")
require("plugins.rose-pine")
require("plugins.telescope")
require("plugins.which-key")

-- generic keybinds
-- vim.keymap.set("n", "<leader>wref", "<Cmd>w<CR><Cmd>so %<CR>", { desc = "Save and refresh (re-source) current file" })

-- commands
vim.api.nvim_create_user_command(
   "Wref",
   function(opts)
       local fi = (opts.args and opts.args or "%")
       vim.cmd("write")
       vim.cmd("source " .. fi)
   end,
   {
    nargs = "?",
    complete = "file",
    desc = "Write and refresh (re-source) a file. Defaults to current file."
   }
)
