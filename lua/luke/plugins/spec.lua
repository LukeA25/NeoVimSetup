return {
  -- Theme (set colorscheme once here)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- show icons in the sign column
      keywords = {
        TODO = { icon = " ", color = "info" },
        FIX  = { icon = " ", color = "error" },
        NOTE = { icon = " ", color = "hint" },
      },
    },
  },

  -- File explorer (show gitignored but dimmed)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        git = { enable = true },
      })
    end,
  },

  -- Terminal toggler
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = 12,
        open_mapping = [[<C-\>]],
        shade_terminals = true,
        direction = "horizontal",
        start_in_insert = true,
        persist_size = true,
      }
    end,
  },

  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Gitsigns
  { "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        attach_to_untracked = false,
        show_untracked = false,
      })
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true, additional_vim_regex_highlighting = false },
      }
    end,
  },

  -- Autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "",
          globalstatus = false,
        },
      })
    end,
  },

  -- LSP & Autocomplete (clangd + cmp)
  { "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")

      local on_attach = function(_, bufnr)
        local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true }) end
        -- Smart K: params/overloads if in call, otherwise hover docs/types
        map("K", function()
          local ok = pcall(vim.lsp.buf.signature_help)
          if not ok then vim.lsp.buf.hover() end
        end)
        map("gd", vim.lsp.buf.definition)
      end

      lsp.clangd.setup({
        on_attach = on_attach,
        cmd = { "clangd", "--completion-style=detailed", "--header-insertion=never" },
      })
    end
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.clang_check,
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" } }),
      })
    end,
  },

  -- CSS color preview
  { "norcalli/nvim-colorizer.lua", config = true },

  -- Markdown preview
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" }
}
