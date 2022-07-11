#!/bin/zsh

echo "first, we will cleanup nvm and nvim folders"
echo "------------------------"

echo "clean nvm"
if [ -d "$HOME/.nvm" ] # && clean_install = true
then
  echo ".nvm folder exists, cleaning"
  sudo rm -rf $HOME/.nvm
else
  echo ".nvm clean"
fi
echo "------------------------"

echo "create clean nvim setup"
# TODO - add an if
if [ -d "$HOME/.config/nvim" ] # && clean_install = true
then
  echo "nvim folder already present, removing"
  rm -rf $HOME/.config/nvim
fi
echo "------------------------"

echo "create clean zsh setup"
# TODO - add an if
if [ -d "$HOME/.oh-my-zsh" ]
then
  echo "nvim folder already present, removing"
  rm -rf $HOME/.oh-my-zsh
fi
echo "------------------------"

echo "now, we will do brew things"
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
"pure"
)

for i in "${packages[@]}"; do
  brew install $i
  echo "---------------------"
done

echo "installing RCM for dotfiles"
brew tap thoughtbot/formulae
brew install rcm
echo "------------------------"


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
echo "---------------------------------------------------------"

echo "init dotfile submodules"
cd $HOME/.dotfiles
git submodule update --init --recursive
echo "---------------------------------------------------------"

cd $HOME
echo "running RCM's rcup command"
echo "This is symlink the rc files in .dofiles"
echo "with the rc files in $HOME"
echo "---------------------------------------------------------"
rcup


echo "setting zsh"
chsh -s $(which zsh)

# echo "running osx defaults"
# ~/.osx.sh
# echo "---------------------------------------------------------"


echo "linking init.vim for neovim"
mkdir -p $HOME/.config/nvim
ln -s $HOME/.init.vim ~/.config/nvim/init.vim
echo "---------------------------------------------------------"


echo "installing node version manager"
~/.dotfiles/nvm/install.sh
echo "---------------------------------------------------------"

echo "installing powerline font"
~/.dotfiles/fonts/install.sh
echo "---------------------------------------------------------"

# export KEEP_ZSHRC=yes
# echo "setup oh-my-zsh"
# ~/.dotfiles/ohmyzsh/tools/install.sh

echo "---------------------------------------------------------"
echo "All done!"
echo "and change your terminal font to source code pro"
echo "Cheers"
echo "---------------------------------------------------------"

exit 0
