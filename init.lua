-- todo: 
-- add keybind to go somewhere with easymotion and enter insert mode or
-- add easymotion insert mode keybinds?
-- git stuff
-- make it look more unified
-- no autocomplete on comments
-- make autocomplete delete the rest of a wrong words, e.g. if im in example, go to x, type ac, it should complete to exact, not exactmple
-- make dashed/indented lists preserve the same indent, so a text that wraps around won't forget its indentation 
	-- :help formatoptions?
-- MAKE AUTOCOMPLETION NOT JUMP AND MOVE AROUND SO MUCH
-- MAKE SIGNATURE HELP NOT DISAPPEAR NONSTOP
-- make pomodoro timer plugin
require("config.lazy")

--------------- BASIC STUFF/VIM NATIVE SETTINGS ---------------
vim.cmd("colorscheme onedark_vivid")
vim.cmd("hi StatusLine guibg=gray13") 
vim.cmd("hi StatusLineNC guibg=gray13")
vim.cmd("set number")
vim.cmd("set linebreak")
vim.cmd(":hi DiagnosticVirtualTextHint guifg=#415a80")
vim.cmd(":hi DiagnosticSignHint guifg=#415a80")
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"

vim.keymap.set('n', 'ZZ', function() vim.cmd("wa"); vim.cmd("qa!"); end)

vim.keymap.set('n', 'G', 'G$')

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('v', 'j', 'gj')
vim.keymap.set('v', 'k', 'gk')

vim.keymap.set('n', '<leader>jo', '^ld0i<BS><Esc>kA.<Esc>j$', { desc = 'join sentences in outline' })
vim.keymap.set('n', '<leader>jp', '^ld0i<BS>.<Esc>kA.<Esc>j$', { desc = 'join sentences in outline adding periods' })

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  command = "wa"
})

vim.cmd("let g:startify_session_persistence=1")
vim.keymap.set("n", "<C-s>", function() vim.cmd("Startify") end)
-- vim.keymap.set('n', '<C-w>s', )

---------------- LSP STUFF ----------------
require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").pyright.setup {}

-- make diagnostics show up in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = false,
  }
)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

-- automatically use cached venv for python projects
vim.api.nvim_create_autocmd({'BufNew'}, {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function() vim.cmd("silent VenvSelectCached") end,
})
--[[
vim.lsp.handlers['textDocument/signatureHelp']  = vim.lsp.with(vim.lsp.handlers['signature_help'], {
    border = 'single',
    close_events = { "CursorMoved", "BufHidden" },
})
vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help)
--]]
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
	  return not (vim.bo.filetype == 'text') -- if you want to exclude other filetypes, you have to also do it in the autocmd below
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

-- make autocomplete menu show up after some time
local timer = nil
vim.api.nvim_create_autocmd({ "TextChangedI", "CmdlineChanged" }, {
  -- pattern = "*",
  callback = function()
    if not (vim.bo.filetype == "text") then
	    if timer then
	      vim.loop.timer_stop(timer)
	      timer = nil
	    end

	    timer = vim.loop.new_timer()
	    timer:start(499, 0, vim.schedule_wrap(function()
	      require('cmp').complete({ reason = require('cmp').ContextReason.Auto })
	    end))
    end
  end
})

---------------------------- TREESITTER ------------------------------

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "python", "lua", },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --[[
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    ]]--

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
