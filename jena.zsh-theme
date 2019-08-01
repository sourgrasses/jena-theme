# Minimal zsh theme
# Requires Nerd Fonts for the icons

# consts
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✖"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[cyan]%}✓"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}△"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}▲"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%}▲"

# Configuration
num_dirs=2 # Use 0 for full path
truncated_path="%F{white}%$num_dirs~%f"
decoration="%{$fg_bold[red]%}%{$fg_bold[magenta]%}%{$fg_bold[cyan]%}%f"
background_jobs="%(1j.%F{green} %f.)"
non_zero_return_value="%(0?..%F{magenta}  %f)"

function _ssh_env() {
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    echo " %{$fg_bold[red]%}(%M)%f"
  fi
}

# get python env stuff if it exists
function _python_venv() {
  if [[ $VIRTUAL_ENV != "" ]]; then
    # split off the string before the '-' to get the ~friendly~ name
    env_long=${VIRTUAL_ENV##*/}
    env=("${(@s/-/)env_long}")

    echo " %{$fg[blue]%}($env[1])%{$reset_color%} "
  fi
}

function _git_info() {
    if [[ $(git_prompt_info) != "" ]]; then
        echo "($(git_prompt_info))"
    fi
}

# Left part of prompt
PROMPT='$truncated_path $decoration '
# Right part of prompt
RPROMPT='$(_git_info)$(_python_venv)$(_ssh_env)$non_zero_return_value'
# Input in bold
zle_highlight=(default:bold)
