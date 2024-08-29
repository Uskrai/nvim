local cmp = require 'cmp'

if cmp == nil then
  return
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  experimental = {
    ghost_text = false
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- ['<CR>'] = cmp.mapping(function(fallback)
    --   -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/13
    --   if not cmp.visible() or not cmp.get_selected_entry() or
    --       cmp.get_selected_entry().source.name == 'nvim_lsp_signature_help' then
    --     fallback()
    --   else
    --     cmp.mapping.confirm {
    --       behavior = cmp.ConfirmBehavior.Replace,
    --       select = true,
    --     } (fallback)
    --   end
    -- end)
    -- ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'dotenv' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})


local compare = require('cmp.config.compare')
local types = require('cmp.types')

cmp.setup.filetype('rust', {
  sorting = {
    priority_weight = 2,
    comparators = {

      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      compare.locality,
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
        local kind2 = entry2:get_kind()
        kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2

        if kind1 ~= kind2 then
          if kind1 == types.lsp.CompletionItemKind.Snippet then
            return false
          end
          if kind2 == types.lsp.CompletionItemKind.Snippet then
            return true
          end
          local diff = kind1 - kind2
          if diff < 0 then
            return true
          elseif diff > 0 then
            return false
          end
        end
      end,
      compare.sort_text,
      compare.length,
      compare.order,
    }
  }

})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
