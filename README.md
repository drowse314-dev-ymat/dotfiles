For
====
+ Git
+ tmux
+ vimperator on Firefox
+ Vim
+ Zsh

Prerequisites
==============

For Vim plugins
---------------
+ pdftotext for 'vim-scripts/pdftotext.git'
+ Fonts patched for Powerline, for 'itchyny/lightline.vim' (fontforge needed)
+ Exuberant Ctags for 'majutsushi/tagbar.git'


Install
========

Assume you have cloned this repo into your $HOME dir.

```
$ cd ~
$ git clone https://github.com/drowse314-dev-ymat/dotfiles.git
```

Git
----

Add the lines below into your ``.gitconfig`` file.

```
[include]
	path = ~/dotfiles/gitconfig/_gitconfig
```

Vimperator
-----------

Assume that vimperator is installed on you Firefox.

1. Prepare plugin-loader environment.

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

2. Add colorscheme.

```bash
$ cd ~/.vimperator
$ mkdir -p colors
$ cd colors
$ ln -s ~/dotfiles/vimperator/sweets_snaka.vimp .
```

3. Source the rc.

```bash
$ echo "source ~/dotfiles/vimperator/_vimperatorrc" >> ~/.vimperatorrc
```

4. (Optional) Create site settings.

At the end of ``_vimperatorrc```, `~/site_vimperatorrc`` will be loaded if exists.
