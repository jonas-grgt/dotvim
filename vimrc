"""""""""""""""""""""""""""""""""
"           Pathogen            "
"""""""""""""""""""""""""""""""""
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"
let g:SuperTabDefaultCompletionType = "context"

set completeopt=menuone,longest,preview
set foldlevel=99
"allows to move to a different buffer without saving the current first
set hidden



"source ~/.vim/scripts/closetag.vim 
source ~/.vim/plugin/comments.vim
"source ~/.vim/scripts/minibufexpl.vim


set nu
syn on
set autoindent
set incsearch
set ai "auto indenting
set ic "insensitive search
set hls
set gdefault "Enables the /g option when using the substitute command :s.  


colorscheme default

set dictionary+=/usr/share/dict/words


filetype plugin on
filetype indent plugin on
filetype on
"let g:pydiction_location = "/Users/Jonas/.vim/scripts/pydiction/complete-dict"


"""""""""""""""""""""""""""""""""
" Remapping of files
"""""""""""""""""""""""""""""""""
map TT :TlistToggle<cr>
map TU :TlistUpdate<cr>

map NHL :nohl<cr>
map ss :w<cr>

map WN :wnext<cr>
map NN :next!<cr>

map BN :bn<cr>
map BD :bd<cr>
map BP :bp<cr>

map FF :FufFile<cr>
map FD :FufDir<cr>
map FB :FufBuffer<cr>


noremap <leader>) <c-]>

:au BufNewFile,BufRead *.tex map £ :!open -a /Applications/Preview.app/Contents/MacOS/Preview %:t:r.pdf<cr><cr>
:au Bufnewfile,bufread *.tex map ° :!pdflatex %:h/%:t:r.tex<cr><cr>
":au Bufnewfile,bufread *.tex map ° :!pdflatex escape("%:h", "/")/%:t:r.tex<cr>



set expandtab
"set textwidth=79
set tabstop=8
set softtabstop=4
set shiftwidth=4

let g:cssparse="styl"

filetype plugin on
set ofu=syntaxcomplete

""              ""
" File Templates "
""              ""
":au BufNewFile *.html e ~/.vim/templates/html
":au BufNewFile *.py e ~/.vim/templates/python





function CssParse()
    if g:cssparse == "styl"

        let l:file=expand("%:p")
        "TODO until possible bug is fixed within stylus
        "MOve the directory containing l:file 
        "Run stylus
        "Return the previous working directory
        let l:nfile = substitute(l:file, ".styl$", ".css", "*")
        execute ':silent !stylus < '. shellescape(l:file, 1) .
                           \' > '.shellescape(l:nfile, 1)
    endif
endfunction

function StylusInit()
    setl sts=2
endfunction

au BufRead,BufNewFile *.styl  call StylusInit()
au BufRead,BufNewFile *.css  setlocal autoread 
au BufWrite *.styl  call CssParse() 
nmap <C-y> :call CssParse()<cr>


