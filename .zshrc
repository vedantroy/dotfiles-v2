# TODO: The prompt is still a bit slow to startup
# but... usiing powerline10k is overkill (& adds unnecessary complexity)
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# https://asdf-vm.com (tool for managing language versions)
source $HOME/.asdf/asdf.sh

# # https://github.com/junegunn/fzf
# fzf stores its shell integrations in /usr/share/fzf
# (I had to manually download them from Github & put them there)
# Ctrl-T = paste directory/file into command line
# Ctrl-R = better recent command search
# Alt-C = cd into directory
# ** <TAB> to search through files
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# https://github.com/junegunn/fzf/issues/383
# ripgrep respects .gitignore (unless you use --no-ignore-vcs)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --color never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# https://github.com/agkozak/zsh-z/
# jump around directories with `z`
source ~/.zsh/zsh-z.plugin.zsh

# Fish-like auto suggestions
# https://github.com/zsh-users/zsh-autosuggestions
# These might improve perf?
#ZSH_AUTOSUGGEST_MANUAL_REBIND="true"
#ZSH_AUTOSUGGEST_USE_ASYNC="true"
# Note
source ~/.zsh/autosuggestions.zsh


# Use modern completion system
autoload -Uz compinit
compinit

# https://github.com/agkozak/zsh-z
# "If you add <the below> to your .zshrc, your completion menus will look nice"
zstyle ':completion:*' menu select

# Git integration: https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Make sure there are no lines like
# "autoload -Uz promptinit && promptinit && prompt adam1"
# or your prompt will be overridden
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '

# Syntax highlighting
# there's another plugin (fast-syntax-highlighting) that has
# better details/highlighting but it makes zsh slower to startup (I think?)
# This plugin must be sourced at the end
source ~/.zsh/syntax-highlighting/syntax-highlighting.zsh
