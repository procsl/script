if has('nvim')
    call plug#begin()
else
    call plug#begin('$VIUMFILES/bundle')
endif

" {{{ markdown 语法高亮插件
Plug 'plasticboy/vim-markdown', {'for':'markdown'}
" }}}

" {{{ markdown 实时预览插件
Plug 'iamcco/markdown-preview.vim' , {'for':'markdown'}
" 数学排版插件
Plug 'iamcco/mathjax-support-for-mkdp', {'for':'markdown'}
let g:mkdp_path_to_chrome = ""
let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
let g:mkdp_auto_start = 0
let g:mkdp_auto_open = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
" MarkdownPreview 启动命令
" StopMarkdownPreview 停止命令
" }}}

" {{{ session 插件
" Plug 'xolox/vim-session'
" }}}

" {{{ 缩进线插件
Plug 'Yggdroot/indentLine', {'for':[  'java', 'javascript', 'c', 'cpp', 'python', 'rust', 'css', 'html' ] }
" Vim
" let g:indentLine_color_term = 239
" GVim
" let g:indentLine_color_gui = '#A4E57E'
" Background (Vim, GVim)
" let g:indentLine_bgcolor_term = 202
" let g:indentLine_bgcolor_gui = '#FF5F00'
" 缩进线字符
" let g:indentLine_char = '|'
" }}}

" {{{  著名js库高亮插件
Plug 'othree/javascript-libraries-syntax.vim',{'for': [ 'json', 'js' ]}
" }}}

"{{{ python重构库
Plug 'python-rope/rope' , {'for':'python'}
"}}}

" {{{ 代码片段插件
Plug 'SirVer/ultisnips' , {'for':[  'c', 'cpp', 'html', 'js', 'css', 'python' ,'java', 'markdown']}
Plug 'honza/vim-snippets', {'for': [ 'c', 'cpp', 'html', 'js', 'css', 'python','java', 'markdown' ]}
" let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsExpandTrigger='<C-CR>'
let g:UltiSnipsListSnippets = '<C-L>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
" 使用python3
" let g:UltiSnipsUsePythonVersion = 3
" 添加映射
" inoremap <NL> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":IMAP_Jumpfunc('', 0)<CR>
" }}}

"{{{ 书签插件
Plug 'kshenoy/vim-signature'
"}}}

"{{{ 调试插件
Plug 'cpiger/NeoDebug',{'on':'NeoDebug', 'for':[ 'c','cpp' ]}
"}}}

"{{{ maven插件
Plug 'mikelue/vim-maven-plugin',{'for':'java'}
"}}}

" {{{  自动补全括号插件
Plug 'Raimondi/delimitMate'
" 关闭某些类型文件的自动补全
autocmd FileType vim let b:delimitMate_autoclose = 0
" }}}

" {{{ 快速插入括号
Plug  'tpope/vim-surround'
" }}}

" {{{ 模板插件
Plug 'aperezdc/vim-template'
" }}}

"{{{ 代码格式化插件
Plug 'Chiel92/vim-autoformat',{'on':'Autoformat', 'for':[ 'javascript', 'html', 'css', 'python' ]}
" 用于格式化的外部程序, 应使用绝对路径
" let g:formatterpath = ['/some/path/to/a/folder', '/home/superman/formatters']
" 创建格式化快捷键
noremap <F3>: Autoformat<CR>
" 保存文件时格式化
" autocmd  BufWrite  *: Autoformat
" }}}

" {{{ 搜索插件,该插件主要用于在大型项目中查找文件.缓冲区.mrus.标签
Plug 'Yggdroot/LeaderF', {'do': '.\install.bat'}
let g:Lf_ShortcutF = '<Leader>ff'
" }}}

"{{{ 文本对象
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', {'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter' , {'for':['c', 'cpp', 'vim', 'java'] }

"}}}

"{{{ 异步运行插件
Plug 'skywind3000/asyncrun.vim',{'on':'AsyncRun'}
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
" let g:asyncrun_bell = 1
" 设置 F2 打开/关闭 Quickfix 窗口
nnoremap <F2> :call asyncrun#quickfix_toggle(6)<cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
" let g:asyncrun_encs = 'gbk'
"}}}

"{{{ 用于管理标签文件的插件
" Plug 'ludovicchabant/vim-gutentags',{'for':['c', 'cpp', 'java', 'python', 'javascript'] }
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
"}}}

" {{{ 参数补全插件
" Plug 'tenfyzhong/CompleteParameter.vim', {'for':['java', 'c', 'cpp', 'python', 'javascript']}
" inoremap <silent><expr> ( complete_parameter#pre_complete("()")
" smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" }}}

" {{{ 彩虹括号配置文件
Plug 'luochen1990/rainbow'
" 启用彩虹括号
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}
" }}}

" {{{ 快速注释插件
Plug  'scrooloose/nerdcommenter'
"  默认自动添加空格
let g:NERDSpaceDelims = 1
" 将符合行的注释分隔符对齐而不是按照代码缩进
let g:NERDDefaultAlign = 'left'
" 取消注释时启用尾随空白的修剪
let g:NERDTrimTrailingWhitespace = 1
" }}}

