function killonport --argument port
    if test -z "$port"
        echo "Usage: killonport <port_number>"
        return 1
    end

    # Capture the PID(s) into a variable
    set -l pids (sudo lsof -t -i :$port -sTCP:LISTEN)

    if test -n "$pids"
        # If PIDs exist, kill them
        echo "Found process(es) $pids on port $port. Killing..."
        echo $pids | xargs sudo kill -9
        echo "Port $port is now clear."
    else
        # If the variable is empty
        echo "Nothing is listening on port $port."
        return 1
    end
end
