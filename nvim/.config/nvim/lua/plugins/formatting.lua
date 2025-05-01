return {
	"stevearc/conform.nvim",
	lazy = true,
	formatters = {
		clang_format = {
			command = "clang-format",
			args = { "--style=file", "--fallback-style=LLVM" },
			-- -- Search upward for .clang-format file
			-- cwd = function(ctx)
			-- 	-- Custom root finder without lspconfig
			-- 	local path = ctx.filename:match("^(.*)/")
			-- 	while path and path ~= "/" do
			-- 		if vim.fn.filereadable(path .. "/.clang-format") == 1 then
			-- 			return path
			-- 		end
			-- 		path = path:match("^(.*)/")
			-- 	end
			-- 	return vim.fn.getcwd()
			-- end,
		},
	},
	event = { "BufReadPre", "BufNewFile", "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		quiet = true,
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			markdown = { "prettier" },
			yaml = { "prettier" },
			sh = { "beautysh" },
			bash = { "beautysh" },
			zsh = { "beautysh" },
			lua = { "stylua" },
		},
		format_on_save = function(bufnr)
			-- Disable autoformat for files in a certain path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end

			return { timeout_ms = 3000, lsp_fallback = false, async = false }
		end,
		-- format_after_save = { lsp_fallback = false },
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		-- Auto-create .clang-format in project root
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.c", "*.cpp", "*.h" },
			callback = function()
				local path = vim.fn.expand("%:p:h")
				local config_path = path .. "/.clang-format"
				if vim.fn.filereadable(config_path) == 0 then
					local file = io.open(config_path, "w")
					if file then
						file:write("BasedOnStyle: LLVM\nIndentWidth: 4")
						file:close()
					end
				end
			end,
		})

		-- Customize prettier args
		require("conform.formatters.prettier").args = function(_, ctx)
			local prettier_roots = { ".prettierrc", ".prettierrc.json", "prettier.config.js" }
			local args = { "--stdin-filepath", "$FILENAME" }
			local config_path = vim.fn.stdpath("config")

			local localPrettierConfig = vim.fs.find(prettier_roots, {
				upward = true,
				path = ctx.dirname,
				type = "file",
			})[1]
			local globalPrettierConfig = vim.fs.find(prettier_roots, {
				path = type(config_path) == "string" and config_path or config_path[1],
				type = "file",
			})[1]
			local disableGlobalPrettierConfig = os.getenv("DISABLE_GLOBAL_PRETTIER_CONFIG")

			-- Project config takes precedence over global config
			if localPrettierConfig then
				vim.list_extend(args, { "--config", localPrettierConfig })
			elseif globalPrettierConfig and not disableGlobalPrettierConfig then
				vim.list_extend(args, { "--config", globalPrettierConfig })
			end

			-- local hasTailwindPrettierPlugin = vim.fs.find('node_modules/prettier-plugin-tailwindcss', {
			--   upward = true,
			--   path = ctx.dirname,
			--   type = 'directory'
			-- })[1]
			--
			-- if hasTailwindPrettierPlugin then
			--   vim.list_extend(args, {'--plugin', 'prettier-plugin-tailwindcss'})
			-- end

			return args
		end

		-- conform.formatters.beautysh = {
		-- 	prepend_args = function()
		-- 		return { "--indent-size", "2", "--force-function-style", "fnpar" }
		-- 	end,
		-- }
	end,
}
