#!/bin/sh
set -e

# move to script directory so all relative paths work
cd "$(dirname "$0" 2>/dev/null)"

# install common stuff
if command -v apt-get > /dev/null; then
  sudo apt-get -y update
  sudo apt-get -y install lsb-release cabextract p7zip-full xz-utils rpm mc htop bash-completion exuberant-ctags \
    elinks curl wget coreutils telnet nmap net-tools dnsutils psmisc fzf vim zsh git
elif command -v yum > /dev/null; then
  sudo yum -y install redhat-lsb-core cabextract p7zip p7zip-plugins unrar xz mc htop bash-completion ctags \
    elinks curl wget coreutils telnet nmap net-tools bind-utils rpm-build vim zsh git
else
  echo "Unsupported distribution!"
  exit 1
fi

# install oh-my-zsh, not using its regular install script
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# install zsh-syntax-highlighting
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
  git -C ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull
fi

# install zsh-autosuggestions
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
  git -C ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull
fi


# backup and remove old vim directories
test -d ~/.vim && mv ~/.vim ~/.vim.bak
test -f ~/.vimrc && mv ~/.vimrc ~/.vimrc.bak
rm -rf ~/.vim_runtime

# install our config files
touch ~/.hushlogin
for conf in .zshrc .bashrc .inputrc .nanorc .vimrc; do
  test -f ~/$conf && mv ~/$conf ~/$conf.bak
  ln -sf "$(pwd)"/$conf ~/$conf
done

# change the shell if is not already "zsh"
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
  ZSH=$(grep zsh /etc/shells | tail -1)
  sudo chsh -s "$ZSH" "$USER"
fi

