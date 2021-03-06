#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# These setup scripts are intended to be run as the very first things once
# starting up a new Ubuntu WSL shell.  It has been tested with the Ubuntu 18.04
# and the Ubuntu shell (no version) shells available in the Windows Store.

# After running this script, run the 02-setup-dotfiles.sh script found in the
# same directory as this file.

# Must be run as sudo/root
if [[ "$EUID" -ne 0 ]]; then
    echo "This script must be run as root."
    exit
fi

echo "Setup Starting..."

# Set up the ppa for RCM
add-apt-repository -y ppa:martin-frost/thoughtbot-rcm

# First fully upgrade
apt-get update
apt-get full-upgrade -y
apt-get autoremove -y

# Install python & build files (only build files needed for python)
apt-get install -y build-essential python3 python3-venv python3-pip \
make automake autoconf libreadline-dev libncurses5-dev libssl-dev libyaml-dev \
libxslt-dev libffi-dev libtool unixodbc-dev libbz2-dev zlib1g-dev libsqlite3-dev \
libxml2-dev libxmlsec1-dev liblzma-dev xz-utils tk-dev unzip curl wget llvm \
aptitude python3-apt p7zip-full p7zip-rar rcm tmux vim-nox

cp /usr/bin/pip3 /usr/bin/pip

echo -e '\nexport TMP=/tmp' >> ~/.bashrc
echo -e '\nexport TEMP=/tmp' >> ~/.bashrc
echo -e '\nexport TMPDIR=/tmp' >> ~/.bashrc

# This wsl.conf is only temporary, but needed to complete the setup process
# the Ansible script will set up a more complete config with this value included
echo -e '[interop]' > /etc/wsl.conf
echo -e '\nappendWindowsPath = false' >> /etc/wsl.conf

echo ""
echo "Close and re-open the shell and then run 02-setup-dotfiles.sh"
echo ""
