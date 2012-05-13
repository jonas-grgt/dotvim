"#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           OS Specific options                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let os = substitute(system('uname'), "\n", "", "") 
let hn = substitute(system('hostname'), "\n", "", "") " hostname
if os == "Linux"
    colorscheme pablo
endif
if hn == "s7\.wservices\.ch"
    colorscheme default
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "                 Setup Taglist                                 "
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let Tlist_Ctags_Cmd="/home/jonasg/bin/ctags"
    let Tlist_Show_One_File=1
    nmap <silent> <F2> :TlistOpen<CR>
    nmap <silent> <F3> :TlistAddFiles  
endif

"filetype
filetype plugin on
filetype plugin indent on

"python settings
autocmd FileType python set omnifunc=pythoncomplete#Complete
:au FileType *.py set ts=4 sts=4 sw=4

"sass file settings
autocmd FileType sass set sts=2

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcompleteCompleteTags
autocmd FileType css set omnifunc=csscompleteCompleteCSS
autocmd FileType xml set omnifunc=xmlcompleteCompleteTags

"Omnicomplete options
set completeopt=menuone,longest,preview
set foldlevel=99
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"allows to move to a different buffer without saving the current first
set hidden

source ~/.vim/plugin/comments.vim
source ~/.vim/plugin/closetag.vim
source ~/.vim/bundle/surround/plugin/surround.vim
source ~/.vim/plugin/closebuffer.vim

set nu
syn on
set autoindent
set incsearch
set ai "auto indenting
set ic "insensitive search
set hls
set gdefault "Enables the /g option when using the substitute command :s.  
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
filetype plugin on
set ofu=syntaxcomplete



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
"map BD :bd<cr>
map BP :bp<cr>

map FF :FufFile<cr>
map FD :FufDir<cr>
map FB :FufBuffer<cr>

" next tab
map <TAB>n :tabnext<CR>
" next tab
map <TAB>b :tabprevious<CR>
" open new empty tab
map <TAB>o :tabnew<CR>
map <TAB>c :tabclose<CR>

noremap <C-w><C-g> <C-w>10+
noremap <C-w><C-s> <C-w>10-

nnoremap    CL :set cursorline!<CR>

highlight Search ctermfg=Black ctermbg=Green cterm=None


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

au BufRead,BufNewFile *.css  setlocal autoread 
au BufWrite *.styl  call CssParse() 
nmap <C-y> :call CssParse()<cr>

"Set the cursor to a full horizontal line
set cursorline
:hi CursorLine gui=NONE ctermbg=white cterm=NONE


"""""""""""""""""""""""""""""""""
"       buftabs settings        "
"""""""""""""""""""""""""""""""""
set laststatus=2
let g:buftabs_in_statusline=1
source ~/.vim/plugin/buftabs.vim
hi statusline ctermbg=white ctermfg=DarkGrey

set backupskip=/tmp/*,/private/tmp/*


function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":e ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Find file in current directory and edit it.
function! Find(name)
  let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")
nmap Ff :Find 

if has('python') && filereadable($VIRTUAL_ENV . '/.vimrc')
	source $VIRTUAL_ENV/.vimrc
endif

" setup supertab
"source ~/dotvim/bundle/supertab/plugin/supertab.vim
"


