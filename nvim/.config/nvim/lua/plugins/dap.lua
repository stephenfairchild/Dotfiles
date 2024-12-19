return {
	-- nvim-dap: Debug Adapter Protocol implementation
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{
				{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
			},
			{
				{
					"mxsdev/nvim-dap-vscode-js",
					dependencies = { "mfussenegger/nvim-dap" },
				},
			},
			{
				"microsoft/vscode-js-debug",
				version = "1.78.0",
				build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.set_log_level("TRACE")

			local dapvscode = require("dap-vscode-js")
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").set_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end)

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
			dapui.setup()

			dapvscode.setup({
				node_path = os.getenv("HOME") .. "/.nvm/versions/node/v18.19.1/bin/node",
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			})
			dap.configurations["javascript"] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = vim.fn.expand("%:p"),
					cwd = vim.fn.getcwd(),
					skipFiles = { "<node_internals>/**", "node_modules/**" },
					args = { "${file}" },
					sourceMaps = true,
					protocol = "inspector",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Run Jest test suite",
					cwd = vim.fn.getcwd(),
					runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
					runtimeExecutable = "node",
					args = { "${file}", "--coverage", "false" },
					rootPath = "${workspaceFolder}",
					sourceMaps = true,
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					skipFiles = { "<node_internals>/**", "node_modules/**" },
				},
				{
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					name = "Attach debugger to existing `node --inspect` process",
					sourceMaps = true,
					program = "${file}",
					cwd = "${workspaceFolder}",
					skipFiles = { "<node_internals>/**", "node_modules/**" },
				},
			}
		end,
	},

	-- Mason integration to manage the debugger
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- Update registries
		lazy = true,
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason integration for nvim-dap
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = true,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup()
		end,
	},
}
