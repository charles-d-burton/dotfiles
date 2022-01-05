# dotfiles

## NVIM

The `init.vim` file is my nvim config.  Primarily geared towards readability and Go development.  Place in `~/.config/nvim/init.vim` on a Linux machine.  Prereq is to install Vim Plug then run `nvim +PlugInstall` to initialize it.

## Fonts

If you want the TreeSitter and Devicons plugins to work correctly with nvim you'll need to have Nerd-Fonts installed.  The `fonts` directory contains the fonts that I use for my setup.  On Linux copy the contents of that files to `~/.fonts` and then run `fc-cache -fv` to rebuild the font cache.
