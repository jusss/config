"autocomplete supertab, indent tab, highlight build-in, comment keybind, F5-run keybind"
set nocompatible
filetype on
filetype plugin on
filetype plugin indent on
"there's no space in options or parameters, otherwise, it will be errors"
"encoding error, set fileencoding and reload, not set encoding"
"vim character override issue, caught by default ~/.bashrc, delete it and touch new ~/.bashrc will be fine"
set number
"set cursorline"
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
syntax on
set hidden
"disable macro recording"
map q <Nop>
"F5 run"
let current_filename = expand('%:t')
if stridx(current_filename,'.hs') > 0
    nnoremap <F5> <esc>:w<enter>:!runghc %:p<enter>
    inoremap <F5> <esc>:w<enter>:!runghc %:p<enter>
elseif stridx(current_filename, '.py') > 0
    nnoremap <F5> <esc>:w<enter>:!python %:p<enter>
    inoremap <F5> <esc>:w<enter>:!python %:p<enter>
"else
    "echom 'unsupport'
endif

"nnoremap <C-r> <esc>:w<enter>:!runghc %:p<enter>"
"inoremap <C-r> <esc>:w<enter>:!runghc %:p<enter>"

"avoid Press ENTER or type command to continue"
set shortmess+=F

"vim scp://root@moon:22//root/a.hs"
"if the only one slash, it means $HOME path"
"so vim scp://root@moon:22/a.hs, is /root/a.hs on remote"
"nnoremap <F6> <esc>:w<enter>:!ssh root@moon runghc /root/%:t<enter>"
"inoremap <F6> <esc>:w<enter>:!ssh root@moon runghc /root/%:t<enter>"

"vim scp://leo@moon/~/a.hs"
"could be vim scp://leo@moon/a.hs"
nnoremap <F6> <esc>:w<enter>:!ssh leo@moon runghc /home/leo/%:t<enter>
inoremap <F6> <esc>:w<enter>:!ssh leo@moon runghc /home/leo/%:t<enter>

"also you can set :let $PRO="scp://root@moon:22"
"then :tabe $PRO/a.hs"

"about the port you can do it in .ssh/config"
"Host moon"
" HostName ip"
" User root"
" IdentityFile ~/.ssh/id_rsa"
" Port port"

"write this into ~/.ssh/config"
"ServerAliveInterval 120"
"ControlPersist 2h"
"ControlMaster auto"
"ControlPath ~/.ssh/master-%r@%h:%p"
"then create the connection, with ssh -p 22 -N root@moon"
"now vim scp://root@moon:22/a.hs will be very fast"

"install supertab for auto-complete"
"comment"
"map <F3> :s/^/-- /<CR>"
"map <F4> :s/^-- /<CR>"
":vsplit, :hsplit"
"move in split windows with C-l"
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
"AcpDisable to disable autocomplpop"
let g:AutoComplPopDontSelectFirst = 1

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 0
" when pop menu, candidate is the first, press Enter will not complete and just newline, selected == 0 is the first candidate, -1 is not choose, complete_info need vim8.2"
" pumvisible is true if there is a pop up menu"
inoremap <expr> <CR> pumvisible() ? (complete_info().selected == -1 ? '<C-e><CR>' : '<CR>') : '<CR>'

set undofile
"set undodir=$HOME/.cache/vim/undo/"
set undodir=$HOME/.vim/

"command mode, C-d back to shell, C-d in shell back to vim"
noremap <C-d> :sh<CR>

" C-/ to comment or uncomment, nerdcommenter plugin"
let NERDSpaceDelims=1
if has ('win32')
    nmap <C-/> <leader>c<Space>
    vmap <C-/> <leader>c<Space>
else
    nmap <C-_> <leader>c<Space>
    vmap <C-_> <leader>c<Space>
endif

" use :%s/\<old\>/new/g to replace variable, g mean multiple in one line"
" c mean confirm if come with g, % mean all line, \<old\> start and end only with old"
" or on the old, press * will fully match, :%s//new/g"
" // will replace the last search by * # or /"
" or V/old:s//new/g, search old in a block then replace"
" vimrc use . to concate string"
function! Rename()
  let new = input('New name: ')
  execute '%s//'.new.'/g'
endfunction

" use * match variable, press F3 to rename them all"
nnoremap <F3> :call Rename()<CR>

" Uncomment the following to have Vim jump to the last position when reopening a file"
if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
set showmatch
set hlsearch
" vim ~/.ctags, -python-kinds=-i"
" ctags -R -o ~/.vim/python-tags ~/project"
" use C-] to jump, and C-t jump back"
set tags=~/.vim/python-tags

" C-v then Alt-n to insert ^[n for key mapping to tabnext"
" :tabe or :tabnew new-tab, open new file"
" vim -p file1 file2 will open multiple tabs"
"nnoremap n :tabnext<CR>
"inoremap n <esc>:tabnext<CR>
"nnoremap p :tabprevious<CR>
"inoremap p <esc>:tabprevious<CR>
"esc p equal to alt p, so don't use alt p as tabs switch
nnoremap <C-f> :tabnext<CR>
inoremap <C-f> <esc>:tabnext<CR>
nnoremap <C-b> :tabprevious<CR>
inoremap <C-b> <esc>:tabprevious<CR>

"use :e to do :tabe"
cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'tabe' : 'e'

" ssh is slowly, ssh over kcptun is better"
" ./server_linux_amd64 -t "127.0.0.1:ssh-port" -l ":listen-port" -mode fast3 -nocomp -sockbuf 16777217 -dscp 46"
" ./client_linux_amd64 -r "server-ip:listen-port" -l ":local-listen-port" -mode fast3 -nocomp -autoexpire 900 -sockbuf 16777217 -dscp 46"
" ssh -N -p local-listen-port user@localhost"
" vim scp://user@localhost:local-listen-port/file"
" :let $a="scp://user@localhost:local-listen-port""
" :e $a/a.hs"

execute pathogen#infect()

" ale linter
let g:ale_linters ={'haskell': ['hlint', 'hdevtools', 'hfmt'],}

" syntastic linter
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" git clone https://github.com/KenN7/vim-arsync.git
" vim ~/remote/project/.vim-arsync # this need to be in the root of project which need to rsync
" remote_host remote
" remote_user user
" remote_port port
" remote_path ~/project/
" local_path /home/user/remote/project/
" auto_sync_up 1
" remote_or_local remote
" sleep_before_sync 0
" then cd ~/remote/project and vim files, :w will rsync to remote





"end"
