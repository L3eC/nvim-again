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
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"easymotion/vim-easymotion"
	},
}

