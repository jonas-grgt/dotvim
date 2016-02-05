" ------------------------------------------------"
"                   vim-airline                   "
" ------------------------------------------------"
let g:airline_theme='reluna'
let g:airline#extensions#tabline#enabled = 1 "Automatically displays all buffers when there's only one tab open
set laststatus=2 "vim-airline doesn't appear until I create a new split, see :h laststatus on why

" ------------------------------------------------"
"                      ctrl-p                     "
" ------------------------------------------------"
let g:ctrlp_custom_ignore = { 
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\|test$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' } " files and directories to ignore 
