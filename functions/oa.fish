function oa --description="open Xcode project or workspace automatically using AppCode"
    if test (count $argv) -eq 0
        set -l PROJ *.xcworkspace
        if test -z $PROJ
            set PROJ *.xcodeproj
        end
        if test -z $PROJ && test -f "Package.swift"
            set PROJ Package.swift
        end
        if test -z $PROJ
            read -n 1 -p 'set_color yellow; echo  "Xcode workspace, project file or Swift Package not found, do you still want to open AppCode?[y/n]:"' result
            if begin test $result = "y"; or test $result = "Y"; end
                open -a AppCode
            end
        else
            open -a AppCode $PROJ 2>&1 >/dev/null
            if test $status -ne 0
                set_color red; echo "xcworkspace, xcodeproj or Package.swift not found."
            end
        end
    else
        open -a AppCode $argv
    end
end

