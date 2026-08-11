-- Language support: Go, Terraform, TypeScript/JavaScript.
--
-- This replaces a pile of plugins from the old init.vim that all overlapped:
--   fatih/vim-go, deoplete-go (via the long-dead gocode binary), coc.nvim +
--   coc-angular, nvim-typescript (archived, and loaded from a ~/Github path
--   that didn't exist), pangloss/vim-javascript, othree/yajs.vim,
--   HerringtonDarkholme/yats.vim, cakebaker/scss-syntax.vim, hashivim/vim-terraform,
--   ALE and syntastic.
--
-- Syntax is now treesitter, diagnostics and navigation are native LSP, and
-- formatting is conform. No plugins needed here — only configuration.

-- -------------------------------------
--  Language servers
-- -------------------------------------

-- Install the binaries with `:Mason` (or have them on PATH). kickstart wires up
-- mason + mason-lspconfig; these calls use Neovim's native LSP config API so
-- they work either way, without having to reach into kickstart's local
-- `servers` table.
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      -- Replaces the g:go_highlight_* block from the old config, which only
      -- ever affected vim-go's regex highlighting.
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

vim.lsp.enable { 'gopls', 'terraformls', 'ts_ls' }

-- -------------------------------------
--  Treesitter parsers
-- -------------------------------------

-- kickstart installs parsers on demand when a filetype is opened, so this is
-- only a hint of what to expect. Nothing to configure.

-- -------------------------------------
--  Formatters
-- -------------------------------------

-- conform is already set up by kickstart; extend its table rather than calling
-- setup() a second time, which would clobber the existing config.
local conform = require 'conform'

conform.formatters_by_ft.go = { 'goimports', 'gofmt' }
conform.formatters_by_ft.terraform = { 'terraform_fmt' }
conform.formatters_by_ft.hcl = { 'terraform_fmt' }
conform.formatters_by_ft.zsh = { 'shfmt' }
conform.formatters_by_ft.sh = { 'shfmt' }

for _, ft in ipairs { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'css', 'scss', 'html' } do
  conform.formatters_by_ft[ft] = { 'prettierd', 'prettier', stop_after_first = true }
end

-- `let g:neoformat_zsh_shfmt = { 'args': ['-i ' . shiftwidth()] }` from the old config.
conform.formatters.shfmt = {
  prepend_args = function(_, ctx) return { '-i', tostring(ctx.shiftwidth) } end,
}

-- -------------------------------------
--  Format on save
-- -------------------------------------

-- Restores `g:go_fmt_command = "goimports"` (goimports ran on every Go write)
-- and extends it to terraform. kickstart's own format_on_save hook returns nil
-- for everything, so this adds the behavior without editing init.lua.
--
-- Add filetypes here to opt them in; everything else still formats on demand
-- with <leader>f.
local format_on_save_filetypes = {
  go = true,
  terraform = true,
  hcl = true,
}

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('custom-format-on-save', { clear = true }),
  callback = function(event)
    if not format_on_save_filetypes[vim.bo[event.buf].filetype] then return end
    conform.format { bufnr = event.buf, timeout_ms = 1000, lsp_format = 'fallback' }
  end,
})
