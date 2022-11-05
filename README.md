# 安装
```shell
cargo install --git https://github.com/move-language/move move-cli --branch main
```

## 新建项目
```shell
move new <package_name> # Create a Move package <package_name> under the current dir
move new <package_name> -p <path> # Create a Move package <package_name> under path <path>
```

## 修改依赖
由于生成项目默认给的Move标准库是Git地址很慢，可以从https://github.com/diem/diem/tree/latest/language/move-stdlib下载Move的标准库放到本地，然后修改Move.toml文件：
```toml
[package]
name = "my-move"
version = "0.0.0"

[addresses]
std = "0x1"

[dependencies]
AptosStdlib = { local = "../aptos-stdlib" }
MoveStdlib = { local = "../move-stdlib" }
```
## 运行
```shell
move build // 编译并检查模块，但不会发布模块字节码
move sandbox publish -v // 在沙盒环境发布模块, 发布的模块会存储到本地的storage目录中
move sandbox run sources/debug_script.move --signers 0xf
```
