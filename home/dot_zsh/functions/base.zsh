
#
# SESH FUNCTION
#

function s() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

# yazi wrapper function to cd on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Delete Git branches interactively with fzf
function gbd() {
  git branch |
    grep --invert-match $(git branch --show-current) |
    cut -c 3- |
    fzf --multi --preview="git log {} --"  --height 40% --reverse --border-label ' delete branch ' --border --prompt '⚡  '|
    xargs git branch --delete --force
}

# View homebrew casks
function casks() {
  curl "https://formulae.brew.sh/api/cask.json" |
    jq '.[].token' |
    tr -d '"' |
    fzf --multi --preview="curl https://formulae.brew.sh/api/cask/{}.json | jq '.'" |
    xargs brew install --cask
}

# What application is listening on any given port?
function whomport() { lsof -nP -i4TCP:$1 | grep LISTEN }

# What's inside that JWT?
function jwt() {
  for part in 1 2; do
    b64="$(cut -f$part -d. <<< "$1" | tr '_-' '/+')"
    len=${#b64}
    n=$((len % 4))
    if [[ 2 -eq n ]]; then
      b64="${b64}=="
    elif [[ 3 -eq n ]]; then
      b64="${b64}="
    fi
    d="$(openssl enc -base64 -d -A <<< "$b64")"
    python -mjson.tool <<< "$d"
    # don't decode further if this is an encrypted JWT (JWE)
    if [[ 1 -eq part ]] && grep '"enc":' <<< "$d" >/dev/null ; then
        break
    fi
  done
}

# What functions have I defined?
function funcs() {
    functions | grep "()" | grep -v '"'
}

# Decode URLs with percentage decoded values
function percentdecode() {
  echo $1 | python3 -c 'import sys,urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()),end="")'
}

# Pretty print URL params
function params() {
  percentdecode $1 |
    tr "?" "\n" |
    tr "&" "\n"
}

# Pretty print PATH
function path() {
  echo -e "${PATH//:/\\n}"
}

redactenv() {
  sed -E 's/=.*/=•••/g;t' <<< $(env | grep "$1")
}
