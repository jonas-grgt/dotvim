"""""""""""""""""""""""""""""""""
" Remapping of keys
"""""""""""""""""""""""""""""""""

let mapleader=";"

map NHL :nohl<cr>
map ss :w<cr>

map BN :bn<cr>
map BD :Bclose!<cr>
map BP :bp<cr>

" After selecting something in visual mode and shifting, 
" I still want that selection intact
vmap > >gv
vmap < <gv

" visual-search mapping
vmap * y/<C-R>"<CR>

noremap <C-w><C-g> <C-w>10+
noremap <C-w><C-s> <C-w>10-
nnoremap    CL :set cursorline!<cr>

