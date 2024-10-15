local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- Global LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Configure capabilities globally for all servers (including Copilot)
capabilities.offset_encoding = { 'utf-8', 'utf-16' }  -- Allow both utf-8 and utf-16

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.offset_encoding = 'utf-16'  -- Set the encoding to match Copilot
  end,
}
-- Configure the TypeScript/JavaScript language server
lspconfig.clangd.setup{}
-- You can add additional configuration options here if needed
  -- For example, specify the path to the clangd executable if it's not in your PATH
  -- cmd = { "path/to/clangd" },

  -- Additional settings can be customized here
  -- e.g., setting up specific arguments or paths


-- If you also work with CMake projects, you might want to use the `cmake` language server
-- lspconfig.cmake.setup{}

-- If you want to use any other LSP servers, configure them here

cmp.setup({
  window = {
	-- Position completion suggestions below the cursor
    completion = cmp.config.window.bordered({
      side_padding = 1,  -- Adjust padding
      col_offset = 0,
      row_offset = 1,  -- Row 1 means it will be placed **below** the cursor
    }),

	-- Documentation window settings
   documentation = cmp.config.window.bordered({
      max_width = 60,
      max_height = 12,
      border = "rounded",
      position = { col = 0, row = 2 },
    }),
},

  mapping = cmp.mapping.preset.insert({
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- Toggle signature help for cmp
local show_signature_help = true

function ToggleSignatureHelp()
  show_signature_help = not show_signature_help
  cmp.setup({
    window = {
      documentation = show_signature_help and {
        border = "rounded",
        position = { col = 0, row = 2 } -- Show **below** the cursor
      } or nil,
    },
  })
  print("Signature help: " .. (show_signature_help and "ON" or "OFF"))
end

-- Map a key to toggle the signature help for cmp
vim.api.nvim_set_keymap('n', '<leader>ts', ':lua ToggleSignatureHelp()<CR>', { noremap = true, silent = true })

-- here you can setup the language servers
require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
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

-- Position the signature help window below the cursor
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
    focusable = false,
    close_events = { "BufHidden", "InsertLeave" },
    -- Place the window below the cursor
    -- row = 1 will move it below, row = -1 will move it above
    position = { col = 0, row = 1 },
  }
)

-- Toggle LSP signature help manually with this mapping
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

-- Configure diagnostics to display below the cursor
vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    position = { col = 0, row = 1 },  -- Below the cursor
  },
})

-- Force all floating windows to open below the cursor
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.focusable = false
  opts.position = { col = 0, row = 1 }  -- Below the cursor
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
