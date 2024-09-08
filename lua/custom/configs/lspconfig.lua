local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.gopls.setup {
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotempl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- -- Add SQL language server configuration
-- lspconfig.sqls.setup {
--   on_attach = function(client, bufnr)
--     if client.server_capabilities.documentFormattingProvider then
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = bufnr })
--         end,
--       })
--     end
--     on_attach(client, bufnr)
--   end,
--   capabilities = capabilities,
--   cmd = { "sqls" },
--   filetypes = { "sql" },
--   settings = {
--     sqls = {
--       connections = {
--         {
--           driver = "postgresql",
--           -- Define your connection settings here
--           -- For example, for PostgreSQL:
--           dataSourceName = "host=localhost port=5432 user=tents dbname=authconnect sslmode=disable"
--           -- Or leave it blank if you will set up connections in SQLS configuration
--         },
--       },
--     },
--   },
-- }

lspconfig.sqlls.setup {
  on_attach = function(client, bufnr)
    -- Custom on_attach function
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
    -- Call the general on_attach function
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql", "psql" },
  root_dir = lspconfig.util.find_git_ancestor,  -- or another suitable root detection
}
