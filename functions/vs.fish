function vs --description="Open using Visual Studio Code"
    if string match -qv "Darwin" (uname -s)
        set_color red; echo "macOS Only"
    end

    set -l bundle_id "com.microsoft.VSCode"

    if test (count $argv) -eq 0
        open -b $bundle_id .
    else
        open -b $bundle_id $argv
    end
end
