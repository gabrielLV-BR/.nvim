local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)
	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)
	bufmap("K", vim.lsp.buf.hover)

	local builtin = require "telescope.builtin"

	bufmap("gr", builtin.lsp_references)
	bufmap("<leader>s", builtin.lsp_document_symbols)
	bufmap("<leader>S", builtin.lsp_dynamic_workspace_symbols)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format{}
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- setup signature

require("lsp_signature").setup {}

-- setup lsps

local lspconfig = require "lspconfig"

require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities
		}
	end,

	-- explicit ones
	["gopls"] = function()
		lspconfig.gopls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
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
	end,

	["rust_analyzer"] = function()
		lspconfig.rust_analyzer.setup {
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = false;
					}
				}
			}
		}
	end,

	["clangd"] = function()
		lspconfig.clangd.setup {}
	end,

	["lua_ls"] = function()
		require("neodev").setup()
		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			}
		}
	end
})

-- setup outside mason since it's already installed

lspconfig.glsl_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
