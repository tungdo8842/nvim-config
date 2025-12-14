-- general configs
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10

-- tab stuff
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.mapleader = " "

-- system clipboard
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- packages
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/EdenEast/nightfox.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp",               version = vim.version.range('*') },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- theme setup
vim.cmd("colorscheme carbonfox")

-- treesitter
require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = { enable = true, },
    indent = { enable = true, },
})

-- LSP setup
require("mason").setup()
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

-- autocomplete
require("blink.cmp").setup({
    keymap = { preset = 'super-tab' },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
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
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- other keymaps
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>', { desc = 'Netrw' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write to file' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Remove search highlight' }) -- esc to remove search highlight
