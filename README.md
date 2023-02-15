# fish-functions
自己写的一些平时自己常用的 fish shell 函数

# 使用说明

`find_same_file`：查找与指定目录下指定文件相同的文件（通过 md5 查找）

```fish
find_same_file FILE SEARCH_DIRECTORY
```

`less`：使用 vim 的 less 代替系统的 less

`ls`：使用 [exa](https://github.com/ogham/exa) 来代替系统的 ls

`ox`：打开 Xcode，如果当前目录下有 Xcode 的 workspace 或者 xcodeproj 则打开，如果没有会询问是否打开 Xcode，使用方法：

```fish
ox [xxx.xcworkspace | xxx.xcodeproj]
```

`oa`：功能和使用方法和 `ox` 类似，只不过是通过 AppCode 打开

`pod`：判断当前目录下是否有 Gemfile 文件并且 Gemfile 文件中是否包含 cocoapods 来决定是通过全局安装的 pod 还是 Gemfile 指定的 pod，使用方法和 pod 完全一样。

`fastlane`：判断当前目录下是否有 Gemfile 文件并且 Gemfile 文件中是否包含 fastlane 来决定是通过全局安装的 pod 还是 Gemfile 指定的 fastlane，使用方法和 fastlane 完全一样。

`start-proxy` 和 `stop-proxy`：设置和停止终端代理，如果你想使用的话可能需要自己更改代理地址和端口

`vs`：打开 Visual Studio Code，如果没有指定需要打开的文件夹或者文件，则默认打开当前文件夹。

`run-until`: 执行指定命令，直到成功为止

```fish
# 使用用法
run-until [INTERVAL] COMMAND
```

---

git alias
```ini
[alias]
  sync = !git pull && git push # 先 pull 再 push
  sorted-branches = branch --sort -committerdate -v # 按照提交时间显示分支，后面可以加 -a/-r/-l 分别表示所有、远程和本地分支
  graph = log --all --graph --simplify-by-decoration # 简化显示 git log 信息（只显示分支和 tag 及合并关系）
  copy-branch = !git branch --show-current | xargs | pbcopy # 拷贝当前分支名到粘贴板
```
