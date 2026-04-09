return {
  {
    "mason-org/mason.nvim", -- URL 업데이트
    opts = {},
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = { "codelldb", "delve", "python" },
      automatic_installation = true,
    },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },

      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },

      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },

      {
        "<leader>dT",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- ✅ v2 방식: get_install_path() 대신 그냥 실행파일 이름 사용
      -- Mason이 PATH에 자동 추가해줌
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb", -- 경로 하드코딩 불필요
          args = { "--port", "${port}" },
        },
      }

      -- dap-ui 자동 열기/닫기
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      -- 키맵
      --    vim.keymap.set("n", "<F5>",       dap.continue)
      --    vim.keymap.set("n", "<F10>",      dap.step_over)
      --    vim.keymap.set("n", "<F11>",      dap.step_into)
      --    vim.keymap.set("n", "<F12>",      dap.step_out)
      --    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      --    vim.keymap.set("n", "<leader>du", dapui.toggle)
    end,

  },
  --  {
  --    "jay-babu/mason-nvim-dap.nvim",
  --    ---@type MasonNvimDapSettings
  --    opts = {
  --      -- This line is essential to making automatic installation work
  --      -- :exploding-brain
  --      handlers = {},
  --      automatic_installation = {
  --        -- These will be configured by separate plugins.
  --        exclude = {
  --          "delve",
  --          "python",
  --        },
  --      },
  --      -- DAP servers: Mason will be invoked to install these if necessary.
  --      ensure_installed = {},
  --    },
  --    dependencies = {
  --      "mfussenegger/nvim-dap",
  --      "mason-org/mason.nvim",
  --    },
  --  },
}
