export FZF_DEFAULT_COMMAND="
fd --type f --hidden -E .steam -E Steam
"

fzf_args=(
  --height 100%
    --list-border rounded
    --input-border rounded
    --header-border rounded
    --layout reverse
    --scroll-off=200
    --padding 1,2
    --input-label 'Input'
    --bind 'result:transform-list-label:
    if [[ -z \$FZF_QUERY ]]; then
    echo \" \$FZF_MATCH_COUNT items \";
    else echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \";
    fi'
    --bind 'ctrl-r:change-list-label(Reloading the list)+reload(sleep 2; git ls-files)'
    --color 'border:#5b2538,label:#A0546D'
    --color 'list-border:#1184a3,list-label:#1184a3'
    --color 'input-border:#1184a3,input-label:#439fb5'
    --color 'prompt:#923852,info:#A0546D'
    --color 'bg:#131229,bg+:#131229,hl:#42d6e7,hl+:#7de8f4,pointer:#923852'
)

path=$(find . -type d | fzf "${fzf_args[@]}")

kitty @ set-background-opacity 1.0
cd $path
nvim 
kitty @ set-background-opacity 0.7

exec zsh
