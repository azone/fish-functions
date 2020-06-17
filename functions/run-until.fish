function run-until -d "Run a command until exit code is 0" -a interval
    set -l CMD ''
    set -l interval_value 2
    if string match -qr '^[0-9]+([.][0-9]+)?$' '$interval'
        set -x CMD $argv[2..-1]
        set -x interval_value $interval
    else
        set -x CMD $argv
    end

    while true
        eval $CMD
        if test $status -eq 0
            break
        end
        sleep $interval_value
    end
end
