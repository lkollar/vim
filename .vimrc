
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set nowritebackup
set noswapfile
set history=50		" keep 50 lines of command line history

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

syntax on
set hlsearch

" use space for tabs
set expandtab 
set tabstop=4
set shiftwidth=4
set smarttab

set t_Co=256
colorscheme Tomorrow-Night-Bright
set guifont=Menlo\ Regular:h12

set wildmode=full
set laststatus=2
"set autochdir
set number

" Tab navigation
map <S-h> gT
map <S-l> gt

" Don't use Ex mode, use Q for formatting
map Q gq

set clipboard=unnamed   " MacVim use system clipboard
set fileformats=unix,dos,mac

call pathogen#infect()
filetype plugin indent on

""""""""""""""""""
"" MiniBufExplorer
""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"" Tab doesn't work, so let's map it to l and h
map <C-l> <C-TAB> 
map <C-h> <C-S-TAB> 
 
map <ESC><ESC> :w<CR>

"set formatprg="par -w80"

"source ~/.vim/easy.vimrc

" Turn off highlighting after a search
map ,, :nohl<CR>

" Script helper function that will return the path of the current buffer. Can't
" be script local as we will call this from the status bar to display the
" buffer's path
func! CurBufPath()
    return fnamemodify(bufname("%"), ":p:h")
endfunc

set statusline=%<\ %t\ [%{CurBufPath()}]%h%m%r\ %=%-14.(%l,%c%V%)\ %P\ 
set laststatus=2

" CTRL+S saves (also map to make it work in insert mode)
map <C-s> :w<CR>
imap <C-s> <C-o>:w<CR>

" Treat text line wrapped to several screen lines as separate lines when
" navigating with the arrow keys
map <Up> gk
map <Down> gj
imap <Up> <C-o>gk
imap <Down> <C-o>gj

" Cut, copy & paste functionality that uses a named register instead of the
" unnamed one. This way normal editing operations don't always overwrite what
" was supposed to be kept in the clipboard. Activated by pressing ALT with the
" usual y/p/P/d commands
map <M-y> "ay
map <M-p> "ap
map <M-S-p> "aP
map <M-d> "ad

" Turn off bell in MacVim
set vb

" CMake syntax highlight
:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt setf cmake 

" Python OmniCompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <C-space> <C-x><C-o>
set completeopt=menuone,longest,preview

" RopeVim
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" PyFlakes
let g:pyflakes_use_quickfix = 0

"""""""""""""""""""""""""""""""""""""""""""""""""
""" SMART COMPLETION
"""""""""""""""""""""""""""""""""""""""""""""""""
"set tags+=~/.vim/tags/stl
"set tags+=~/.vim/tags/boost
"set tags+=./tags
"set tags+=~/repository/replicode/tags
"
"map <C-F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"set completeopt=menuone,menu,longest,preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
