function trim-arch -d "Trim unused architecture from a binary or path" -a binary_path
    if test -z $binary_path
        set_color red
        echo "Binary path is required"
        set_color normal
        return 1
    else if not test -f $binary_path -o -d $binary_path
        set_color red
        echo "Binary path does not exist: $binary_path"
        set_color normal
        return 1
    end

    if xattr -p com.apple.appstore.metadata $binary_path &>/dev/null
        set_color green
        echo "$binary_path is installed by App Store, Skipped."
        return 0
    end

    set -l before_size (du -sh $binary_path | cut -f1)
    if test -f $binary_path
        _trim_arch_binary $binary_path
    else
        set -l paths (fd -t x --search-path $binary_path)
        for path in $paths
            _trim_arch_binary $path
        end
    end

    set -l after_size (du -sh $binary_path | cut -f1)
    if test $before_size = $after_size
        set_color yellow
        echo "Binary is already trimmed: $binary_path"
        set_color normal
        return 0
    end

    set_color -o brgreen
    echo "Totally Trimmed $before_size to $after_size: $binary_path"
    set_color normal
end

function _trim_arch_binary -a binary_path
    if xattr -p com.apple.appstore.metadata $binary_path &>/dev/null
        set_color green
        echo "$binary_path is installed by App Store, Skipped."
        return 0
    end

    set -l ARCH (arch)
    set -l lib_archs (lipo $binary_path -archs 2>/dev/null | string trim)

    if test -z $lib_archs
        # set_color red
        # echo "$binary_path is not a Mach-O binary" >&2
        # set_color normal
        return 1
    end

    if not test -w $binary_path
        set_color red
        echo "Binary is not writable: $binary_path"
        set_color normal
        return 1
    end

    set -l arch_count (echo $lib_archs | wc -w | string trim)
    if test $arch_count -eq 1
        if test $lib_archs != $ARCH
            set_color green
            echo "Binary only has one architecture($lib_archs): $binary_path"
            set_color normal
        end

        return 0
    end

    set -l before_size (du -sh $binary_path | cut -f1)
    lipo $binary_path -thin $ARCH -output $binary_path
    set -l after_size (du -sh $binary_path | cut -f1)
    set_color green
    echo "Trimmed $before_size to $after_size: $binary_path"
    set_color normal
end
