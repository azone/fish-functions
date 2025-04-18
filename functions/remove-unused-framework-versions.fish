function remove-unused-framework-versions -d "Remove unused framework versions" -a dir
    if test -z $dir
        set dir /Applications
    end

    set frameworks (fd -t d -e framework --search-path $dir)
    for framework in $frameworks
        if not test -w $framework
            continue
        end

        set -l versions_dir "$framework""Versions"
        set -l current_dir "$versions_dir/Current"
        if test ! -d $versions_dir -o ! -L $current_dir
            continue
        end

        set -l current (readlink $current_dir)
        set -l unused_frameworks (fd --max-depth 1 -E "Current" -a -E "$current" --search-path $versions_dir)
        for unused in $unused_frameworks
            set_color green
            set -l size (du -sh $unused | cut -f1 | string trim)
            echo "Removing $unused($size)..."
            rm -rf $unused
        end
    end
end
