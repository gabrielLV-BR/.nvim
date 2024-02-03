require("dap-go").setup {}

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local mappings = {
	{ "n", "<leader>db", "<cmd> DapToggleBreakpoint<CR>" },
	{ "n", "<leader>dr", "<cmd> DapContinue<CR>" },
}

local opts = {
	noremap = true,
}

for _,mapping in ipairs(mappings) do
	vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
end
