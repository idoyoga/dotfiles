local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- Global LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Configure capabilities globally for all servers (including Copilot)
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = { 'utf-16' }  -- Allow both utf-8 and utf-16

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, bufnr)
    client.offset_encoding = 'utf-16'  -- Set the encoding to match Copilot
  end,
}
-- Configure the TypeScript/JavaScript language server
lspconfig.clangd.setup{
  cmd = {
    "clangd",
    "--background-index", -- Enables background indexing of the entire project
    "--clang-tidy",       -- Use clang-tidy for diagnostics
    "--compile-commands-dir=build" -- Replace 'build' with your compile_commands.json directory
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
	client.offset_encoding = 'utf-16'

    -- Buffer-specific keybindings (including rename)
    -- local opts = { buffer = bufnr }
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  end,
}

-- If you also work with CMake projects, you might want to use the `cmake` language server
-- lspconfig.cmake.setup{}

-- If you want to use any other LSP servers, configure them here

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-k>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
-- here you can setup the language servers
require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			client.offset_encoding = 'utf-16'
		end
	})
    end,
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>F', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.diagnostic.config({
	-- update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
