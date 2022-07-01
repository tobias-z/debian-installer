#!/bin/bash

email=$1

if [ "$2" = "1" ]; then
    exit 0
fi

sudo apt install make build-essential libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip -y

cd /tmp
sudo wget https://github.com/git/git/archive/master.zip -O git.zip
unzip git.zip
cd git-*
make prefix=/usr/local/
sudo make prefix=/usr/local install

echo "git version $(git --version) was succesfully installed"

if [ -f ~/.ssh/id_rsa.pub ] && [ ! -f ~/.ssh/ed25519.pub ] ; then
    ssh-keygen -t ed25519 -C $email
fi

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt install gh -y

echo "Enter Github access token:"
read access_token

echo "$access_token" >> /tmp/token.txt
gh auth login --with-token < /tmp/token.txt
gh ssh-key add ~/.ssh/id_ed25519.pub

rm /tmp/token.txt
