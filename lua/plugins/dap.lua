return {
	'mfussenegger/nvim-dap',
	-- config partially taken from
	-- https://www.reddit.com/r/neovim/comments/q2hxkg/anyone_using_nvimdap_with_codelldb/
	-- and https://www.reddit.com/r/neovim/comments/txfy9z/codelldb_configuration_for_nvimdap/
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		dap.adapters.lldb = {
			type = 'executable',
			command = '/usr/lib/llvm-18/bin/lldb-dap',
			name = 'lldb',
		}

		dap.adapters.gdb = {
			type = 'executable',
			command = '/usr/bin/gdb',
			args = { '-i', 'dap' },
			name = 'gdb',
		}

		-- dap.adapters.cppdbg = {
		-- 	type = 'executable',
		-- 	command = os.getenv 'HOME'
		-- 		.. '/.vscode/extensions/ms-vscode.cpptools-1.20.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
		-- 	name = 'cppdbg',
		-- 	attach = {
		-- 		pidProperty = 'processId',
		-- 		pidSelect = 'ask',
		-- 	},
		-- }

		dap.configurations.cpp = {
			{
				name = 'Launch',
				type = 'lldb',
				stopOnEntry = false,
				request = 'launch',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				args = {},

				--
				-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
				--
				--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
				--
				-- Otherwise you might get the following error:
				--
				--    Error on launch: Failed to attach to the target process
				--
				-- But you should be aware of the implications:
				-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
				-- runInTerminal = false,
			},
			{
				name = 'Launch',
				type = 'gdb',
				stopOnEntry = false,
				request = 'launch',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
			},
			-- {
			-- 	name = 'Launch',
			-- 	type = 'cppdbg',
			-- 	stopOnEntry = false,
			-- 	request = 'launch',
			-- 	program = function()
			-- 		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			-- 	end,
			-- 	cwd = '${workspaceFolder}',
			-- },
		}

		dap.configurations.c = dap.configurations.cpp

        require('nvim-dap-virtual-text').setup()
		require('dap.ext.vscode').load_launchjs()

		dapui.setup()

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

		vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
		vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

		vim.keymap.set('n', '<F5>', require('dap').continue)
		vim.keymap.set('n', '<F10>', require('dap').step_over)
		vim.keymap.set('n', '<F11>', require('dap').step_into)
		vim.keymap.set('n', '<F12>', require('dap').step_out)
		vim.keymap.set('n', '<leader>b', require('dap').toggle_breakpoint)
	end,
}
