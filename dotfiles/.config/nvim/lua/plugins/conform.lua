return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		local conform = require("conform")
		conform.setup({
			format_on_save = { lsp_fallback = true },
			formatters_by_ft = {
				lua = { "stylua" },
				bash = { "beautysh" },
				sh = { "beautysh" },
				css = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				php = { "php-cs-fixer" },
				blade = { "prettier" },
				javascript = { "prettier" },
				scss = { "prettier" },
				sass = { "prettier" },
				python = { "black" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				typescript = { "prettier" },
			},
			formatters = {
				prettier = {
					command = "/home/zero/.config/nvim/node_modules/.bin/prettier"
				},
				["php-cs-fixer"] = {
					command = "/home/arch/.config/composer/vendor/bin/php-cs-fixer",
					args = { "fix", "$FILENAME", "--allow-risky=yes" },
					stdin = false,
				},
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})
	end,
}
