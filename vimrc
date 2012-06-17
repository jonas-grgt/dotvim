"filetype
filetype plugin on
filetype plugin indent on


"python settings
autocmd FileType python set omnifunc=pythoncomplete#Complete
:au FileType *.py set ts=4 sts=4 sw=4

autocmd BufNewFile,BufRead *.json set ft=javascript


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
"source ~/.vim/bundle/surround/plugin/surround.vim
source ~/.vim/plugin/closebuffer.vim
source ~/.vim/plugin/mru.vim

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
set backspace=indent,eol,start
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

set runtimepath+=/home/jonasg/dotvim/bundle/vam/
  fun! EnsureVamIsOnDisk(vam_install_path)
          " windows users may want to use http://mawercer.de/~marc/vam/index.php
          " to fetch VAM, VAM-known-repositories and the listed plugins
          " without having to install curl, 7-zip and git tools first
          " -> BUG [4] (git-less installation)
          if !filereadable(a:vam_install_path.'/vim-addon-manager/.git/config')
             \&& 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
            " I'm sorry having to add this reminder. Eventually it'll pay off.
            call confirm("Remind yourself that most plugins ship with ".
                        \"documentation (README*, doc/*.txt). It is your ".
                        \"first source of knowledge. If you can't find ".
                        \"the info you're looking for in reasonable ".
                        \"time ask maintainers to improve documentation")
            call mkdir(a:vam_install_path, 'p')
            execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
            " VAM runs helptags automatically when you install or update 
            " plugins
            exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
          endif
        endf

        fun! SetupVAM()
          " Set advanced options like this:
          " let g:vim_addon_manager = {}
          " let g:vim_addon_manager['key'] = value

          " Example: drop git sources unless git is in PATH. Same plugins can
          " be installed from www.vim.org. Lookup MergeSources to get more control
          " let g:vim_addon_manager['drop_git_sources'] = !executable('git')

          " VAM install location:
          let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
          call EnsureVamIsOnDisk(vam_install_path)
          exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

          " Tell VAM which plugins to fetch & load:
          call vam#ActivateAddons([], {'auto_install' : 0})
          " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

          " Addons are put into vam_install_path/plugin-name directory
          " unless those directories exist. Then they are activated.
          " Activating means adding addon dirs to rtp and do some additional
          " magic

          " How to find addon names?
          " - look up source from pool
          " - (<c-x><c-p> complete plugin names):
          " You can use name rewritings to point to sources:
          "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
          "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
          " Also see section "2.2. names of addons and addon sources" in VAM's documentation
        endfun
        call SetupVAM()
        " experimental [E1]: load plugins lazily depending on filetype, See
        " NOTES
        " experimental [E2]: run after gui has been started (gvim) [3]
        " option1:  au VimEnter * call SetupVAM()
        " option2:  au GUIEnter * call SetupVAM()
        " See BUGS sections below [*]
        " Vim 7.0 users see BUGS section [3]


call vam#ActivateAddons(['snipmate'], {'auto_install' : 1})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           OS Specific options                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let os = substitute(system('uname'), "\n", "", "") 
let hn = substitute(system('hostname'), "\n", "", "") " hostname
if os == "Linux"
    colorscheme pablo
endif
if hn == "blackey"
    colorscheme django 
    set nocursorline
    :hi Pmenu ctermbg=white ctermfg=red
    :hi PmenuSel ctermfg=white ctermbg=red
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
