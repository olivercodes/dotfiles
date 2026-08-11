-- Autocommands ported from the old init.vim.
--
-- Every group below uses `clear = true`. The old config had no augroups at all,
-- so each autocmd re-registered itself every time the file was sourced —
-- compounded by `autocmd BufWritePost ~/.vimrc source ~/.vimrc`, which pointed
-- at a file that did not exist anyway. Both problems are gone.

local augroup = function(name)
  return vim.api.nvim_create_augroup('custom-' .. name, { clear = true })
end

-- -------------------------------------
--  Restore cursor position
-- -------------------------------------

vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'restore-cursor',
  desc = 'Return to the last cursor position when reopening a file',
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- -------------------------------------
--  Filetype associations
-- -------------------------------------

-- Trimmed to what's still in use. Dropped from the old init.vim:
--   *.wsgi -> python, *.module/*.install -> php, *.sbt/*.sc -> scala
vim.filetype.add {
  extension = {
    schema = 'javascript',
  },
}

-- -------------------------------------
--  Per-filetype settings
-- -------------------------------------

vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'go-indent',
  pattern = 'go',
  desc = 'Go uses tabs, not the global 2-space default',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'rst-textwidth',
  pattern = 'rst',
  callback = function() vim.opt_local.textwidth = 80 end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'folds',
  pattern = { 'javascript', 'typescript', 'typescriptreact', 'json', 'html', 'css', 'scss' },
  desc = 'Treesitter folds, open by default',
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt_local.foldlevel = 99
  end,
})

-- The old config set tabstop/shiftwidth=2 per-extension for js/ts/yml/css/scss.
-- That is now the global default in options.lua, with guess-indent.nvim
-- adapting per file, so those autocmds are no longer needed.
