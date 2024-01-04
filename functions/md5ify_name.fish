function md5ify_name -d "md5ify a file name"
    for f in $argv
        set md5 (md5sum $f | cut -d ' ' -f 1)
        set ext (path extension $f)
        set dir (path dirname $f)
        set new_name "$dir/$md5$ext"
        echo "renaming $f to $new_name"
        mv $f $new_name
    end
end