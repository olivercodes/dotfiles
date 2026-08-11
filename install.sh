#!/bin/sh

echo "first, we will cleanup nvm and nvim folders"
echo "------------------------"

echo "clean nvm"
if [ -d "$HOME/.nvm" ]
then
  echo ".nvm folder exists, cleaning"
  rm -rf "$HOME/.nvm"
else
  echo ".nvm clean"
fi
echo "------------------------"

echo "create clean nvim setup"
if [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]
then
  echo "nvim folder already present, removing"
  rm -rf "$HOME/.config/nvim"
fi
# nvim plugin + state dirs, so a reinstall isn't half the old config
rm -rf "$HOME/.local/share/nvim" "$HOME/.local/state/nvim"
echo "------------------------"

echo "create clean zsh setup"
if [ -d "$HOME/.oh-my-zsh" ]
then
  echo "oh-my-zsh folder already present, removing"
  rm -rf "$HOME/.oh-my-zsh"
fi
echo "------------------------"

echo "now, we will do brew things"
# Apple Silicon installs to /opt/homebrew, Intel to /usr/local. The old script
# only ever checked /usr/local/bin/brew, so it reinstalled brew on every M-series mac.
if command -v brew >/dev/null 2>&1
then
  echo "Homebrew is installed, nothing to do"
else
  echo "Homebrew is not installed, installing"
  echo "This may take a while"
  # The old `ruby -e "$(curl .../install)"` installer was retired in 2019.
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -x /opt/homebrew/bin/brew ]
  then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]
  then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# neovim must be >= 0.12 — the Lua config uses vim.pack, Neovim's built-in
# plugin manager. brew's `neovim` formula is current enough.
packages="git node tmux neovim zsh pure"

for i in $packages; do
  brew install "$i"
  echo "---------------------"
done

echo "installing Ghostty"
brew install --cask ghostty
echo "---------------------"

# Nerd Font build of Source Code Pro. Replaces the powerline/fonts submodule,
# which is archived upstream and lacks the glyphs nvim-web-devicons and
# mini.statusline expect. Referenced by font-family in ghostty/config.
echo "installing SauceCodePro Nerd Font"
brew install --cask font-sauce-code-pro-nerd-font
echo "---------------------"

echo "installing RCM for dotfiles"
brew tap thoughtbot/formulae
brew install rcm
echo "------------------------"

if [ -d "$HOME/.dotfiles" ]
then
  echo "dir ~/.dotfiles exists, removing"
  rm -rf "$HOME/.dotfiles"
fi

echo "Cloning olivercodes's dotfiles into .dotfiles"
git clone https://github.com/olivercodes/dotfiles.git "$HOME/.dotfiles"
echo "---------------------------------------------------------"

echo "init dotfile submodules"
cd "$HOME/.dotfiles" || exit 1
git submodule update --init --recursive
echo "---------------------------------------------------------"

cd "$HOME" || exit 1
echo "running RCM's rcup command"
echo "This will symlink the rc files in .dotfiles"
echo "with the rc files in $HOME"
echo "(nvim/ and ghostty/ are excluded in .rcrc and linked into ~/.config below)"
echo "---------------------------------------------------------"
rcup

echo "setting zsh"
chsh -s "$(which zsh)"

# echo "running osx defaults"
# ~/.osx.sh
# echo "---------------------------------------------------------"

echo "linking XDG config dirs"
mkdir -p "$HOME/.config"
# Neovim is a Lua config directory now, not a single init.vim.
ln -sfn "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
ln -sfn "$HOME/.dotfiles/ghostty" "$HOME/.config/ghostty"
echo "---------------------------------------------------------"

echo "installing node version manager"
"$HOME/.dotfiles/nvm/install.sh"
echo "---------------------------------------------------------"

echo "installing tmux plugin manager"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]
then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
echo "---------------------------------------------------------"

echo "---------------------------------------------------------"
echo "All done!"
echo ""
echo "Remaining manual steps:"
echo "  1. Open Ghostty. It reads ~/.config/ghostty/config automatically;"
echo "     cmd+shift+, reloads it in place."
echo "  2. Launch nvim. vim.pack downloads plugins on first start."
echo "  3. In nvim run :Mason and install gopls, terraform-ls, typescript-language-server."
echo "  4. In tmux hit prefix + I to install the tpm plugins."
echo "Cheers"
echo "---------------------------------------------------------"

exit 0
