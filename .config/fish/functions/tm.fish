function tm -d "Start or attach to tmux session with the name of the current directory"
    set session_name (basename (pwd))

    if tmux has-session -t $session_name
        echo "tmux session '$session_name' already exists."
        tmux attach-session -t $session_name
    else
        tmux new-session -s $session_name
    end
end
