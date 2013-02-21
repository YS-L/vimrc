set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Show line number
set nu

" Allow switching buffer before saving changes
set hidden

" Map ^C-N for silencing the search results
nmap <silent> <C-N> :silent noh<CR>

" ---- Python related ----
"  \pp to execute current script, \pi to execute and fall into -i mode
if has("gui_running")
    " If in gVim then no need to clear screen
    if has("gui_win32")
        map <leader>pp :w<CR>:!python %<CR><CR>
	map <leader>pi :w<CR>:silent !ipython -i %<CR><CR>
    else
        map <leader>pp :w<CR>:!cls<CR>:!python %<CR><CR>
	map <leader>pi :w<CR>:!cls<CR>:!ipython -i %<CR><CR>
    endif
endif

" Quick compile-and-run for a single c/cpp file
" TODO: Direct execute the compiled program, if build is succesful?
" 	(Now need to press a key after compiling)
if has("gui_running")
    " If in gVim then no need to clear screen
    if has("gui_win32")
	map <leader>cc :w<CR>:!g++ -Wall % -o %.exe<CR>:!%.exe<CR><CR>
    else
	map <leader>cc :w<CR>:!cls<CR>:!echo Compiling...<CR>:!g++ -Wall % -o %.exe<CR>:!%.exe<CR><CR>
    endif
endif

" For pathogen plugin; following sontek's tutorial
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Code folding
set foldmethod=indent
set foldlevel=99

" Window splitting key binding (switch window)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Syntax coloring and validation
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
let g:pyflakes_use_quickfix = 0

let g:pep8_map='<leader>8'

" Tab completion and documentation
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" Explorer, key binding
map <leader>n :NERDTreeToggle<CR>

" Tab completion
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"

" Task list
map <leader>td <Plug>TaskList

" Revision History
map <leader>g :GundoToggle<CR>

" --- For nicer-looking and more compact gVim ---
" Put here to avoid some cant-find-color problem
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h10
    silent colorscheme mustang
    " Hide menu- and tool- bars to show more texts
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
  endif
endif
"-------------------------------------------------

" Default tab as 4-space width
set tabstop=4
set shiftwidth=4
set autoindent

" Universal tab setting for .py scripts
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
" ------------------------

" Close buffer without closing current window
nmap <leader>d :bprevious<CR>:bdelete #<CR>

" SimpleCompile plugin
" For windows MinGW
call SingleCompile#ChooseCompiler('c','gcc')
call SingleCompile#ChooseCompiler('cpp','g++')
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
