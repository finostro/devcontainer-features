apt_get_update() {
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

apt_get_update
apt-get install -y \
    python3-vcstool \
    tmux \
    zsh \
    python3-venv

cd /home/${_REMOTE_USER}
python3 -m venv default_venv --system-site-packages
chown -R ${_REMOTE_USER}:${_REMOTE_USER} default_venv


# setup argcomplete for older ubuntus
if [ ! -a /usr/bin/register-python-argcomplete]; then
    if [ -a /usr/bin/register-python-argcomplete3 ]; then
        ln -s /usr/bin/register-python-argcomplete3 /usr/bin/register-python-argcomplete
    else
        echo "Could not find register-python-argcomplete3"
    fi 
fi

# tree-sitter-cli is required for nvim vimtex plugin
cargo install tree-sitter-cli
# nvim --headless "+Lazy! sync" +qa


git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
