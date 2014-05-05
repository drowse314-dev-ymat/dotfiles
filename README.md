# For
+ Git
+ tmux
+ vimperator on Firefox
+ Vim
+ Zsh

# Prerequisites

## For Vim plugins
+ pdftotext for 'vim-scripts/pdftotext.git'
+ Fonts patched for Powerline, for 'itchyny/lightline.vim' (fontforge needed)
+ Exuberant Ctags for 'majutsushi/tagbar.git'

## For Git
+ lighttpd for git instaweb (optional)

## For Zshrc
+ cd-bookmark (optional)


# Install

Assume you have cloned this repo into your $HOME dir.

```
$ cd ~
$ git clone https://github.com/drowse314-dev-ymat/dotfiles.git
```

## Git

Add the lines below into your ``.gitconfig`` file.

```
[include]
	path = ~/dotfiles/gitconfig/_gitconfig
```

## Tmux

Add the line below into your ``.tmux.conf`` file.

```bash
$ echo "source-file ~/dotfiles/tmux/_tmux.conf" >> ~/.tmux.conf
```

## Vimperator

Assume that vimperator is installed on your Firefox.

### Prepare plugin-loader environment.

```bash
$ cd ~/.vimperator
$ git clone https://github.com/vimpr/vimperator-plugins.git
$ cd vimperator-plugins
$ git checkout 3.6  # for Firefox 20.* or higher
```

```bash
$ cd ~/.vimperator
$ mkdir -p plugin
$ cd plugin
$ ln -s ~/.vimperator/vimperator-plugins/plugin_loader.js .  # or copy it
```

### Add colorscheme.

```bash
$ cd ~/.vimperator
$ mkdir -p colors
$ cd colors
$ ln -s ~/dotfiles/vimperator/sweets_snaka.vimp .
```

### Source the rc.

```bash
$ echo "source ~/dotfiles/vimperator/_vimperatorrc" >> ~/.vimperatorrc
```

### (Optional) Create site settings.

At the end of ``_vimperatorrc``, ``~/site_vimperatorrc`` will be loaded if exists.

## Vim

### Prepare NeoBundle.

```bash
$ cd ~
$ mkdir vim_share/bundle
$ cd vim_share/bundle
$ git clone https://github.com/Shougo/neobundle.vim.git
```

### Source the rc.

```bash
$ echo "source ~/dotfiles/vim/_vimrc" >> ~/.vimrc
```

### Install plugins

Run vim, exexute ``:NeoBundleInstall``.

## Zsh

### Source the rc.

```bash
$ echo "source ~/dotfiles/zsh/_zshrc" >> ~/.zshrc
```

### (optional) install cd-bookmark.

```bash
$ cd ~
$ mkdir -p zsh_share/functions/pkg
$ cd zsh_share/functions/pkg
$ git clone https://github.com/mollifier/cd-bookmark.git
$ cd ~/zsh_share/functions
$ ln -sv ~/zsh_share/functions/pkg/cd-bookmark/cd-bookmark cd-bookmark
$ ln -sv ~/zsh_share/functions/pkg/cd-bookmark/_cd-bookmark _cd-bookmark
```
