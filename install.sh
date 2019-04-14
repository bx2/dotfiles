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

  chsh -s /bin/zsh

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

  # golang
  brew install golang
  brew install delve

  # gui tools
  brew install koekeishiya/formulae/skhd
  brew install --HEAD chunkwm
  brew cask install kitty
  brew cask install skim

  # python tools
  pip install virtualenvwrapper
  pip2 install neovim
  pip3 install neovim

  # terminal colors
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# install prettier
# install black
# install checkmake
fi

# symlink config files
echo -n "Install/re-install symlinks (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
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

# install go tools
echo -n "Install/re-install gotools (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
  source ~/.zshrc
  go get -u golang.org/x/tools/cmd/gopls
  go get -u golang.org/x/tools/cmd/godoc
  go get -u golang.org/x/tools/cmd/guru
  go get -u golang.org/x/tools/cmd/goimports
  go get -u golang.org/x/tools/cmd/gorename
  go get -u golang.org/x/tools/cmd/cover
  go get -u golang.org/x/tools/cmd/present
fi

echo -e "\n====== All Done!! ======\n"
echo

