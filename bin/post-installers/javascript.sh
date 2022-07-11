curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

source ~/.zshrc

nvm install 16
nvm install --lts

npm install --global yarn

npm install -g prettier
npm install -g eslint
