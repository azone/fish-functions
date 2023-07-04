function git-ui -d 'Open the git repo in Fork app'
    set FORK_PATH (mdfind kMDItemCFBundleIdentifier='com.DanPristupov.Fork' | head -n1 | string trim)
    if test -z $FORK_PATH
        git log --graph
        return 0
    end

    set REPO_PATH (git rev-parse --show-toplevel 2>/dev/null)
    if test -z $REPO_PATH
        set_color red; echo "No git repository found."; set_color normal
        return 0
    end
    set FORK_CLI "$FORK_PATH/Contents/Resources/fork_cli"
    $FORK_CLI $REPO_PATH
end
