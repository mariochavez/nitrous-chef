function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "%{$fg[red]%}*%{$reset_color%}"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

PROMPT='%{$bold_color$fg[green]%}%n@%m%{$reset_color%}:%{$bold_color$fg[cyan]%}%~%{$reset_color%}$(parse_git_branch)$ '
