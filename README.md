# dotfiles

## brew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## essential programs
```sh
$ brew install python3 git vim tmux iterm2 macvim fasd htop the_silver_searcher reattach-to-user-namespace ctags
```

## virtualenv/virtualenvwrapper
```
$ pip3 install virtualenv virtualenvwrapper
```

## symlink dotfiles
```sh
$ ln -s zshrc ~/.zshrc
$ ln -s tmux.conf ~/.tmux.conf
$ ln -s vim ~/.vim
$ ln -s vimrc ~/.vimrc
$ ln -s vimrc.bundles ~/.vimrc.bundles
```

## Vundle and vim plugins
```sh
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ vim +PluginInstall +qall
```
