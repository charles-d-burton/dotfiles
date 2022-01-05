#!/bin/bash

#Install the nvim ppa and nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y nvim

#Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#Copy the files to the right places
mkdir -p $HOME/.config/nvim

cp ./init.vim $HOME/.config/nvim/init.vim
cp ./coc-settings.json $HOME/.config/nvim/init.vim

#Setup fonts
mkdir -p $HOME/.fonts
cp -r fonts/* $HOME/.fonts/
#Regenerate font cache
fc-cache -fv

#Install all the plugs and install CoC
nvim +PlugInstall
nvim +CocInstall coc-tsserver coc-pyright coc-json coc-yaml coc-markdownlint

