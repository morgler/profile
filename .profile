
# MacPorts Installer addition on 2010-03-12_at_08:49:09: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

alias sg='script/generate '
alias ss='script/server'
alias ll='ls -l'
alias la='ls -a'
alias gac='git commit -am '
alias gc='git commit -am '
alias gst='git status'
alias g='git status'
alias gb='git branch'
alias gco='git checkout '
alias gub='git fetch origin master && git rebase origin/master'   # update branch
alias feature='rake db:test:prepare && cucumber --drb '
alias migrate='rake db:migrate && rake db:test:prepare'
alias watch='watchr ./watchr-runner.rb'

# MySQL
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
function gmback {
  branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")
  go master
  gm $branch
}
export PS1='\u@\h:\[\033[1;33m\]\W\[\033[0m\]$(parse_git_branch)$ '


_complete_git() {
  if [ -d .git ]; then
    branches=`git branch -a | cut -c 3-`
    tags=`git tag`
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${branches} ${tags}" -- ${cur}) )
  fi
}
complete -F _complete_git git checkout
complete -F _complete_git gco

export AUTOFEATURE=true
export AUTOSPEC=true
export EDITOR="mate -w"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"