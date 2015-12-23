# dotfiles

### brew
```sh
$ brew install iterm2 the_silver_searcher reattach-to-user-namespace ctags tmux macvim
```

### link files
```sh
$ ln -s zshrc ~/.zshrc
$ ln -s tmux.conf ~/.tmux.conf
$ ln -s vim ~/.vim
$ ln -s vimrc ~/.vimrc
$ ln -s vimrc.bundles ~/.vimrc.bundles
```

### Vundle and plugins
```sh
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# todo: fix this
$ vim +PluginInstall +qall
```
