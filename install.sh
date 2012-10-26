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

echo 'Cloning NeoBundle...';
git clone git://github.com/Shougo/neobundle.vim ~/vim_share/bundle/neobundle.vim
if [ ! $? ]; then
    echo 'Failed to clone NeoBundle';
    exit;
fi

echo 'Generate _gvimrc';
python gen_gvimrc.py _vimrc;
if [ ! $? ]; then
    /c/Python*/python gen_gvimrc.py _vimrc;
    if [ ! $? ]; then
        echo 'Failed to create _gvimrc. Make it manually like:';
        echo '$ python gen_gvimrc.py _vimrc';
    fi
fi

echo 'Copy static resources...';
cp ./res/* ~/vim_share/bundle

echo 'Setting local rc files...';

if [ `uname` = "Darwin" ] || [ `uname` = "Linux" ]; then
    pref='.';
    cwd=$(cd $(dirname $0);pwd);
else
    pref='_';
    cwd=$(/c/Python*/python winpath.py);
fi

# vimrc
echo "source ${cwd}/_vimrc" > ~/${pref}vimrc;
echo "\n" >> ~/${pref}vimrc; 
echo "source ~/site_vimrc" >> ~/${pref}vimrc;
echo "" > ~/site_vimrc;
# gvimrc
echo "source ${cwd}/_vimrc" > ~/${pref}vimrc;
echo "\n" >> ~/${pref}gvimrc; 
echo "source ~/site_vimrc" >> ~/${pref}vimrc;
echo "" > ~/site_gvimrc;

echo 'Complete! Run vim & execute :NeoBundleInstall';
