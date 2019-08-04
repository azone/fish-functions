function find_same_file --description '查找 MD5 与传输值相同的文件'
  if [ (count $argv) -lt 1 ]
    echo '参数不足：find_same_file FILE [SEARCH_PATH]'
    return 1
  end

  set -l extension (echo $argv[1] | awk -F . '{print $NF}')

  command -sq rg
  set -l _is_ripgrep_installed $status
  if [ $_is_ripgrep_installed -eq 0 ]
    set grep_cli rg
  else
    set grep_cli grep
  end

  set -l md5_hash (md5 -q $argv[1])

  set search_path (pwd)
  if [ (count $argv) -gt 1 ]
    set search_path $argv[2]
  end

  command -sq fd
  set -l _is_fd_installed $status
  if [ $_is_fd_installed -eq 0 ]
    fd -e $extension --search-path $search_path -exec md5 -r '{}' | $grep_cli $md5_hash | cut -d' ' -f2
  else
    find $search_path -iname "*.$extension" -exec md5 -r '{}' \; | $grep_cli $md5_hash | cut -d' ' -f2 
  end
end
