set nocompatible
filetype off
filetype plugin indent on
"there's no space in options or parameters, otherwise, it will be errors"
"encoding error, set fileencoding and reload, not set encoding"
"vim character override issue, caught by default ~/.bashrc, delete it and touch new ~/.bashrc will be fine"
set number
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,utf-8-bom,ucs-bom,cp936,big5,gbk,utf-16,utf-16le
set termencoding=utf-8
set fileformats=unix,dos
set expandtab
set shiftwidth=4
set tabstop=4
set clipboard^=unnamed,unnamedplus
"colorscheme happy_hacking"
"colorscheme github"
filetype plugin indent on
syntax on
set hidden
"disable macro recording"
map q <Nop>
"end"
