-- todo: 
-- make gd go to definition, not the random thing it is rn
-- open recent files more easily than typing their names verbatim
-- add keybind to go somewhere with easymotion and enter insert mode or
-- add easymotion insert mode keybinds?
-- make it easier to split a window and open some file in the new half
-- remap esc??
-- git stuff
-- automatically activate correct venv for a given project
-- make it look more unified
-- no autocomplete on comments or text files
-- make autocomplete delete the rest of a wrong words, e.g. if im in example, go to x, type ac, it should complete to exact, not exactmple
-- make dashed/indented lists preserve the same indent, so a text that wraps around won't forget its indentation 
	-- :help formatoptions?

require("config.lazy")

--------------- BASIC STUFF/VIM NATIVE SETTINGS ---------------
vim.cmd("colorscheme onedark_vivid")
vim.cmd("hi StatusLine guibg=gray13") -- todo: find the actual right one
vim.cmd("hi StatusLineNC guibg=gray13")
vim.cmd("set number")
vim.cmd("set linebreak")
vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', 'ZZ', function() vim.cmd("wa"); vim.cmd("qa!"); end)
vim.keymap.set('n', 'G', 'G$')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.cmd("let g:startify_session_persistence=1")

---------------- LSP STUFF ----------------
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
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

--------------- EASYMOTION -----------------
vim.keymap.set('n', 'ew', '<Plug>(easymotion-bd-w)')
vim.keymap.set('n', 'ef', '<Plug>(easymotion-s)')
vim.keymap.set('n', 'el', '<Plug>(easymotion-bd-jk)')
vim.keymap.set('n', 'ee', '<Plug>(easymotion-bd-e)')
vim.keymap.set('o', 'ew', '<Plug>(easymotion-bd-w)')
vim.keymap.set('o', 'ef', '<Plug>(easymotion-s)')
vim.keymap.set('o', 'el', '<Plug>(easymotion-bd-jk)')
vim.keymap.set('o', 'ee', '<Plug>(easymotion-bd-e)')
vim.keymap.set('v', 'ew', '<Plug>(easymotion-bd-w)')
vim.keymap.set('v', 'ef', '<Plug>(easymotion-s)')
vim.keymap.set('v', 'el', '<Plug>(easymotion-bd-jk)')
vim.keymap.set('v', 'ee', '<Plug>(easymotion-bd-e)')

-------------- TELESCOPE --------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fj', function()builtin.live_grep({grep_open_files=true})end, {desc = 'Telescope grep in open files'})


------------- Autocompletion -----------
local cmp = require'cmp'


cmp.setup({
  enabled = function()
	  return not (vim.bo.filetype == 'text')
  end,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'nvim_lsp_signature_help'},
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, 
    {
       { name = 'buffer' },
    }),
})
