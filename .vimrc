""" No vi
set nocompatible
set ttyfast

""" Encoding
set history=1000            " Keep a very long command-line history.
set encoding=utf-8
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=full
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

""" Filetypes
filetype plugin on
filetype plugin indent on

set title
set t_Co=256
colorscheme Sunburst

syntax on
set number
set hidden
set ignorecase
set smartcase
set scrolloff=3
set backspace=2
set incsearch
set showmatch
set matchtime=2
set textwidth=79
set formatoptions=qrn1
"if has("mouse")
"    set mouse=a
"endif

if has("gui_running")
    set guioptions-=m       " remove menu bar
    set guioptions-=T       " remove toolbar
    set guioptions-=r       " remove right-hand scroll bar
    set t_Co=256
endif

" show a line at column 79
"if exists("&colorcolumn")
"    set colorcolumn=79
"endif

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set expandtab           " enter spaces when tab is pressed
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
"  set autoindent       " copy indent from current line when starting a new
set backspace=indent,eol,start
set ruler                  

autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufRead *.py nmap <F5> :!python %<CR>

autocmd BufRead *.py set tabstop=4
autocmd BufRead *.py set nowrap
autocmd BufRead *.py set go+=b

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

let g:pydiction_location = '$HOME/.vim/after/ftplugin/pydiction/complete-dict'
" use comma as <Leader> key instead of backslash
let mapleader=","

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
cmap W w
cmap Q q

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.
set shortmess=atI
set viminfo='20,<50,s10,h,%

function! ResCur()
if line("'\"") <= line("$")
normal! g`"
return 1
endif
endfunction

""" Zope Stuff
au BufNewFile,BufRead *.pt set filetype=html.pt
au BufNewFile,BufRead *.zcml set filetype=xml.zcml
au BufNewFile,BufRead *.conf set filetype=xml.conf
au BufNewFile,BufRead *.css.dtml set filetype=css

""" Disable Help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

""" Remap
nnoremap <F1> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Reselect visual block after in/dedent so we can in/dedent more
vnoremap < <gv
vnoremap > >gv

" To get rid of ^M characters as a result of DOS line endings
" command Crlf :%s/^M//g

augroup resCur
autocmd!
autocmd BufWinEnter * call ResCur()
augroup END

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l

noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

"highlight OverLength ctermbg=110000 ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

""" Taken from https://dev.launchpad.net/UltimateVimPythonSetup
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
endif
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so

""" Date: :r !date --rfc-3339=s

""" ZenCoding

let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

noremap <ESC>t :NERDTree<CR>

hi Normal guibg=NONE ctermbg=NONE
