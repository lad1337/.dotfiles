
# http://cdn.smosh.com/sites/default/files/bloguploads/simpsons-fire.gif
kiwf(){
	find . -name $1 -delete -exec sh -c 'echo {} 🔥' \;
}
# interactive job selection
fgi(){
    fg "%$(jobs | sort | fzf | cut -c2-2)"
}

tunnel-anything(){
    if [[ $# < 2 || $# > 3 ]]
    then
        echo "Usage: tun <host> <hostport> [<port>]"
        return 1
    fi
    local host="$1"
    local hostport="$2"
    local port=${3:-$hostport}

    ssh -M -S "/tmp/tunnel-anything-$port" -fnNT -L ${port}:localhost:${hostport} "$host"
    vared -p "Tunnel is to '$host' open, on $port->$hostport (enter to stop)" -c tmp
    ssh -S "/tmp/tunnel-anything-$port" -O exit "$host"
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
