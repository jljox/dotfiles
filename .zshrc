# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(history git docker docker-compose cabal vi-mode npm nvm yarn mvn aws kubectl helm pod)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$HOME/.local/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cls=clear

OS_NAME=`uname`
source $HOME/dotfiles/.zshrc.$OS_NAME

if [ -f $HOME/etc/.not_source_controlled_rc ]; then
  source $HOME/etc/.not_source_controlled_rc
fi
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# stack completions and nix
$(which stack >/dev/null 2>&1)
if [ $? -eq 0 ]; then
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
  eval "$(stack --bash-completion-script "$(which stack)")"

  # alias for stack on systems using nix package manager
  if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    alias stack="stack --nix"
  fi

  STACK_BIN=`stack path --compiler-bin`
  export PATH="$PATH:$STACK_BIN"
fi

# bloop
BLOOP_HOME=$HOME/.bloop
if [ -d $BLOOP_HOME ]; then
  
  autoload -U compinit
  fpath=($BLOOP_HOME/zsh $fpath)
  compinit

  export PATH="$PATH:$BLOOP_HOME"
fi

# sbt
SBT_HOME="$HOME/local/sbt/current"
if [ -d $SBT_HOME ]; then
  export PATH="$PATH:$SBT_HOME/bin"
fi

# scala
SCALA_HOME="$HOME/local/scala/current"
if [ -d $SCALA_HOME ]; then
  export PATH="$PATH:$SCALA_HOME/bin"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
SDKMAN_DIR="$HOME/.sdkman"
if [ -d $SDKMAN_DIR ]; then
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

# give rgit the same completion as git
compdef rgit=git

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jljox/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jljox/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jljox/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jljox/google-cloud-sdk/completion.zsh.inc'; fi

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
