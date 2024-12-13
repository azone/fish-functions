function pod --description="execute pod dynamically" --wraps "pod"
    if test -f Gemfile && grep --silent 'cocoapods' Gemfile
        bundle info cocoapods 2>&1 >/dev/null
        if test $status -ne 0
            set_color red; echo "cocoapods not installed, please execute \"bundle install\" to install." >&2
            return 1
        end
        bundle exec pod $argv
    else
        set -l POD_SHELL (which pod)
        if test $status -ne 0
            set_color red; echo "pod command not found, please make sure Cocoapods was installed." >&2
            return 2
        end
        $POD_SHELL $argv
    end
end

