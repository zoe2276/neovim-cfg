--[
--| default config
--]
vim.o.number = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.guifont = "Agave:h17"
vim.o.scrolloff = 7

vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.33
vim.g.neovide_cursor_vfx_particle_density = 1.33
vim.g.neovide_cursor_vfx_particle_speed = 4.33

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

--[
--| helper funcs
--]
gh = function(x) return "https://github.com" .. x end

--[
--| plugins
--]
require("plugins.autoclose")
require("plugins.neo-tree")
require("plugins.nvim-treesitter")
require("plugins.rose-pine")
require("plugins.telescope")
require("plugins.which-key")

--[
--| generic keybinds
--]
-- vim.keymap.set("n", "<leader>wref", "<Cmd>w<CR><Cmd>so %<CR>", { desc = "Save and refresh (re-source) current file" })

-- [
-- | commands
-- ]

-- write and refresh
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

-- dynamic font size
-- vim.api.nvim_clear_autocmds({ event = { "FocusGained" } })

vim.api.nvim_create_autocmd({ "FocusGained" }, {
    callback = function()
        local uname = vim.uv.os_uname().sysname
        local dims = nil

        if uname == "Linux" then
            -- hyprland
            local ok, mons = pcall(function()
                return vim.json.decode(vim.fn.system("hyprctl monitors -j"))
            end)
            
            if ok and mons then
                for _, m in ipairs(mons) do
                    if m.focused then
                        dims = { width = m.width, height = m.height }
                    end
                end
            end

        elseif uname == "Darwin" then
            -- stupid NSScreen and osascript garbage
            local js = [[
                ObjC.import("AppKit")
                var screens = $.NSScreen.screens
                var mouse = $.NSEvent.mouseLocation
                var out = ""
                for (var i = 0; i < screens.count; i++) {
                    var f = screens.objectAtIndex(i).frame
                    if (mouse.x >= f.origin.x &&
                        mouse.x < f.origin.x + f.size.width &&
                        mouse.y >= f.origin.y &&
                        mouse.y < f.origin.y + f.size.height
                    ) {
                        out = `${f.size.width},${f.size.height}`
                    }
                }
                out
            ]]
            local out = vim.fn.system({ "osascript", "-1", "JavaScript", "-e", js })
            local w, h = out:match("(%d+),(%d+)")
            if w then
                dims = { width = tonumber(w), height = tonumber(h) }
            end
        end

        if not dims then return end

        vim.o.guifont = "Agave:h" .. ((dims.width >= 2000) and 17 or 13)
    end
})

