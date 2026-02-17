return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local home = os.getenv("HOME")
    local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
    local lombok_jar = jdtls_path .. "/lombok.jar"

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.level=ALL",

        -- IMPORTANT: ✨ Lombok + annotation processing
        "-javaagent:" .. lombok_jar,
        "-Xbootclasspath/a:" .. lombok_jar,

        "-jar",
        vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        jdtls_path .. "/config_linux", -- or config_mac / config_win
        "-data",
        workspace_dir,
      },

      settings = {
        java = {
          format = { enabled = true },

          -- ✨ Enable annotation processing
          compiler = {
            annotationProcessing = {
              enabled = true,
            },
          },

          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk", -- update accordingly
              },
            },
          },
        },
      },

      init_options = {
        bundles = {},
      },
    }

    -- Auto-start JDTLS for Java files
    local jdtls = require("jdtls")
    jdtls.start_or_attach(config)
  end,
}

