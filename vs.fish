function vs --description="Open using Visual Studio Code"
    if test (count $argv) -eq 0
        open -a Visual\ Studio\ Code .
    else
        open -a Visual\ Studio\ Code $argv
    end
end