" {{{ 状态栏插件
Plug  'vim-airline/vim-airline'
" Plug 'liuchengxu/eleline.vim'
" Plug  'vim-airline/vim-airline-themes', {'on':'AirlineRefresh'}
" 防止特殊符号无法正常显示
set ambiwidth=double
" 启用power字体
let g:airline_powerline_fonts = 1
" 设置状态栏主题
" let g:airline_theme='vimtex'
" 默认禁用选项卡
" let g:airline#extensions#tabline#enabled = 1
nnoremap <Leader>bf call ChangeTabline()
" 选项卡分隔符
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'
" 左侧使用的分隔符

let g:airline_left_sep = '►'
" let g:airline_left_alt_sep = '⮁'
" 右侧使用的分隔符
let g:airline_right_sep = '◄'
" let g:airline_right_alt_sep = '⮃'
" 设置tab键映射
nnoremap <tab> :bn<cr>

" 设置状态行
function SetAirline()
    let g:airline_symbols.branch = '----'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭠'
    let g:airline_symbols.maxlinenr = ''
endfunction
" 这是Airline的bug
" if !has('nvim')
"     autocmd BufEnter * call SetAirline()
" endif
" }}}

" {{{ 语法检查插件
" Plug  'w0rp/ale' ,{'for':[ 'javascript', 'css', 'html', 'python']}
" 保持侧边栏可见
let g:ale_sign_column_always = 1
" 错误和警告标识符
let g:ale_sign_error = '→'
let g:ale_sign_warning = '✶'
" 改变状态栏信息格式
" let g:ale_statusline_format = ['E %d', 'W %d', 'S ok']
" 改变命令行消息
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"添加检测完成后回调：
"augroup YourGroup
"autocmd!
"autocmd User ALELint call YourFunction()
"augroup END
"自定义跳转错误行快捷键：
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_linters={'javascript':['eslint']}
" }}}

" {{{ html 插件
Plug 'othree/html5.vim',{'for':['html', 'css']}
Plug  'mattn/emmet-vim',{'for':[ 'html','css' ]}
" let g:user_emmet_install_global = 0
" 重新定义触发键
let g:user_emmet_leader_key='<C-c>'
" }}}

" {{{ 树形目录插件
Plug  'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
noremap <F4> :NERDTreeToggle<CR>
" let g:NERDTreeDirArrowExpandable = '►'
" let g:NERDTreeDirArrowCollapsible = '▾'
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 显示行号
" let NERDTreeShowLineNumbers=1
" 指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
let NERDTreeMouseMode=1
" 确定是否改变Vim的CWD
let NERDTreeChDirMode=1
" 状态栏
let NERDTreeStatusline=1
" 窗口位置
let NERDTreeWinPos='left'
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 当vim中没有其他文件，值剩下nerdtree的时候，自动关闭窗口
" 本来想做一些处理,比如说关闭ycm的服务器, 但是没有成功, 并不知道怎么关闭
function CloesVim()
    " execute "!python"
    execute "q"
endfunction
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | call CloesVim() | endif
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" 支持git标志
Plug  'Xuyuanp/nerdtree-git-plugin' ,  {'on': 'NERDTreeToggle'}
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✶",
            \ "Staged"    : "♪",
            \ "Untracked" : "",
            \ "Renamed"   : "",
            \ "Unmerged"  : "",
            \ "Deleted"   : "",
            \ "Dirty"     : "",
            \ "Clean"     : "",
            \ 'Ignored'   : "",
            \ "Unknown"   : ""
            \ }
" }}}

"{{{ 平滑滚动插件
Plug  'terryma/vim-smooth-scroll'
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" }}}

" {{{ 快速跳转
Plug  'Lokaltog/vim-easymotion'
let g:EasyMotion_smartcase = 1
noremap <Leader><leader>h <Plug>(easymotion-linebackward)
noremap <Leader><Leader>j <Plug>(easymotion-j)
noremap <Leader><Leader>k <Plug>(easymotion-k)
noremap <Leader><leader>l <Plug>(easymotion-lineforward)
noremap <Leader><leader>. <Plug>(easymotion-repeat)
" }}}

" {{{ 代码补全插件
Plug 'Valloric/YouCompleteMe',{'on':'YCM','for':['java', 'javascript', 'python', 'c', 'cpp', 'typescript', 'rust', 'css', 'html','ts']}
" 允许自动加载.ycm_extra_conf.py，不再提示
" let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf = '$VIM\.ycm_extra_conf.py'
" let g:ycm_global_ycm_extra_conf = 'no'
" 开始补全的字符数
" let g:ycm_min_num_of_chars_for_completion=2
" python解释器路径
let g:ycm_python_binary_path = 'python.exe'
" let g:ycm_python_binary_path = 'python3.exe'
" java 静态检查工具
" let g:syntastic_java_checkers = []
" 是否开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
" 是否在注释中也开启补全
" let g:ycm_complete_in_comments=1
" let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 补全后自动关闭预览窗口
" let g:ycm_autoclose_preview_window_after_completion=1
" 字符串中也开启补全
" let g:ycm_complete_in_strings = 1
" 配置错误和警告标识符✶
let g:ycm_error_symbol = '→'
let g:ycm_warning_symbol = '✶'
" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 回车即选中当前项
" inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<C-SPACE>'
" 屏蔽代码诊断信息,否
" let g:ycm_show_diagnostics_ui = 1
" ycm 日志信息
let g:ycm_server_log_level = 'error'
" YCM相关快捷键
" }}}
"
"{{{ typescript 语法高亮
Plug 'leafgarland/typescript-vim'
"}}}
call plug#end()
