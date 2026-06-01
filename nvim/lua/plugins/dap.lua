return {
  {
    "mfussenegger/nvim-dap",
    -- 'opts' aqui serve apenas para injetar os gatilhos visuais no Extra que já está ativo
    opts = function()
      local dap, dapui = require("dap"), require("dapui")

      -- Abre a interface gráfica do VS Code ao iniciar o debug
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- Fecha a interface ao encerrar
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
