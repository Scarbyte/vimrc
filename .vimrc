"          __
"  __  __ /\_\    ___ ___   _ __   ___
" /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
" \ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
"  \ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"   \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"
" Scarbyte's vimrc configuration


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INIT VUNDLE PLUGIN MANAGER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'morhetz/gruvbox'
    Plugin 'Lokaltog/vim-monotone'
    Plugin 'vimsence/vimsence' " Discord Rich Presence
    Plugin 'ycm-core/YouCompleteMe'
call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" Fast saving
nmap <leader>w :w!<cr>
" :W - saves the file as sudo
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
filetype plugin indent on
set history=500
set autoread
au FocusGained,BufEnter * checktime

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USER INTERFACE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
set so=7
set ruler
set cmdheight=1
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS AND THEMES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    colorscheme gruvbox
catch
endtry

syntax enable
set number
set regexpengine=0
set background=dark
set encoding=utf8
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

" highlight text that is over 80 characters wide
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Status Line
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT AND TABS/INDENT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=80 " Line break on 80 characters
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Set tabwidth to 2 when editing HTML files
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Go to start of line (after indent) when pressing home button
map <Home> ^
imap <Home> <Esc>^i

" Makes paste not override yanked lines
vnoremap p "_dP

" Move between windows with hjkl
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>
" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre * :call CleanExtraSpaces()
endif

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
