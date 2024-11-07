require("config.lazy")

vim.cmd("colorscheme onedark_vivid")
vim.cmd("hi StatusLine guibg=gray13") -- todo: find the actual right one
vim.cmd("hi StatusLineNC guibg=gray13")
vim.cmd("set number")
vim.opt.clipboard = "unnamedplus"

require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").pyright.setup {}

-- make diagnostics show up in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = true,
  }
)

vim.keymap.set('n', 'ew', '<Plug>(easymotion-bd-w)')
vim.keymap.set('n', 'ef', '<Plug>(easymotion-s)')
vim.keymap.set('n', 'el', '<Plug>(easymotion-bd-jk)')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
