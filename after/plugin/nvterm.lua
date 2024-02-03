require("nvterm").setup {}

local terminal = require("nvterm.terminal")

local mappings = {
	{ { "n", "t" }, "<A-t>", function() terminal.toggle("horizontal") end }
}

local opts = {
	noremap = true,
	silent = true
}

for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
end
