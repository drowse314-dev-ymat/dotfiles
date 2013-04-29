echo 'Start updating .* files...';

echo 'pull from origin...';
git pull --rebase origin master
ret_code=$?;
if [ $ret_code != 0 ]; then
    echo "Failed to pull from origin. error code: $ret_code";
    exit;
fi

echo 'Generate _gvimrc';
python gen_gvimrc.py _vimrc;
if [ ! $? ]; then
    echo 'Failed to create _gvimrc. Make it manually like:';
    echo '$ python gen_gvimrc.py _vimrc';
fi

echo 'Setting local rc files...';

if [ `uname` = "Darwin" ] || [ `uname` = "Linux" ]; then
    pref='.';
else
    pref='_';
fi

cwd=$(python pwd.py);

# rc file creations...
file_exists () {
    if [ ! -e "$1" ]; then
        echo "Create new $1";
        return 0;
    else
        echo "$1 exists.";
        return 1;
    fi
}
# vimrc
if file_exists "$HOME/${pref}vimrc" = 0; then
    echo "source ${cwd}/_vimrc" > $HOME/${pref}vimrc;
    echo "source ~/site_vimrc" >> $HOME/${pref}vimrc;
fi
if file_exists "$HOME/site_vimrc" = 0; then
    echo "" > $HOME/site_vimrc;
fi
# gvimrc
if file_exists "$HOME/${pref}gvimrc" = 0; then
    echo "source ${cwd}/_gvimrc" > $HOME/${pref}gvimrc;
    echo "source ~/site_gvimrc" >> $HOME/${pref}gvimrc;
fi
if file_exists "$HOME/site_gvimrc" = 0; then
    echo "" > $HOME/site_gvimrc;
fi
# vimperatorrc
if file_exists "$HOME/${pref}vimperatorrc" = 0; then
    echo "source ${cwd}/_vimperatorrc" > $HOME/${pref}vimperatorrc;
    echo "source ~/site_vimperatorrc" >> $HOME/${pref}vimperatorrc;
    echo 'echo ""' >> $HOME/${pref}vimperatorrc;
fi
if file_exists "$HOME/site_vimperatorrc" == 0; then
    echo "" > $HOME/site_vimperatorrc;
fi
# zshrc
if file_exists "$HOME/${pref}zshrc" = 0; then
    echo "source ${cwd}/_zshrc" > $HOME/${pref}zshrc;
    echo "source ~/site_zshrc" >> $HOME/${pref}zshrc;
fi
if file_exists "$HOME/site_zshrc" = 0; then
    echo "" > $HOME/site_zshrc;
fi
# tmux.conf
if file_exists "$HOME/${pref}tmux.conf" = 0; then
    echo "source ${cwd}/_tmux_conf" > $HOME/${pref}tmux.conf;
    echo "source ~/site_tmux_conf" >> $HOME/${pref}tmux.conf;
fi
if file_exists "$HOME/site_tmux_conf" = 0; then
    echo "" > $HOME/site_tmux_conf;
fi

echo 'Complete!';
