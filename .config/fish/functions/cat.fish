function cat -d "Use bat instead of cat if bat is available"
    if not test -f $argv
        echo "File not found: $argv"
        return 0
    end
    if not type --quiet bat
        cat $argv
        return 0
    end
    command bat --style plain $argv
end
