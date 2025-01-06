vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use("mbbill/undotree")

	use({
		"williamboman/mason.nvim",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "mfussenegger/nvim-lint" },
			{ "mhartington/formatter.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
	})

	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio"
		}
	})

	use({ "lewis6991/gitsigns.nvim" })

	use({ "theprimeagen/harpoon" })

	use({ "nvim-tree/nvim-tree.lua", requires = {
		{ "nvim-tree/nvim-web-devicons" },
	} })

	use({ "mfussenegger/nvim-jdtls" })

	use({ "b3nj5m1n/kommentary" })

	use({ "andweeb/presence.nvim" })
end)
