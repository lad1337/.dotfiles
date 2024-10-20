alias ls='ls --color=auto'
alias repl="ipython"
alias last-stash="git stash show 'stash@{0}' -p"
local grc="/usr/local/bin/grc -es --colour=auto"
alias ping="${grc} ping"
alias dig="${grc} dig"
alias ifconfig="${grc} ifconfig"
alias traceroute="${grc} traceroute"
alias t="tree"
# http://superuser.com/questions/180299/how-can-i-trigger-the-screensaver-on-my-mac
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
# clean tox
alias detox="find . -type f -name '*.py[co]' -delete -or -type d -name '__pycache__' -delete && rm -r .tox"
#open ports on osx
alias lsnet='lsof -nP -i4TCP -sTCP:LISTEN'
# Delete all volumes
alias docker-clean-volumes='printf "\n>>> Deleting dangling volumes\n\n" && docker volume rm $(docker volume ls -qf dangling=true)'
# Delete all stopped containers.
alias docker-clean-containers='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias docker-clean-images='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# clean all docker things
alias docker-clean-all='docker-clean-containers || true && docker-clean-images || true && docker-clean-volumes'
# git semantic version
alias are-we-there-yet="git tag -l -n1 | gsort -V"
# build a python wheel, you know because its long to type
alias bw="python setup.py bdist_wheel"
# http://osxdaily.com/2015/11/16/howto-flush-dns-cache-os-x-elcap/
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed'
# https://www.commandlinefu.com/commands/view/12218/convert-yaml-to-json
alias yaml2json="python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)'"
# vim
alias vim='lvim -O'
alias e='vim'
alias watch='watch '
alias gdc='gd --cached'
