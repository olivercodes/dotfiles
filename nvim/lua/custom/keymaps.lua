-- Keymaps ported from the old init.vim.
-- Leader is Space, which kickstart already sets at the top of init.lua.

local map = vim.keymap.set

-- -------------------------------------
--  Escape
-- -------------------------------------

-- Matches `bindkey -M viins 'jk' vi-cmd-mode` in zshrc, so the same two keys
-- leave insert mode in the editor and on the shell command line.
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- -------------------------------------
--  Disabled keys
-- -------------------------------------

map('n', 'Q', '<Nop>', { desc = 'Disabled (Ex mode)' })

-- Guard against spazzing on q and starting a macro recording.
-- The old config used bare `map`, which also clobbered visual and
-- operator-pending mode; scoped to normal/visual here. Note this still costs
-- one `timeoutlen` of delay on every `q` press before a real macro starts.
map({ 'n', 'x' }, 'qq', '<Nop>', { desc = 'Disabled (accidental macro record)' })

-- NOTE: the old init.vim mapped <Space> itself to :nohlsearch while ALSO using
-- Space as the leader. That made every single leader mapping wait out
-- timeoutlen before firing. Dropped — kickstart binds <Esc> to :nohlsearch,
-- which does the same job with no conflict.

-- -------------------------------------
--  Editing
-- -------------------------------------

-- Keep the selection after indenting so you can indent repeatedly.
map('x', '<', '<gv', { desc = 'Indent left and reselect' })
map('x', '>', '>gv', { desc = 'Indent right and reselect' })

-- -------------------------------------
--  Tabs
-- -------------------------------------

map('n', 'gwN', '<cmd>tabnew<cr>', { desc = 'Tab: new' })
map('n', 'gwC', '<cmd>tabclose<cr>', { desc = 'Tab: close' })
map('n', 'gwT', '<cmd>wincmd T<cr>', { desc = 'Tab: move window to new tab' })

-- -------------------------------------
--  Fat-finger commands
-- -------------------------------------

vim.api.nvim_create_user_command('W', 'w', { desc = ':w' })
vim.api.nvim_create_user_command('Q', 'q', { desc = ':q' })

-- -------------------------------------
--  Telescope (replaces ctrlp / vim-clap)
-- -------------------------------------

-- kickstart already binds <leader>sf, <leader>sg, <leader>sh and friends.
-- These are the old muscle-memory aliases from the vim-clap setup.
map('n', '<c-p>', '<cmd>Telescope find_files<cr>', { desc = 'Search files (was :Clap files)' })
map('n', '<leader>a', '<cmd>Telescope live_grep<cr>', { desc = 'Search by grep (was :Clap grep)' })

-- The old <leader>h (:Clap help_tags) is deliberately NOT rebound: kickstart
-- registers <leader>h as the which-key group for git hunks. Use <leader>sh.

-- -------------------------------------
--  Formatting (replaces Neoformat)
-- -------------------------------------

-- The old <leader>f was defined twice — once for :Neoformat (a plugin that was
-- never actually installed) and once for coc-format-selected. conform.nvim now
-- owns it, and also runs on save via kickstart's format_on_save.
map({ 'n', 'x' }, '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer or selection' })

-- -------------------------------------
--  LSP (replaces coc.nvim)
-- -------------------------------------

-- Neovim 0.11+ ships defaults for grn/gra/grr/gri and kickstart adds its own
-- LspAttach maps. These restore the coc-era bindings on top of those.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-keymaps', { clear = true }),
  callback = function(event)
    local function lmap(keys, fn, desc, mode)
      map(mode or 'n', keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- These shadow vim builtins (`gd` local declaration, `gi` last-insert-position,
    -- `U` undo-line), same as the old coc.nvim setup did.
    lmap('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
    lmap('gy', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')
    lmap('gi', require('telescope.builtin').lsp_implementations, 'Goto implementation')
    lmap('U', vim.lsp.buf.hover, 'Hover documentation')
    lmap('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

    -- NOTE: the old config's `gr` -> references is deliberately not restored.
    -- Neovim 0.11+ and kickstart bind the whole grr/gri/grd/grn/gra/grt family,
    -- so mapping bare `gr` would make every one of them sit through a full
    -- `timeoutlen` before firing. Use `grr` for references — it's one more key
    -- and it keeps the rest of the family responsive.
  end,
})

-- Diagnostic navigation. Neovim 0.11+ binds ]d / [d natively; these are the
-- coc-era aliases. Note [c / ]c are also vim's built-in diff-hunk motions,
-- so inside :diffthis they will no longer jump between changes.
map('n', '[c', function() vim.diagnostic.jump { count = -1, float = true } end, { desc = 'Previous diagnostic' })
map('n', ']c', function() vim.diagnostic.jump { count = 1, float = true } end, { desc = 'Next diagnostic' })
map('n', '<leader>d', '<cmd>Telescope diagnostics<cr>', { desc = 'Search diagnostics (was CocList diagnostics)' })
