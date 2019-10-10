function less --wraps less --description="Using vim's less instead of system less"
    set VIMRUNTIME (vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015')
    "$VIMRUNTIME/macros/less.sh" $argv
end
