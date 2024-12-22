return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"mhinz/vim-startify",
		lazy=false
	},
	{
	       "williamboman/mason.nvim",
	       "williamboman/mason-lspconfig.nvim",
	       "neovim/nvim-lspconfig",
	},    
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
	  },
	  keys = {
	    {
	      "<leader>?",
	      function()
	        require("which-key").show({ global = false })
	      end,
	      desc = "Buffer Local Keymaps (which-key)",
	    },
	  },
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'},
				 {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
		},
	},
	{
  		'nvim-telescope/telescope.nvim',
  		dependencies = { 'rafi/telescope-thesaurus.nvim' },
	},
	{
		"easymotion/vim-easymotion"
	},
	{
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help"
	},
	{
		"jiangmiao/auto-pairs"
	},
	{ 'nvim-treesitter/nvim-treesitter' },
	{
	  "linux-cultist/venv-selector.nvim",
	    dependencies = {
	      "neovim/nvim-lspconfig",
	      "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
	      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	    },
	  lazy = false,
	  branch = "regexp", -- This is the regexp branch, use this for the new version
	  config = function()
	      require("venv-selector").setup()
	    end,
	    keys = {
	      { "<leader>vs", "<cmd>VenvSelect<cr>" },
	    },
	},
	{
	  "ray-x/lsp_signature.nvim",
	  event = "InsertEnter",
	  opts = {
	    bind = true,
	    handler_opts = {
	      border = "rounded"
	    },
	    always_trigger = true
	  },
	  config = function(_, opts) require'lsp_signature'.setup(opts) end
	},
	{
		"L3ec/myplugin",
		lazy = false
	},
	{
	    "nvim-telescope/telescope-file-browser.nvim",
	    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	}
}

