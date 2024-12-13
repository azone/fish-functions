function fastlane --description="execute fastlane dynamically" --wraps "fastlane"
    if test -f Gemfile && grep --silent 'fastlane' Gemfile
        bundle info fastlane 2>&1 >/dev/null
        if test $status -ne 0
            set_color red; echo "fastlane not installed, please execute \"bundle install\" to install." >&2
            return 1
        end
        bundle exec fastlane $argv
    else
        set -l FASTLANE_SHELL (which fastlane)
        $FASTLANE_SHELL $argv
    end
end

