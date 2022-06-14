#!/bin/sh

brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "Homebrew is installed, nothing to do"
else
  echo "Homebrew is not installed, installing"
  echo "This may take a while"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

packages=(
"git"
"node"
"tmux"
"neovim"
"zsh"
)

for i in "${packages[@]}"; do
  brew install $i
  echo "---------------------"
done

echo "installing RCM for dotfiles"
brew tap thoughtbot/formulae
brew install rcm
echo "------------------------"


localGit="/usr/local/bin/git"
if [ -f "$localGit" ]
then
  echo "git is all good"
else
  echo "git is not installed"
fi

if [ -d "$HOME/.dotfiles" ]
then
  echo "dir ~/.dotfiles exits"
  rm -rf $HOME/.dotfiles
else
  echo "no"
fi

echo "Cloning olivercodes's dotfiles insto .dotfiles"
git clone https://github.com/olivercodes/dotfiles.git ~/.dotfiles

cd $HOME/.dotfiles
git submodule update --init --recursive

cd $HOME
echo "running RCM's rcup command"
echo "This is symlink the rc files in .dofiles"
echo "with the rc files in $HOME"
echo "---------------------------------------------------------"
rcup

echo "setting zsh"
chsh -s $(which zsh)

echo "running osx defaults"
~./osx.sh
