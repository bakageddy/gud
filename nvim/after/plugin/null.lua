local null = require("null-ls")

null.setup({
	sources = {
		null.builtins.formatting.gofumpt,
		null.builtins.formatting.sql_formatter
		-- null.builtins.formatting.prettierd,
		-- null.builtins.formatting.autoflake,
		--
		-- null.builtins.diagnostics.revive,
		-- null.builtins.diagnostics.selene,
		-- null.builtins.diagnostics.flake8,
		-- null.builtins.diagnostics.stylelint,
		-- null.builtins.diagnostics.ruff,
		--
		-- null.builtins.code_actions.eslint_d,
	}
})
