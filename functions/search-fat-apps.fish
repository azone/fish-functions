function search-fat-apps -a apps_path -d "Search fat architecture apps"
    if test -z $apps_path
        set apps_path /Applications
    end

    if not test -d $apps_path
        set_color red
        echo "$apps_path is not a directory" >&2
        set_color normal
        return 1
    end

    set -l all_apps (fd --search-path $apps_path -t d -e app)
    set -l appstore_apps
    for app in $all_apps
        if xattr -p com.apple.appstore.metadata $app &>/dev/null
            set -a appstore_apps "$app"
        end
    end

    for app in $all_apps
        if _is_subapp $app
            continue
        end

        if contains $app $appstore_apps
            continue
        end

        if _has_fat_binary $app
            echo $app
        end
    end
end

    function _is_subapp -a app
        set -l app_path "$(realpath $app)/"
        set app_count (echo $app_path | rg -F '.app/' --count-matches)
        if test $app_count -ge 2
            return 0
        end

        return 1
    end

    function _has_fat_binary -a app
        set -l binaries (fd -t x --search-path $app)
        for binary in $binaries
            set -l archs (lipo $binary -archs 2>/dev/null | string trim)
            set -l arch_count (echo $archs | wc -w | string trim)
            if test $arch_count -ge 2 && string match -q "*$(arch)*" $archs
                return 0
            end
        end

        return 1
    end
