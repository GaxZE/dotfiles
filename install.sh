#!/bin/sh

if [ "$(uname)" == "Darwin" ]; then
	# Ask for the administrator password upfront
	sudo -v

	# Check for Homebrew and install it if missing
	if test ! $(which brew)
	then
		echo "Installing Homebrew..."
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	# Make sure we’re using the latest Homebrew
	brew update
	# Upgrade any already-installed formulae
	brew tap homebrew/versions
	brew upgrade --all

	apps=(
        bash
        coreutils
		git
		mysql
		node
		ruby
		wget
        zsh
        zsh-completions
	)
	brew install "${apps[@]}"
	sudo easy_install pip

	# Install Caskroom
	brew tap caskroom/cask
	brew tap caskroom/versions
    brew tap caskroom/fonts

	apps=(
        atom
		docker
        font-source-code-pro-for-powerline
        font-source-code-pro
        font-source-sans-pro
        font-source-serif-pro
		iterm2
        nordvpn
		postman
		sequel-pro
		sublime-text
		unrar
        vagrant
        virtualbox
        virtualbox-extension-pack
        visual-studio-code
	)
	brew cask install "${apps[@]}"

	# Remove outdated versions from the cellar
	brew cleanup

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	# Ask for the administrator password upfront
	sudo -v

	# Make sure we’re using the latest repositories
	apt update

	apps=(
		git
        htop
		nodejs
		npm
		ruby
		wget
	)
	apt install "${apps[@]}"
    apt install python-pip python-dev build-essential
	apt install fonts-powerline

fi

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global NPM packages
npm install --global yarn

# install oh-my-zsh
export ZSH="$HOME/.dotfiles/oh-my-zsh"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Lets sort out .gitconfig
rm -rf ~/.gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
