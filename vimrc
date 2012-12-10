"filetype
filetype plugin on
filetype plugin indent on

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd FileType sass set sts=2
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcompleteCompleteTags
autocmd FileType css set omnifunc=csscompleteCompleteCSS
autocmd FileType xml set omnifunc=xmlcompleteCompleteTags

set completeopt=menuone,longest,preview "Omnicomplete options
set foldlevel=99
set hidden "allows to move to a different buffer without saving the current first
set nu
set autoindent " always set autoindenting on
set incsearch
set ai "auto indenting
set ic "insensitive search
set hls
set gdefault "Enables the /g option when using the substitute command :s.  
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set ofu=syntaxcomplete
set nobackup " Don't create backup files
set noswapfile " Don't create swap files
syn on


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

" next tab
"map <TAB>n :tabnext<CR>
" next tab
"map <TAB>b :tabprevious<CR>
" open new empty tab
"map <TAB>o :tabnew<CR>
"map <TAB>c :tabclose<CR>

noremap <C-w><C-g> <C-w>10+
noremap <C-w><C-s> <C-w>10-
noremap <C-m><C-r> :MRU<CR>

nnoremap    CL :set cursorline!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           OS Specific options                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline
let os = substitute(system('uname'), "\n", "", "") 
let hn = substitute(system('hostname'), "\n", "", "") " hostname
if os == "Linux"
    colorscheme pablo
endif
if hn == "blackey"
    colorscheme desert 
    set nocursorline
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

"Highlinting
:hi CursorLine gui=NONE ctermbg=NONE cterm=NONE
:hi StatusLine gui=NONE ctermbg=yellow ctermfg=red
:hi Pmenu ctermbg=white ctermfg=red
:hi PmenuSel ctermfg=white ctermbg=red
:hi Folded ctermbg=None ctermfg=white
:hi Search ctermfg=Black ctermbg=Green cterm=None


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
  let l:list=system("find . -iname '*".a:name."*' -not -name *.pyc | perl -ne 'print \"$.\\t$_\"'")
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

function Rename()
  let new_file_name = input('New filename: ')
  let full_path_current_file = expand("%:p")
  let new_full_path = expand("%:p:h")."/".new_file_name
  bd    
  execute "!mv ".full_path_current_file." ".new_full_path
  execute "e ".new_full_path
endfunction

command! Rename :call Rename()
nmap RN :Rename<CR>

source ~/.vim/vamrc
