" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
"set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis


call pathogen#infect()

set nobackup
set nowritebackup
set noswapfile

" use space when tab is pressed
set expandtab 
set tabstop=4
set shiftwidth=4
set smarttab

set t_Co=256
colorscheme Tomorrow-Night-Bright
set guifont=Menlo\ Regular:h12
set wildmode=full
set laststatus=2
set autochdir
set number

set clipboard=unnamed   " MacVim use system clipboard
set ignorecase   " Ignore case

set fileformats=unix,dos,mac

map <S-h> gT
map <S-l> gt

map <F12> :ProjectTree <CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"" SMART COMPLETION
""""""""""""""""""""""""""""""""""""""""""""""""
set tags+=~/.vim/tags/stl
set tags+=~/.vim/tags/boost
set tags+=./tags
set tags+=~/repository/replicode/tags

map <C-F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menuone,menu,longest,preview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""
"" MiniBufExplorer
""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
 
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
