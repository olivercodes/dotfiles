# dotfiles

zsh + tmux + Neovim + Ghostty, symlinked with [rcm](https://github.com/thoughtbot/rcm).

### Installation

WARNING - this will wipe your local `~/.dotfiles`, `~/.config/nvim`, `~/.local/share/nvim`, `~/.nvm`, and `~/.oh-my-zsh` folders.

```
curl -fsSL https://raw.githubusercontent.com/olivercodes/dotfiles/main/install.sh | sh
```

(The old install one-liner pointed at `cdn.rawgit.com`, which was shut down in 2019.)

### Layout

| Path | Links to | What it is |
|---|---|---|
| `zshrc`, `zshenv` | `~/.zshrc`, `~/.zshenv` | shell, via `rcup` |
| `tmux.conf`, `tmuxline.conf` | `~/.tmux.conf`, `~/.tmuxline.conf` | tmux, via `rcup` |
| `gitconfig`, `npmrc` | `~/.gitconfig`, `~/.npmrc` | via `rcup` |
| `ghostty/config` | `~/.config/ghostty/config` | terminal, linked by `install.sh` |
| `nvim/` | `~/.config/nvim` | editor, linked by `install.sh` |

`nvim/` and `ghostty/` are XDG directories rather than dotfiles, so they're listed
in `EXCLUDES` in `.rcrc` and symlinked explicitly by `install.sh`.

### Ghostty

Config lives in `ghostty/config`. `cmd+,` opens it, `cmd+shift+,` reloads it in place.
Run `ghostty +show-config --default --docs` for the full option reference.

The theme is **Oceanic Next**, matching the Neovim colorscheme so the terminal
and editor backgrounds are the same color. The font is **SauceCodePro Nerd Font**
(the Nerd Fonts build of Source Code Pro), installed by `install.sh` via cask —
it replaces the archived `powerline/fonts` submodule and carries the glyphs that
`nvim-web-devicons` and `mini.statusline` need.

`shell-integration-features` includes `ssh-terminfo` because Ghostty sets
`TERM=xterm-ghostty`, which no remote host has terminfo for; without it, ssh
sessions render garbage.

tmux needs `default-terminal "tmux-256color"` plus a `terminal-overrides` RGB
entry to pass truecolor through — the old `screen-256color` silently downgraded
Neovim to 256 colors.

### Neovim

Requires **Neovim >= 0.12**. Lua config built on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), which now uses
`vim.pack` (Neovim's built-in plugin manager) rather than lazy.nvim.

```
nvim/
├── init.lua                  # stock kickstart, two-line diff
└── lua/custom/
    ├── init.lua              # load order
    ├── options.lua           # set-options from the old init.vim
    ├── keymaps.lua           # jk, Space leader, gwN/gwC/gwT, W/Q, LSP aliases
    ├── autocmds.lua          # restore cursor, filetypes, folds
    └── plugins/
        ├── colors.lua        # oceanic-next
        ├── git.lua           # fugitive
        ├── tpope.lua         # unimpaired, eunuch, repeat, obsession
        ├── tree.lua          # nvim-tree
        ├── editing.lua       # indent-blankline, mini.splitjoin
        ├── gnupg.lua         # vim-gnupg
        └── langs.lua         # gopls/terraformls/ts_ls, conform, format-on-save
```

`init.lua` is upstream kickstart with exactly two changes, so it can be re-synced
by diffing against upstream:

1. `vim.g.have_nerd_font = true`
2. the commented-out `require 'custom.plugins'` became `require 'custom'`

Plugin management:

```
:lua vim.pack.update()                      -- update everything
:lua vim.pack.update(nil, { offline = true })  -- show pending, no network
:Mason                                      -- install LSP servers / formatters
```

LSP servers to install via `:Mason`: `gopls`, `terraform-ls`, `typescript-language-server`.

#### What replaced what

| Old (init.vim) | Now |
|---|---|
| dein.vim | `vim.pack` |
| coc.nvim, deoplete, neocomplete | native LSP + blink.cmp |
| ALE, syntastic | LSP diagnostics |
| ctrlp, vim-clap | telescope |
| vim-gitgutter | gitsigns |
| vim-airline | mini.statusline |
| vim-surround | mini.surround |
| targets.vim, vim-textobj-* | mini.ai |
| vim-commentary | built-in `gc` |
| splitjoin.vim | mini.splitjoin |
| Neoformat | conform.nvim |
| vim-go, deoplete-go, gocode | gopls + conform (goimports on save) |
| vim-javascript, yajs, yats, scss-syntax | treesitter |
| vim-terraform | terraform-ls + conform |
| vim-indent-guides | indent-blankline |
| matchit | ships with Neovim |

Dropped on purpose: `coc-angular`, `nvim-typescript` (archived, and loaded from a
`~/Github` path that never existed), the Scala/PHP/wsgi filetype associations, the
ionic-specific syntastic html-tidy rules, and `tmuxline.vim` (it still emits
pre-tmux-2.9 statusline syntax).

#### Keymaps worth remembering

Leader is `<Space>`.

| Key | Action |
|---|---|
| `jk` | exit insert mode (matches `bindkey -M viins 'jk'` in zsh) |
| `<c-p>` | find files |
| `<leader>a` | live grep |
| `<leader>e` / `<leader>E` | toggle / reveal in file tree |
| `<leader>f` | format buffer or selection |
| `<leader>gs` `<leader>gb` `<leader>gd` `<leader>gc` | fugitive status / blame / diff / commit |
| `gd` `gy` `gi` `U` `<leader>rn` | LSP definition / type / impl / hover / rename |
| `grr` | LSP references (not `gr` — see below) |
| `[c` `]c` | previous / next diagnostic |
| `gwN` `gwC` `gwT` | tab new / close / move window to tab |

Two of the old bindings were intentionally not restored, both for the same
reason the old `<Space>`-as-leader-and-`:nohlsearch` setup was slow — bare keys
that are also prefixes of other mappings force a `timeoutlen` wait:

- `gr` (references) would stall the whole native `grr`/`gri`/`grd`/`grn`/`gra`/`grt`
  family. Use `grr`.
- `<leader>h` (help) collides with kickstart's which-key group for git hunks.
  Use `<leader>sh`.

kickstart's own `<leader>s*` search maps and `grn`/`gra`/`grr` LSP defaults are
all still there too — `<leader>` alone pops up which-key if you forget.
