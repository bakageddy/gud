---@diagnostic disable
local cmp = require("blink.cmp")
-- local snip = require("luasnip")
local neodev = require("neodev")
local config = require("lspconfig")
local lsp_capabilities = cmp.get_lsp_capabilities()

-- local has_words_before = function()
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--

vim.keymap.set("n", "[e", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)

cmp.setup({
	keymap = {
		preset = 'none',
		['<C-space>'] = {'show', 'show_documentation', 'hide_documentation'},
		['<C-y>'] = {'select_and_accept'},
		['<C-n>'] = {'select_next', 'fallback'},
		['<C-p>'] = {'select_prev', 'fallback'},
		['<C-d>'] = {'snippet_forward', 'fallback'},
		['K'] = {'show_signature', 'fallback'},
	},
	appearance = {
		nerd_font_variant = 'mono',
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 }
	},
	sources = {
		default = {'lsp', 'buffer', 'path', 'snippets', 'omni'}
	},
	snippets = {
		preset = 'luasnip'
	},
	fuzzy = {
		implementation = 'lua'
	}
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
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


require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		"jdtls",
		"rust_analyzer",
		"gopls",
		"lua_ls",
	},
	handlers = {
		function(server_name)
			config[server_name].setup({
				capabilities = vim.lsp.protocol.make_client_capabilities,
			})
		end,
		-- jdtls = function () end,
	}
});
--
-- local java_cmds = vim.api.nvim_create_augroup("java_cmds", {clear = true})
--
-- local root_files = {
-- 	'.git',
-- 	'mvnw',
-- 	'gradlew',
-- 	'build.gradle',
-- 	'pom.xml',
-- 	'build/build.xml'
-- }
--
-- local features = {
-- 	codelens = true,
-- 	debugger = false,
-- }
--
-- local cache_vars = {}
--
-- local function get_jdtls_path()
-- 	if cache_vars.path then
-- 		return cache_vars.path
-- 	end
--
-- 	path = {}
-- 	path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
-- 	local jdtls_install = require("mason-registry").get_package('jdtls'):get_installed_path()
--
-- 	path.java_agent = jdtls_install .. '/lombok.jar'
-- 	path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')
--
-- 	cache_vars.path = path
-- 	return path
-- end

-- local function enable_codelens(bufnr)
-- 	pcall(vim.lsp.codelens.refresh)
--
-- 	vim.api.nvim_create_autocmd('BufWritePost', {
-- 		buffer = bufnr,
-- 		group  = java_cmds,
-- 		desc = 'refresh codelens',
-- 		callback = function ()
-- 			pcall(vim.lsp.codelens.refresh)
-- 		end,
-- 	})
-- end
--
-- local jdtls = require("jdtls")
-- local function jdtls_on_attach(client, bufnr)
-- 	if features.codelens then
-- 		enable_codelens(bufnr)
-- 	end
-- 	local opts = { buffer = bufnr }
-- 	vim.keymap.set("n", "<space>coi", jdtls.organize_imports, opts)
-- 	vim.keymap.set("n", "<space>cev", jdtls.extract_variable, opts)
-- 	vim.keymap.set("n", "<space>cec", jdtls.extract_constant, opts)
-- 	vim.keymap.set("n", "<space>cem", jdtls.extract_method, opts)
-- end
--
-- local function jdtls_setup(event)
--   local jdtls = require('jdtls')
--
--   local path = get_jdtls_path()
--   local data_dir = path.data_dir .. '/' ..  vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
--
--   if cache_vars.capabilities == nil then
--     jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
--
--     local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
--     cache_vars.capabilities = vim.tbl_deep_extend(
--       'force',
--       vim.lsp.protocol.make_client_capabilities(),
--       ok_cmp and cmp_lsp.default_capabilities() or {}
--     )
--   end
--
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
-- local cmd = {
--     'java',
--
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-javaagent:' .. path.java_agent,
--     '-Xms1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens',
--     'java.base/java.util=ALL-UNNAMED',
--     '--add-opens',
--     'java.base/java.lang=ALL-UNNAMED',
--     '-jar',
--     path.launcher_jar,
--     '-configuration',
--     path.platform_config,
--     '-data',
--     data_dir,
--   }
--
--   local lsp_settings = {
--     java = {
--       -- jdt = {
--       --   ls = {
--       --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
--       --   }
--       -- },
--       eclipse = {
--         downloadSources = true,
--       },
--       configuration = {
--         updateBuildConfiguration = 'interactive',
--         runtimes = path.runtimes,
--       },
--       maven = {
--         downloadSources = true,
--       },
--       implementationsCodeLens = {
--         enabled = true,
--       },
--       referencesCodeLens = {
--         enabled = true,
--       },
--       -- inlayHints = {
--       --   parameterNames = {
--       --     enabled = 'all' -- literals, all, none
--       --   }
--       -- },
--       format = {
--         enabled = true,
--         -- settings = {
--         --   profile = 'asdf'
--         -- },
--       }
--     },
--     signatureHelp = {
--       enabled = true,
--     },
--     completion = {
--       favoriteStaticMembers = {
--         'org.hamcrest.MatcherAssert.assertThat',
--         'org.hamcrest.Matchers.*',
--         'org.hamcrest.CoreMatchers.*',
--         'org.junit.jupiter.api.Assertions.*',
--         'java.util.Objects.requireNonNull',
--         'java.util.Objects.requireNonNullElse',
--         'org.mockito.Mockito.*',
--       },
--     },
--     contentProvider = {
--       preferred = 'fernflower',
--     },
--     extendedClientCapabilities = jdtls.extendedClientCapabilities,
--     sources = {
--       organizeImports = {
--         starThreshold = 9999,
--         staticStarThreshold = 9999,
--       }
--     },
--     codeGeneration = {
--       toString = {
--         template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
--       },
--       useBlocks = true,
--     },
--   }
--
--   -- This starts a new client & server,
--   -- or attaches to an existing client & server depending on the `root_dir`.
--   jdtls.start_or_attach({
--     cmd = cmd,
--     settings = lsp_settings,
--     on_attach = jdtls_on_attach,
--     capabilities = cache_vars.capabilities,
--     root_dir = jdtls.setup.find_root(root_files),
--     flags = {
--       allow_incremental_sync = true,
--     },
--     init_options = {
--       bundles = path.bundles,
--     },
--   })
-- end
--
-- vim.api.nvim_create_autocmd('FileType', {
--   group = java_cmds,
--   pattern = {'java'},
--   desc = 'Setup jdtls',
--   callback = jdtls_setup,
-- })

neodev.setup()
