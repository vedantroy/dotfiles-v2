# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

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
source ~/.zsh/autosuggestions.zsh

# Syntax highlighting
source ~/.zsh/fast-synax-highlighting/fast-syntax-highlighting.plugin.zsh

# Use modern completion system
autoload -Uz compinit
compinit

# https://github.com/agkozak/zsh-z
# "If you add <the below> to your .zshrc, your completion menus will look nice"
zstyle ':completion:*' menu select

