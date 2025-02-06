-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     config = function()
--       local config = require("nvim-treesitter.configs")
--       config.setup({
--         auto_install = true,
--         highlight = { enable = true },
--         indent = { enable = true },
--       })
--     end
--   }
-- }
return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				auto_install = true,
				ensure_installed = {
					"lua",
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"tsx",
					"http",
					"json",
					"yaml",
					"markdown",
					"markdown_inline",
					"dockerfile",
					"gitignore",
					"vim",
					"vimdoc",
					"sql",
				},
			})
		end,
	},
}
