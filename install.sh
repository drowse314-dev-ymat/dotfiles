echo 'Start installing .* files...';

echo 'Make desired directories...';
mkdir ~/vim_share;
if [ ! $? ]; then
    echo 'Failed to make directory: ~/vim_share';
    exit;
fi
mkdir ~/vim_share/bundle;
if [ ! $? ]; then
    echo 'Failed to make directory: ~/vim_share/bundle';
    exit;
fi
mkdir ~/.vimperator;

echo 'Cloning NeoBundle...';
git clone https://github.com/Shougo/neobundle.vim.git ~/vim_share/bundle/neobundle.vim
ret_code=$?;
if [ $ret_code != 0 ]; then
    echo "Failed to clone NeoBundle. error code: $ret_code";
    exit;
fi

echo 'Cloning vimperator-plugins...';
git clone https://github.com/vimpr/vimperator-plugins.git ~/.vimperator/vimperator-plugins
ret_code=$?;
if [ $ret_code != 0 ]; then
    echo "Failed to clone vimperator-plugins. error code: $ret_code";
    exit;
fi
echo 'Checkout for latest Fx version...';
pushd ~/.vimperator/vimperator-plugins
git checkout 3.6
git pull origin
popd

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
confirm () {
    if [ ! -e "$1" ]; then
        echo "Create new $1";
        return 0;
    else
        echo "$1 exists.";
    fi
    read -p "Override your '$1'? [Y/n]" response
    case $response in
        [yY][eE][sS]|[yY])
                return 0;
                ;;
        *)
                return 1;
                ;;
    esac
}
# vimrc
if confirm "$HOME/${pref}vimrc" = 0; then
    echo "source ${cwd}/_vimrc" > $HOME/${pref}vimrc;
else
    echo "source ${cwd}/_vimrc" >> $HOME/${pref}vimrc;
fi
echo "source ~/site_vimrc" >> $HOME/${pref}vimrc;
if confirm "$HOME/site_vimrc" = 0; then
    echo "" > $HOME/site_vimrc;
fi
# gvimrc
if confirm "$HOME/${pref}gvimrc" = 0; then
    echo "source ${cwd}/_gvimrc" > $HOME/${pref}gvimrc;
else
    echo "source ${cwd}/_gvimrc" >> $HOME/${pref}gvimrc;
fi
echo "source ~/site_gvimrc" >> $HOME/${pref}gvimrc;
if confirm "$HOME/site_gvimrc" = 0; then
    echo "" > $HOME/site_gvimrc;
fi
# vimperatorrc
if confirm "$HOME/${pref}vimperatorrc" = 0; then
    echo "source ${cwd}/_vimperatorrc" > $HOME/${pref}vimperatorrc;
else
    echo "source ${cwd}/_vimperatorrc" >> $HOME/${pref}vimperatorrc;
fi
echo "source ~/site_vimperatorrc" >> $HOME/${pref}vimperatorrc;
echo 'echo ""' >> $HOME/${pref}vimperatorrc;
if confirm "$HOME/site_vimperatorrc" == 0; then
    echo "" > $HOME/site_vimperatorrc;
fi
# zshrc
if confirm "$HOME/${pref}zshrc" = 0; then
    echo "source ${cwd}/_zshrc" > $HOME/${pref}zshrc;
else
    echo "source ${cwd}/_zshrc" >> $HOME/${pref}zshrc;
fi
echo "source ~/site_zshrc" >> $HOME/${pref}zshrc;
if confirm "$HOME/site_zshrc" = 0; then
    echo "" > $HOME/site_zshrc;
fi
# tmux.conf
if confirm "$HOME/${pref}tmux.conf" = 0; then
    echo "source ${cwd}/_tmux_conf" > $HOME/${pref}tmux.conf;
else
    echo "source ${cwd}/_tmux_conf" >> $HOME/${pref}tmux.conf;
fi
echo "source ~/site_tmux_conf" >> $HOME/${pref}tmux.conf;
if confirm "$HOME/site_tmux_conf" = 0; then
    echo "" > $HOME/site_tmux_conf;
fi

echo 'Complete! Run vim & execute :NeoBundleInstall';
