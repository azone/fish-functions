function stop-proxy --description="unset terminal proxy"
    set -ge https_proxy
    set -ge https_proxy
    set -ge all_proxy

    set_color red; echo "Proxy Stopped."
end

