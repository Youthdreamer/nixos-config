_: {
  programs.vim.enable = true;
  programs.vim.extraConfig = ''
        " =========================
    " 基本行为
    " =========================
    set nocompatible          " 不兼容 vi 老模式
    set encoding=utf-8
    set fileencoding=utf-8
    set hidden                " 允许切换 buffer 不保存
    set mouse=a               " 启用鼠标
    set clipboard=unnamedplus " 使用系统剪贴板（Wayland/X11）

    " =========================
    " 显示相关
    " =========================
    set number                " 行号
    set relativenumber        " 相对行号
    set cursorline            " 高亮当前行
    set showcmd               " 显示正在输入的命令
    set showmode              " 显示模式
    set ruler                 " 显示光标位置
    set signcolumn=yes        " 永远显示符号列（避免抖动）

    " =========================
    " 缩进 / 格式
    " =========================
    set tabstop=2             " Tab 显示宽度
    set shiftwidth=2          " 缩进宽度
    set softtabstop=2
    set expandtab             " Tab 转空格
    set autoindent
    set smartindent

    " =========================
    " 搜索
    " =========================
    set ignorecase            " 搜索忽略大小写
    set smartcase             " 有大写则区分
    set incsearch             " 实时搜索
    set hlsearch              " 高亮搜索结果

    " 取消搜索高亮
    nnoremap <Esc> :nohlsearch<CR>

    " =========================
    " 编辑体验
    " =========================
    set backspace=indent,eol,start
    set wrap                  " 自动换行
    set linebreak             " 不在单词中断行
    set scrolloff=5           " 上下保留 5 行
    set sidescrolloff=5

    " =========================
    " 语法 & 文件类型
    " =========================
    syntax on
    filetype plugin indent on
  '';
}
