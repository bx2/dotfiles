#!/bin/zsh

echo -e "\n====== bx2's dotfiles setup wizzard ======\n"

# setup the os
echo -n "Setup OS (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  # install macos dev tools
  xcode-select --install
  [[ -a ~/.hushlogin ]] && touch ~/.hushlogin

  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write com.apple.LaunchServices LSQuarantine -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 10
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write com.apple.dock mru-spaces -bool false
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock hide-mirror -bool true

  # security
  sudo systemsetup -setremoteappleevents off
  sudo systemsetup -setremotelogin off
  sudo systemsetup -setwakeonmodem off
  sudo systemsetup -setwakeonnetworkaccess off

  sudo tmutil disablelocal
  sudo nvram SystemAudioVolume=" "

  # install brew
  if which brew > /dev/null; then
    echo "Homebrew installed.. Skipping.."
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # configure brew
  brew update
  brew upgrade
  brew tap caskroom/cask
  brew tap caskroom/fonts
fi

# install all the packages
echo -n "Install all base packages (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  brew install zsh
  brew install nvim
  brew install git
  brew install curl
  brew install wget
  brew install ngrep
  brew install nmap
  brew install nasm
  brew install ack
  brew install the_silver_searcher

  # dev tools
  brew install automake
  brew install python
  brew install python@2
  brew install jq
  brew install llvm
  brew install uncrustify
  brew install flawfinder

  # golang
  brew install golang
  brew install delve

  # php
  brew install php
  brew install php-cs-fixer
  brew install phpstan
  brew install phpmd
  brew isntall php-code-sniffer

  # gui tools
  brew cask install skim

  # python tools
  pip install virtualenvwrapper
  pip3 install black
  pip install pyls

  # here you need to first create a virtualenv and then install requirements
  # otherwise nvim will not work properly
  mkvirtualenv neovim2 && workon neovim2 && pip install neovim && deactivate
  mkvirtualenv neovim3 --python=/usr/local/bin/python3 && workon neovim3 && pip install neovim && deactivate
  pip install --upgrade python-language-server

  # terminal colors
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

  # js
  brew install yarn
  yarn global add prettier

  # update shell
  sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
fi

# symlink config files
echo -n "Install/re-install symlinks (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  sudo rm -rf ~/.zshrc > /dev/null 2>&1
  sudo rm -rf ~/.ctags > /dev/null 2>&1
  sudo rm -rf ~/.git* > /dev/null 2>&1
  sudo rm -rf ~/.config > /dev/null 2>&1

  BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  ln -sf $BASE_DIR/bin ~/bin
  ln -sf $BASE_DIR/zshrc ~/.zshrc
  ln -sf $BASE_DIR/git/gitconfig ~/.gitconfig
  ln -sf $BASE_DIR/git/gitmessage ~/.gitmessage
  ln -sf $BASE_DIR/git/gitignore ~/.gitignore
  ln -sf $BASE_DIR/ctags/ctags ~/.ctags
  ln -sf $BASE_DIR/config ~/.config
  ln -sf $BASE_DIR/nvALT ~/Library/Application\ Support/nvALT
fi

# install go tools
echo -n "Install/re-install gotools (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  source ~/.zshrc
  go get -u golang.org/x/tools/cmd/...
  go get -u honnef.co/go/tools/cmd/...
fi

echo -e "\n====== All Done!! ======\n"
echo
