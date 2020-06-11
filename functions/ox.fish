function ox --description="open Xcode project or workspace automatically"
    if test (count $argv) -eq 0
        set -l PROJ *.xcworkspace
        if test -z $PROJ
            set PROJ *.xcodeproj
        end
        if test -z $PROJ
            read -n 1 -p 'set_color yellow; echo  "Xcode workspace or project file not found, do you still want to open Xcode?[y/n]:"' result
            if begin test $result = "y"; or test $result = "Y"; end
                open -a Xcode
            end
        else
            open -a Xcode $PROJ >/dev/null 2>&1
            if test $status -ne 0
                set_color red; echo "xcworkspace or xcodeproj not found."
            end
        end
    else
        open -a Xcode $argv
    end
end

