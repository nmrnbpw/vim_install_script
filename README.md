VIM install script for Windows

1. download install.bat or execute `bitsadmin /transfer test https://raw.githubusercontent.com/nmrnbpw/vim_install_script/master/install.bat <fullpath>\install.bat`
1. execute `install.bat`
1. install font
1. move vim\vim
1. start gvim and `:call dein#update()`


install script for CentOS

1. install gcc g++
1. execute `setup_my_usr.sh`
1. execute `zsh/install_zsh.sh`
1. execute `tmux/install_tmux.sh`
1. execute `vim/install_vim.sh`
1. add `$HOME/usr/bin` to `$PATH`
1. start vim and `:call dein#update()`

