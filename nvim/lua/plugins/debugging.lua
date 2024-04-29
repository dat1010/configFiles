return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		require("dapui").setup()

		local dap = require("dap")
		local dapui = require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<F5>", dap.continue, {})

		-- elixir debuggin currently broken
		dap.adapters.mix_task = {
			type = "executable",
			command = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/elixir-ls/debug_adapter.sh"),
			arg = {},
		}

		dap.configurations.elixir = {
			{
				type = "mix_task",
				name = "phx.server",
				request = "launch",
				task = "phx.server",
				projectDir = vim.fn.expand("$HOME/Documents/programming/elixir/davidtannerjr/"),
			},
		}
	end,
}
