function shaify_name -d "Rename a file to its SHA1 hash"
    for f in $argv
        set sha_value (sha1sum $f | cut -d' ' -f1)
        set ext (path extension $f)
        set dir (path dirname $f)
        set new_name "$dir/$md5$ext"
        echo "renaming $f to $new_name"
        mv $f $new_name
    end
end