set expandtab
set shiftwidth=4
set tabstop=4
let g:ot=0

function! IsCursorAfterSpace()
    "return 1 if after space"
    let l:line = getline('.')
    let l:col = col('.')
    if l:col > 1 && l:line[l:col - 2] ==# ' '
        return 1
    else
        return 0
    endif
endfunction

function! IsCursorAfterPeriod()
    "return 1 if after period"
    let l:line = getline('.')
    let l:col = col('.')
    if l:col > 1 && l:line[l:col - 2] == '.'
        return 1
    else
        return 0
    endif
endfunction


function! InserTabWrapper(direction)
    if "backward" == a:direction
        let l:rtn1 = "\<c-n>"
        let l:rtn2 = "\<c-p>"
    else
        let l:rtn1 = "\<c-p>"
        let l:rtn2 = "\<c-n>"
    endif

    let l:col = col('.')

    if !pumvisible()
        let g:ot = 0
    endif

    if IsCursorAfterSpace() == 1
        return "\<tab>"
    elseif IsCursorAfterPeriod() == 1 && g:ot == 0
        let g:ot = 1
        set completeopt=menu,noinsert,noselect
                return "\<c-x>\<c-o>"
    elseif col > 1 && g:ot == 0

        set completeopt=menuone
        " return "\<c-p>"
        return rtn1
    elseif col > 1 && g:ot == 1
        set completeopt=menuone
        " return "\<c-n>"
        return rtn2
    else
        let g:ot = 0
        return "\<tab>"
    endif

endfunction

inoremap <tab> <c-r>=InserTabWrapper("forward")<cr>
inoremap <s-tab> <c-r>=InserTabWrapper("backward")<cr>

filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd filetype python set omnifunc=python3complete#Complete
autocmd filetype haskell set omnifunc=haskellcomplete#Complete
autocmd filetype xml set omnifunc=xmlcomplete#CompleteTags
autocmd filetype css set omnifunc=csscomplete#CompleteCSS
autocmd filetype html set omnifunc=htmlcomplete#CompleteTags
autocmd filetype php set omnifunc=phpcomplete#CompletePHP
autocmd filetype sql set omnifunc=sqlcomplete#Complete
autocmd filetype javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd filetype c set omnifunc=ccomplete#Complete
autocmd filetype ruby set omnifunc=rubycomplete#Complete
set completeopt=menuone
" set completeopt=menu,noinsert,noselect


"s/^/-- /<CR>"
"s/^-- /<CR>"

let g:Comment = ""
let g:EndComment = ""

autocmd filetype python let g:Comment = "# " | let g:EndComment = ""
autocmd filetype haskell let g:Comment = "-- " | let g:EndComment = ""
autocmd filetype vim let g:Comment = "\" " | let g:EndComment = ""
autocmd filetype html let g:Comment = "<!-- " | let g:EndComment = " -->"
autocmd filetype javascript let g:Comment = "// " | let g:EndComment = ""
autocmd filetype css let g:Comment = "/* " | let g:EndComment = " */"

"@ is split symbol, like /"
function! SimpleComment()
    if strpart(getline('.'),0,len(g:Comment)) == g:Comment
        execute ":s@^".g:Comment."@@g"
        execute ":s@".g:EndComment."$@@g"
    else
        execute ":s@^@".g:Comment."@g"
        execute ":s@$@".g:EndComment."@g"
    endif
endfunction

" the control slash C-/ is equivalent of C-_
vmap <C-/> :call SimpleComment()<CR>
vmap <C-_> :call SimpleComment()<CR>

