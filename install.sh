#!/bin/zsh

echo -e "\n====== bx2's dotfiles setup wizzard ======\n"

# setup the os
echo -n "Setup OS (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  # install macos dev tools
  xcode-select --install 
  [[ -a ~/.hushlogin ]] && touch ~/.hushlogin
  defaults write -g ApplePressAndHoldEnabled -bool false
  chsh -s /bin/zsh
fi

# install all the packages
echo -n "Install all base packages (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  # install brew
  if which brew > /dev/null; then
    echo "Homebrew installed.. Skipping.."
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # configure brew
  brew doctor
  brew update
  brew upgrade
  brew tap caskroom/cask
  brew tap caskroom/fonts

  # unix tools
  brew install zsh
  brew install nvim
  brew install git
  brew install curl
  brew install wget
  brew install ngrep
  brew install nmap
  brew install nasm
  brew install ack

  # dev tools
  brew install automake
  brew install python
  brew install python@2
  brew install jq

  # golang
  brew install golang
  brew install delve

  # install golang tools
  go get -u golang.org/x/tools/cmd/gopls
  go get -u golang.org/x/tools/cmd/godoc
  go get -u golang.org/x/tools/cmd/guru
  go get -u golang.org/x/tools/cmd/goimports
  go get -u golang.org/x/tools/cmd/gorename
  go get -u golang.org/x/tools/cmd/cover
  go get -u golang.org/x/tools/cmd/present

  # gui tools
  brew install koekeishiya/formulae/skhd
  brew install --HEAD chunkwm
  brew cask install kitty
  brew cask install skim

  # python tools
  pip install virtualenvwrapper
  pip2 install neovim
  pip3 install neovim

# install prettier
# install black
# install checkmake
fi

# symlink config files
echo -n "Install/re-install symlinks (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  sudo rm -rf ~/.vim* > /dev/null 2>&1
  sudo rm -rf ~/.zshrc > /dev/null 2>&1
  sudo rm -rf ~/.ctags > /dev/null 2>&1
  sudo rm -rf ~/.git* > /dev/null 2>&1
  sudo rm -rf ~/.config > /dev/null 2>&1

  BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  ln -sf $BASE_DIR/zshrc ~/.zshrc
  ln -sf $BASE_DIR/git/gitconfig ~/.gitconfig
  ln -sf $BASE_DIR/git/gitmessage ~/.gitmessage
  ln -sf $BASE_DIR/git/gitignore ~/.gitignore
  ln -sf $BASE_DIR/ctags/ctags ~/.ctags
  ln -sf $BASE_DIR/config ~/.config
fi

echo -e "\n====== All Done!! ======\n"
echo

