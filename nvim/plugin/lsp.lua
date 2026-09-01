vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/folke/lazydev.nvim",

	"https://github.com/nvimtools/none-ls.nvim"
})

-- local lspconfig = require("lspconfig")
local cmp = require("blink.cmp")
-- local lsp_capibilities = cmp.get_lsp_capabilities()
local _ = require("lazydev").setup()
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.sql_formatter,
	}
})


cmp.setup({
	keymap = {
		preset = 'none',
		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-y>'] = { 'select_and_accept' },
		['<C-n>'] = { 'select_next', 'fallback' },
		['<C-p>'] = { 'select_prev', 'fallback' },
		['<C-d>'] = { 'snippet_forward', 'fallback' },
		['<C-s>'] = { 'snippet_backward', 'fallback' },
		['K'] = { 'show_signature', 'fallback' },
	},
	appearance = {
		nerd_font_variant = 'mono',
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 }
	},
	sources = {
		default = { 'lsp', 'buffer', 'path', 'snippets', 'omni' }
	},
	snippets = {
		preset = 'luasnip'
	},
	fuzzy = {
		implementation = 'lua'
	}
})

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		"jdtls",
		"rust_analyzer",
		"lua_ls",
	},
	handlers = {
		function(server_name)
			if (server_name == 'jdlts') then
				config[server_name].setup({
					init_options = {
						bundles = '/home/dinesh-24010/Projects/Work/jars/'
					}
				})
			end
			config[server_name].setup({
				capabilities = vim.lsp.protocol.make_client_capabilities,
			})
		end,
	}
});

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client ~= nil then
			client.server_capabilities.semanticTokensProvider = nil
		end
		-- if client.supports_method('textDocument/completion') then
		-- 	vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		-- end
		local opts = { buffer = args.buf, remap = false }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>ss", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set("n", "<leader>ff", function()
			vim.lsp.buf.format { async = true }
		end, {})
	end
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = 'E',
			[vim.diagnostic.severity.WARN] = 'W',
			[vim.diagnostic.severity.HINT] = 'H',
			[vim.diagnostic.severity.INFO] = 'I',
		},
	},
})
