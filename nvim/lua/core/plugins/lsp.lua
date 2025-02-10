local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- Setup completion
cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
	formatting = {
    format = function(entry, vim_item)
      -- Prevent C++ headers in C files
      if vim.bo.filetype == "c" and entry.completion_item.detail == "cstdlib" then
        return nil
      end
      return vim_item
    end,
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

-- Diagnostics configuration
vim.diagnostic.config({
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
