function start-proxy --description "set terminal proxy"
    set -gx https_proxy http://127.0.0.1:8888
    set -gx http_proxy http://127.0.0.1:8888
    set -gx all_proxy socks5h://127.0.0.1:8889
    set_color green; echo "Proxy Started."
end

