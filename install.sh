set -eu

function confirm() {
    select ANS in "Yes" "No"; do
        case $ANS in
            Yes) break;;
            No) break;;
        esac
    done
    echo $ANS
}

function file_exists() {
    FILEPATH=$1
    if [ -f $FILEPATH ]; then
        echo 'Yes'
    else
        echo 'No'
    fi
}

## File & directory paths.
CWD=$(python pwd.py)
PREF='.'
SOURCE_PREF='_'
# vim
VIM_SHARE_DIR=${HOME}/vim_share
VIM_SHARE_BUNDLE_DIR=${HOME}/vim_share/bundle
VIMRC="vimrc"
# vimperator
VIMPERATOR_DIR=${HOME}/.vimperator
VIMPERATORRC="vimperatorrc"
# zsh
ZSHRC="zshrc"
# tmux
TMUXCONF="tmux.conf"

# Confirmation to start.
echo 'Start installing .* files...'
echo "Going to modify stuffs in '${HOME}' and '${CWD}', OK? [y/n]"
if [ `confirm` = "No" ]; then
    echo  'Exit.'
    exit
fi
echo 'Continue...\n'

echo 'Setting local rc files...\n'

for DOTFILE in $VIMRC $VIMPERATORRC $ZSHRC $TMUXCONF
do
    TARGET=${HOME}/${PREF}${DOTFILE}
    SOURCE=${CWD}/${SOURCE_PREF}${DOTFILE}
    SITE=${HOME}/site_${DOTFILE}

    echo "+ Setup for '${TARGET}' from '${SOURCE}'..."
    if [ `file_exists $TARGET` = "Yes" ]; then
        echo "'${TARGET}' exists. Override?"
        if [ `confirm` = "No" ]; then
            echo "source ${SOURCE}" >> $TARGET
        else
            echo "Create new: '${TARGET}'"
            ln -svf ${SOURCE} $TARGET
        fi
    else
        echo "Create new: ${TARGET}"
        ln -svf ${SOURCE} $TARGET
    fi

    echo "+ Setup for ${SITE}..."
    if [ `file_exists $SITE` = "Yes" ]; then
        echo "${SITE} exists."
    else
        echo "Create new: ${SITE}"
        ln -svf ${SOURCE} $TARGET
    fi
    echo "Done.\n"
done

echo 'Make desired directories...\n'
mkdir -v ${VIM_SHARE_DIR}
mkdir -v ${VIM_SHARE_BUNDLE_DIR}
if [ ! -d ${VIMPERATOR_DIR} ]; then
    mkdir -v ${VIMPERATOR_DIR}
else
    echo "Reuse your .vimperator: ${VIMPERATOR_DIR}"
fi

# Vim
echo '+ Cloning NeoBundle...'
git clone -v https://github.com/Shougo/neobundle.vim.git ${VIM_SHARE_BUNDLE_DIR}/neobundle.vim

# Vimperator
echo '+ Cloning vimperator-plugins...'
git clone -v https://github.com/vimpr/vimperator-plugins.git ${VIMPERATOR_DIR}/vimperator-plugins
echo '+ Checkout for latest Fx version...'
pushd ${VIMPERATOR_DIR}/vimperator-plugins
echo "CD to `pwd`"
git checkout 3.6
git pull -v --rebase --all
echo '+ Create symlink of plugin_loader.js...'
mkdir -v ${VIMPERATOR_DIR}/plugin
ln -sv ${VIMPERATOR_DIR}/vimperator-plugins/plugin_loader.js ${VIMPERATOR_DIR}/plugin/plugin_loader.js
popd
echo "CD to `pwd`"

echo 'Complete! Run vim & execute :NeoBundleInstall'
echo 'No settings done for .gitconfig; include ./_gitconfig yourself!'
