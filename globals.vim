set runtimepath^=~/.vim/bundle/ctrlp.vim

set completeopt=menuone,longest,preview "Omnicomplete options
set mouse=a
set foldlevel=101
set hidden "allows to move to a different buffer without saving the current first
set nu
set autoindent " always set autoindenting on
set incsearch
set ai "auto indenting
set ic "insensitive search
set hls
set gdefault "Enables the /g option when using the substitute command :s.  
set expandtab " Enter spaces when tab is pressed
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set noswapfile " Don't create swap files
set directory=~/.vim/swp  " store the .swp files in a specific path

syntax enable 

"Highlinting
hi CursorLine gui=NONE ctermbg=NONE cterm=NONE
hi StatusLine gui=NONE ctermbg=yellow ctermfg=red
hi Pmenu ctermbg=white ctermfg=red
hi PmenuSel ctermfg=white ctermbg=red
hi Folded ctermbg=None ctermfg=white
hi Search ctermfg=Black ctermbg=Green cterm=None
