function pb -d "Package browser - browse installed packages. Provide mode all (default), orphaned or explicit" -a mode
    if not type --quiet paru || not type --quiet fzf
        echo "pb requires paru and fzf"
        exit 1
    end
    switch (echo $argv)
        case orphaned
        case o
            paru -Qdtq | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'
        case explicit
        case e
            paru -Qeq | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'
        case '*'
            paru -Qq | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'
    end
end
