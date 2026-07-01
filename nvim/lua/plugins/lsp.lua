return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {

      bashls = {
        capabilities = capabilities,
        settings = {},
      },

      lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = {
              library = {
                vim.fn.expand("/usr/share/hypr/stubs/hl.meta.lua"),
              },
              checkThirdParty = false,
            },
          },
        },
      },
      qmlls = {
        cmd = { "qmlls", "-E" },
        filetypes = { "qml", "qmljs" },
        settings = {
          qmlls = {
            importPaths = {
              "/usr/lib/qt6/qml",
            },
          },
        },
      },
    },
  },
}
