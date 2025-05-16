# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# make zsh default shell
# chsh -s $(which zsh)
### ZSH env
if ! command -v nvim &> /dev/null; then
  export EDITOR=/usr/bin/vim
  export MANPAGER='less -s -M +Gg'
else
  # If Neovim is installed with package manager:
  export EDITOR=/usr/bin/nvim
  # If Neovim is installed from source:
  #export EDITOR=/usr/local/bin/nvim
  export MANPAGER='nvim +Man!'
fi
export VISUAL=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# gpg-agent instead ssh-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

###  Path
if [ "$(id -u)" -eq 0 ]; then
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
  PATH="/usr/local/bin:/usr/bin:/bin:$HOME/go/bin:$HOME/.local/share/nvim/mason/bin"
fi
export PATH

### zsh directory stack
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..10}) alias "$index"="cd +${index}"; unset index
### ---- history config -------------------------------------
setopt appendhistory
setopt sharehistory

export HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/.zsh_history"

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# Now any command that starts with a space won't be recorded in the history.
setopt hist_ignore_space

# If you run a command multiple times, only the most recent execution will be kept in history.
setopt hist_ignore_all_dups

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS


# ---- FZF -----
FZF=".fzf"
if [ ! -d "$HOME/$FZF" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/$FZF
    $HOME/$FZF/install
    echo "fzf has been installed"
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

### themes
zinit ice depth=1; 
zinit light romkatv/powerlevel10k
### plugins

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light jeffreytse/zsh-vi-mode

# Completion styling
fpath=(~/.local/share/zinit/completions/src $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# zsh-vi-mode
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
function keymap() {
  bindkey '^y' autosuggest-accept
}
zvm_after_init_commands+=(keymap)

# fzf change directory faster
cd_to_dir() {
    local selected_dir
    selected_dir=$(fd -t d . . | fzf +m --height 50% --preview 'tree -C -L 2 {}' --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' )
    if [[ -n "$selected_dir" ]]; then
        # Change to the selected directory
        cd "$selected_dir" || return 1
    fi
}

alias cdd='cd_to_dir'
zle -N cd_to_dir
bindkey '^g' cd_to_dir

### custome alias 
alias vi='nvim'
alias vit='NVIM_APPNAME=nvimtest nvim'
alias vifzf='nvim $(fzf --preview="cat {}")'
alias ls='ls -F --color=none'
alias la='ls -a'
alias cl='clear'
alias wifioff='nmcli radio wifi off'
alias cdob='cd $HOME/Documents/obsidian/'
alias rcmount='rclone mount onedrive:/ ~/Cloud/onedrive/ --copy-links --allow-other --allow-non-empty --umask 000 --vfs-cache-mode writes --daemon && rclone mount personal:/ ~/Cloud/personal/ --copy-links --allow-other --allow-non-empty --umask 000 --vfs-cache-mode writes --daemon'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
## xrandr --output eDP --mode 2880x1800 --scale 0.5x0.5
alias xon='xrandr --output eDP --auto'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
