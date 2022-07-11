# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export DOTFILES="$HOME/.config/nvim"
export PATH=$PATH:$HOME/.local/share/nvim/lsp_servers/lua-language-server/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GPG_TTY=$(tty)
# Path to your oh-my-zsh installation.
export ZSH="/usr/share/oh-my-zsh"
export PATH=$HOME/dev/scripts/tmux-workspaces/src:$PATH
export TW_CONFIG="$HOME/.config/tw"
export TW_PATHS="$HOME/dev/tz-stack $HOME/dev/scripts $HOME/dev/js $HOME/dev/rust $HOME/Documents $HOME/.config $HOME/dev/plugins"
export TW_MAIN_WINDOW="main"

export PATH="$HOME/.cargo/bin/alacritty/:$PATH"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# https://github.com/spaceship-prompt/spaceship-prompt
export SPACESHIP_CHAR_SYMBOL=〉
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
 git
 vi-mode
# zsh-vi-mode
 zsh-autosuggestions
 zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
ZSH_DISABLE_COMPFIX="true"
#
#
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

function zle-keymap-select zle-line-init {
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish {
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias vim="nvim"
alias vi="nvim"
alias nrt="npm run test"
alias nrs="npm run start"
alias nrd="npm run dev"
alias deletebranch="git branch --merged >/tmp/merged-branches && /usr/bin/nvim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches"
alias luamake="$HOME/.local/share/nvim/lsp_servers/lua-language-server/3rd/luamake/luamake"
alias python="python3"

updatenvim() {
    cd ~/dev/lua/neovim
    git pull
    make
    sudo make install
}

open() {
    if which xdg-open &> /dev/null; then
        xdg-open $@ &       # linux
    else
        open $@           # mac
    fi
}

deploy() {
    npm run build
    scp -r ./build/* droplet:/var/www/$1
}

npmlink() {
    rm -rf dist/
    npm i
    npm run build
    rm -rf node_modules/
    npm link
}

nr() {
    npm run $1
}

idea() {
	sh $HOME/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0/213.7172.25/bin/idea.sh $1
}

storm() {
	sh $HOME/.local/share/JetBrains/Toolbox/apps/WebStorm/ch-0/221.5080.193/bin/webstorm.sh $1
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# if [ -z "$TMUX" ]; then
#     tmux attach -t tobiasz || tmux new -s tobiasz
# fi
