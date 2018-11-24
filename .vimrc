"关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible

"配置backspace键工作方式
set backspace=indent,eol,start

"显示行号
set number

"设置在编辑过程中右下角显示光标的行列信息 
set ruler 

"当一行文字很长时取消换行
set nowrap

"在状态栏显示正在输入的命令
set showcmd

"设置历史记录条数
set history=1000

"开启语法高亮功能
syntax enable
syntax on

"设置编码方式
set encoding=utf-8

"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"设置换行符为unix
set ff=unix

"检测文件类型
filetype on

"针对不同的文件采用不同的缩进方式
filetype indent on

"允许插件
filetype plugin on

"启动智能补全
filetype plugin indent on
