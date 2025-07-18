function vs-extensions-cleanup -d "Cleanup VS Code unused extensions"
    set -l ext_path "$HOME/.vscode/extensions"
    set -l json_file "$ext_path/extensions.json"
    if not test -f $json_file
        set_color red
        echo "$json_file does not exist."
        return 1
    end
    set -l extensions (cat $json_file | jq '.[].location.path' --raw-output | path basename)
    set -l all_extensions (fd --base-directory $ext_path -t d --max-depth 1)
    for ext in $all_extensions
        set -l ext_base (path basename $ext)
        if not contains $ext_base $extensions
            set_color yellow
            echo Removing $ext_base...
            set_color normal
            rm -rf "$ext_path/$ext"
        end
    end
end
