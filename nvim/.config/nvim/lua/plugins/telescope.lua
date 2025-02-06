return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	keys = {
		{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer search" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find All Files" },
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
		{ "<leader>fj", "<cmd>Telescope command_history<cr>", desc = "History" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fl", "<cmd>Telescope lsp_references<cr>", desc = "Lsp References" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
		{ "<leader>fr", "<cmd>Telescope live_grep<cr>", desc = "Ripgrep" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
		{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				-- configure to use ripgrep
				vimgrep_arguments = {
					"rg",
					"--follow", -- Follow symbolic links
					"--hidden", -- Search for hidden files
					"--no-heading", -- Don't group matches by each file
					"--with-filename", -- Print the file path with the matched lines
					"--line-number", -- Show line numbers
					"--column", -- Show column numbers
					"--smart-case", -- Smart case search

					-- Exclude some patterns from search
					"--glob=!**/.git/*",
					"--glob=!**/.idea/*",
					"--glob=!**/.vscode/*",
					"--glob=!**/build/*",
					"--glob=!**/dist/*",
					"--glob=!**/yarn.lock",
					"--glob=!**/package-lock.json",
				},
			},
			pickers = {
				-- live_grep = {
				--     file_ignore_patterns = { '^node_modules/', '.git', '.venv' },
				--     additional_args = function(_)
				--         return { "--hidden" }
				--     end
				-- },
				find_files = {
					hidden = true,
					-- file_ignore_patterns = { '^node_modules/', '.git', '.venv' },
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/.vscode/*",
						"--glob=!**/build/*",
						"--glob=!**/dist/*",
						"--glob=!**/yarn.lock",
						"--glob=!**/package-lock.json",
						"--glob=!**/%.undo",
						-- "!.undo/**",
					},
				},
				oldfiles = {
					cwd_only = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
