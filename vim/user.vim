" 用户属性配置文件
" 
"{{{ 通用属性配置
" 关闭vi一致性
set nocompatible

"中文乱码
set encoding=utf-8
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set termencoding=utf-8

"新文件格式
set fileformat=unix
set fileformats=unix,dos,mac

"禁止UTF-8 BOM
set nobomb
" }}}
syntax enable
syntax on

"设置制表符缩进
set ts=4
set expandtab

"继承缩进
set autoindent
set shiftwidth=4

" 突出显示当前行列
set cursorline
set cursorcolumn

" 关闭响铃
set vb t_vb=
" 关闭闪烁
autocmd GuiEnter * set t_vb=

" 取消光标闪烁
set gcr=a:block-blinkon0

"{{{ 上次文件编辑位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}}
" 设置在状态行显示的信息
" set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)
" 设置状态行
function! HighlightSearch()  
      if &hls  
          return 'H'  
      else  
          return ''  
      endif  
endfunction
set statusline=  
set statusline+=%7*\[%n]                                  "buffernr  
set statusline+=%1*\ %<%F\                                "文件路径  
set statusline+=%2*\ %y\                                  "文件类型  
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "编码1  
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "编码2  
set statusline+=%4*\ %{&ff}\                              "文件系统(dos/unix..)   
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "语言 & 是否高亮，H表示高亮?  
set statusline+=%8*\ %=\ row:%l/%L(%03p%%)             "光标所在行号/总行数 (百分比)  
set statusline+=%9*col:%03c\                            "光标所在列  
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Read only? Top/bottom

let mapleader = ";"

" 配置local leader
let maplocalleader = ","

" 快速关闭
noremap <Leader>q <ESC>:q<CR>
" 快速保存
noremap <Leader>w <ESC>:w<CR>

" 设置展开折叠
nnoremap <space> za

" 搜索时高亮显示文本,输入搜索内容时就显示搜索结果
set hlsearch
set incsearch

" 上下可视行数
set scrolloff=6
 
" 不设定在插入模式下无法使用退格键
set backspace=indent,eol,start

" 启用折叠
set foldenable
" 设置语法折叠
set foldmethod=syntax
" 设置折叠区域的宽度
set foldcolumn=0
" 设置折叠层数为
setlocal foldlevel=1

" 智能匹配
set smartcase

" 显示输入的命令
set showcmd
" 命令行(在状态行下)的高度，设置为1
set cmdheight=1

" 设置魔术
set magic

" 字符间插入的像素行数目  
set linespace=0

" 为C程序提供自动缩进  
set smartindent

" 设置 alt 键不映射到菜单栏
set winaltkeys=no

"界面设置
set number
" 设置相对行号
" set relativenumber
set numberwidth=6
set laststatus=2
set cursorline

" 设置当前vim的工作目录
execute "cd $HOME"

" {{{ 配置python的特殊配置
function PythonFileConf()
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix 
set foldmethod=indent
endfunction
" }}}

" 调用python
autocmd BufRead,BufNewFile *.py call PythonFileConf()

colorscheme gruvbox

" nnoremap <Leader>al :set nohls<CR>
" hi VertSplit term=reverse cterm=reverse gui=none guibg=Grey10 guifg=White
" set fillchars=vert:\
set tags=./.tags;,.tags

" {{{ 对任意的vim脚本使用marker折叠方法
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
