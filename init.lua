-- general configs
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- timing
vim.opt.updatetime = 250

-- tab stuff
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- leader key
vim.g.mapleader = " "

-- system clipboard
vim.opt.clipboard = "unnamedplus"

-- packages
vim.pack.add({
    -- themes
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/projekt0n/github-nvim-theme" },
    -- lsp and autocomplete
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                version = vim.version.range("*") },
    -- other stuff
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

-- theme setup
vim.cmd("colorscheme vague")

-- treesitter
require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = { enable = true, },
})

-- lsp setup
require("mason").setup()

local installedPacks = require("mason-registry").get_installed_packages()
local lspConfigNames = vim.iter(installedPacks):fold({}, function(acc, pack)
    table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
    return acc
end)
vim.lsp.enable(lspConfigNames)

-- vim.lsp.enable({ "lua_ls", "clangd", "basedpyright", "html", "cssls",
--     "vtsls", "rust_analyzer", "r_language_server", })

-- telescope ignore directories
require("telescope").setup({
    defaults = { file_ignore_patterns = { "R/", } }
})

-- lsp configs
vim.lsp.config("lua_ls", {
    settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } }
})
vim.lsp.config("basedpyright", {
    settings = { basedpyright = { analysis = { typeCheckingMode = "basic", autoImportCompletions = false, } } }
})
vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never" }
})

-- autocomplete
require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
})

-- floating diagnostic messages
vim.diagnostic.config {
    severity_sort = true,
    virtual_text = true,
    -- virtual_lines = true,
}

-- telescope keymaps
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

-- other keymaps
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Netrw" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write to file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight" }) -- esc to remove search highlight
