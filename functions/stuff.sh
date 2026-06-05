
# http://cdn.smosh.com/sites/default/files/bloguploads/simpsons-fire.gif
kiwf(){
	find . -name $1 -delete -exec sh -c 'echo {} 🔥' \;
}
# interactive job selection
fgi(){
    fg "%$(jobs | sort | fzf | cut -c2-2)"
}

tunnel-anything(){
    if [[ $# < 2 || $# > 4 ]]
    then
        echo "Usage: tun <ssh-host> <remote-port> [<local-port>] [<remote-host>]"
        return 1
    fi
    local sshHost="$1"
    local remotePort="$2"
    local localPort=${3:-$remotePort}
    local remoteHost=${4:-localhost}

    ssh -M -S "/tmp/tunnel-anything-$localPort" -fnNT -L ${localPort}:${remoteHost}:${remotePort} "$sshHost"
    vared -p "Tunnel is to '$sshHost' open, on $localPort->$remotePort (enter to stop)" -c tmp
    ssh -S "/tmp/tunnel-anything-$localPort" -O exit "$sshHost"
}


ssl-fingerprint(){
    openssl s_client -servername "$1" -connect "$1:443" | openssl x509 -fingerprint -noout
}

# see http://stackoverflow.com/a/3572105
realpath(){
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

calver(){
    local d=$(date +%y.%-m)
    local minor="${1:+.$1}"
    local rc="${2:+-rc$2}"
    echo "$d$minor$rc"
}

# Run command with .env variables prepended
dot() {
  if [[ ! -f .env ]]; then
    echo "No .env file found in current directory" >&2
    return 1
  fi
  env $(grep -v '^#' .env | grep -v '^$' | xargs) "$@"
}

# Extract CMD from Dockerfile and return as shell command
_dockerfile_cmd() {
  local dockerfile="${1:-Dockerfile}"
  if [[ ! -f "$dockerfile" ]]; then
    return 1
  fi
  # Get last CMD line, parse JSON array format
  grep -i '^CMD' "$dockerfile" | tail -1 | \
    sed 's/^CMD[[:space:]]*//' | \
    jq -r 'if type == "array" then join(" ") else . end' 2>/dev/null || \
    grep -i '^CMD' "$dockerfile" | tail -1 | sed 's/^CMD[[:space:]]*//'
}

# Widget to expand dCMD to actual command
_expand_dcmd() {
  if [[ "$LBUFFER" == "dCMD"* ]]; then
    local cmd="$(_dockerfile_cmd)"
    if [[ -n "$cmd" ]]; then
      LBUFFER="${cmd}${LBUFFER#dCMD}"
      return
    fi
  fi
  zle expand-or-complete
}
zle -N _expand_dcmd
bindkey '^I' _expand_dcmd

# Also provide dCMD as a function to just print/run it
dCMD() {
  local cmd=$(_dockerfile_cmd "$1")
  if [[ -z "$cmd" ]]; then
    echo "No CMD found in Dockerfile" >&2
    return 1
  fi
  echo "$cmd"
}
