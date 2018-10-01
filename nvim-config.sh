# Source init.vim to the config folder...

DIR="$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" )"
echo "$DIR"
USER_HOME=$(eval echo ~$user)
cd $DIR
ln -fsv $DIR"/".dotfiles"/"init.vim $USER_HOME"/".config/nvim/
