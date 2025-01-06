if not table.unpack then
    table.unpack = unpack
end

local on_attach = function(_, bufnr)
	require('jdtls.setup').add_commands()

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- Java specific
	vim.keymap.set('n', '<leader>di', "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
	vim.keymap.set('n', '<leader>dt', "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
	vim.keymap.set('n', '<leader>dn', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
	vim.keymap.set('v', '<leader>de', "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
	vim.keymap.set('n', '<leader>de', "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
	vim.keymap.set('v', '<leader>dm', "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities = {
	table.unpack(capabilities),
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true,
			},
		},
	},
}

local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local eclipse_dir = '~/lsp/eclipse.jdt.ls'
local jdtls_eclipse_dir = eclipse_dir .. '/org.eclipse.jdt.ls.product/target/repository'

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', jdtls_eclipse_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', jdtls_eclipse_dir .. '/config_linux',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', eclipse_dir .. '/workspaces/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	flags = {
		allow_incremental_sync = true,
	},
  root_dir = vim.fs.root(0, {'.git', 'mvnw', 'gradlew'}),
	capabilities = capabilities,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
	on_attach = on_attach,
  settings = {
    java = {
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			signatureHelp = { enabled = true },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
				},
			},

    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
		extendedClientCapabilities = extendedClientCapabilities,
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

-- UI
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
	local opts = {}
	pickers
		.new(opts, {
			prompt_title = prompt,
			finder = finders.new_table({
				results = items,
				entry_maker = function(entry)
					return {
						value = entry,
						display = label_fn(entry),
						ordinal = label_fn(entry),
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr)
				actions.goto_file_selection_edit:replace(function()
					local selection = actions.get_selected_entry(prompt_bufnr)
					actions.close(prompt_bufnr)

					cb(selection.value)
				end)

				return true
			end,
		})
		:find()
end
