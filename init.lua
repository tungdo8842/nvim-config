vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.mapleader = " "

-- system clipboard
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp",             version = vim.version.range('*') },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    -- { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- theme setup
vim.cmd("colorscheme tokyonight-night")

-- require "nvim-treesitter.configs".setup({ auto_install = true })
require "mason".setup()

vim.lsp.enable({ "lua_ls", "clangd", "basedpyright", "html", "cssls", "vtsls" })

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = 'basic',
                autoImportCompletions = false,
            }
        }
    }
})
vim.lsp.config("clangd", {
    cmd = { 'clangd', '--header-insertion=never' }
})

require "blink.cmp".setup({
    keymap = { preset = 'super-tab' },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- floating diagnostic messages
vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = {
        source = 'if_many',
        spacing = 2,
    },
}

-- telescope keymaps
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- other keymaps
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer' })
