# Lorem Ipsum for Neovim

A simple source that adds "lorem ipsum" autocompletion to Neovim via [`blink.cmp`](https://github.com/Saghen/blink.cmp) or [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp).

https://github.com/user-attachments/assets/1be0482c-e86d-46a8-a01b-c90eebba9ca4

---

## 📦 Installation

### Using [blink.cmp](https://github.com/Saghen/blink.cmp)

Add `lorem-ipsum.nvim` as a dependency of `blink.cmp` and register its native source:

```lua
return {
  "saghen/blink.cmp",
  dependencies = {
    "dnnr1/lorem-ipsum.nvim", -- Add this line
  },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lorem_ipsum" },
      providers = {
        lorem_ipsum = {
          name = "Lorem Ipsum",
          module = "lorem_ipsum.blink",
        },
      },
    },
  },
}
```

This uses Blink's native source API and does not require `blink.compat`.

### Using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

Add `lorem-ipsum.nvim` as a dependency of `nvim-cmp`:

```lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "dnnr1/lorem-ipsum.nvim", -- Add this line
  },
  -- Your config continues...
}
```

Then, register the source in your cmp setup:

```lua
require("cmp").setup({
  -- Other configurations...
  sources = require("cmp").config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "lorem_ipsum" }, -- Add this line
  }),
})
```

## ✨ Usage

1. Enter insert mode and type `lorem`
2. Trigger completion using your configured key (e.g. `<C-Space>`)
3. Pick one of the available snippets:
   - `lorem ipsum (10 words)`
   - `lorem ipsum (50 words)`
   - `lorem ipsum (100 words)`

The selected option will insert a block of lorem ipsum text into your buffer.

---

## 🛠 Troubleshooting

If it's not working:

- ✅ Make sure `lorem-ipsum.nvim` is correctly added as a dependency of your completion plugin
- ✅ For Blink, ensure `lorem_ipsum` is listed in `sources.default` and configured in `sources.providers`
- ✅ For cmp, ensure `{ name = "lorem_ipsum" }` is listed in your cmp sources
- 🔄 Restart Neovim after making configuration changes

## License 📄

[MIT](LICENSE)
