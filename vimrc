" no vi compatibility
set nocompatible

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Twinside/vim-haskellFold'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'feuerbach/vim-hs-module-name'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-filetype-haskell'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'ujihisa/neco-ghc'

Bundle 'a.vim'

" filetype settings (required for vundle)
filetype on
filetype indent on
filetype plugin on

syntax enable
set background=light
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

let g:Powerline_colorscheme="solarized256"

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" fsync doesn't hurt on a modern fs :)
set fsync

" search: incremental, highlight
set incsearch
set hlsearch

" line numbering
set number

" show the command line
set showcmd

" don't jump to any brackets
set showmatch

" sane case settings
set ignorecase
set smartcase

" better mouse support
set ttymouse=xterm2

" powerful backspace
set backspace=indent,eol,start

" status line always on
set laststatus=2
set statusline=
set statusline+=\ %f\ \ %M\ %R\ %H
set statusline+=%=%03.3b
set statusline+=\ \ \ \ \ \ 0x\%02.2B
set statusline+=\ \ \ \ \ \ %04lx%04v
set statusline+=\ \ \ \ \ \ %L\ 

" redraw only when needed
set lazyredraw

" big nice viminfo
set viminfo='1000,f1,:1000,/1000,n~/.viminfo
set history=500

" syntax based folding, not by default
if has("folding")
    set nofoldenable
    set foldmethod=syntax
endif

" by default use spaces instead of tabs
set expandtab

" and make the default indent 2
set softtabstop=2
set shiftwidth=2

" allow buffers to be hidden
set hidden

" always show tab line
set showtabline=1

" the line width
set textwidth=80
set colorcolumn=84

" wrapping is convenient
set wrap
set sidescroll=4

" persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000

" tags, or tags in upper directory
set tags=tags;

" spell checking
set spelllang=en,pl
set spellsuggest=10

" additional context when scrolling
set scrolloff=4
set sidescrolloff=8

" wild menu for commands
set wildmenu
set wildmode=full
set wildignore=*.o,*.obj,*.hi,*.aux,*.toc,*.pdf,*.doc,*.class

" virtual editing in block mode
set virtualedit=block

" indenting, # does not force column zero
set autoindent
set smartindent
inoremap # X<BS>#

" no need for term title
set notitle

" no bell
set noerrorbells
set visualbell
set t_vb=

if !has("gui_running")
  set t_Co=16
endif

" mail specific stuff
autocmd BufRead $HOME/.mutt/tmp/mutt* set ft=mail textwidth=72 spell

" issues with latex
autocmd BufRead,BufNewFile *.tex :set syntax=tex
autocmd BufRead,BufNewFile *.tex :syntax spell toplevel
autocmd BufRead,BufNewFile *.tex :set spell

" set the right filetype
autocmd BufRead,BufNewFile *.hsc set ft=haskell
autocmd BufRead,BufNewFile *.mkd set ft=mkd
autocmd BufRead,BufNewFile *.v set ft=coq
autocmd BufRead,BufNewFile *.go set ft=go

autocmd FileType haskell set sts=2 sw=2
autocmd FileType c set sts=0 sw=8 noet
autocmd FileType cpp set sts=2 sw=2
autocmd FileType cpp let g:syntastic_cpp_compiler_options='-std=c++11'
autocmd FileType python set sts=4 sw=4
autocmd FileType ruby set sts=4 sw=4

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" show the trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" but not in instert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" set leader
let mapleader=","

" make it more consistent
nnoremap Y y$

" buffers
nnoremap <C-p> <ESC>:bprev<CR>
nnoremap <C-n> <ESC>:bnext<CR>
nnoremap <C-j> :buffers<CR>
nnoremap <C-_> :A<CR> " Ctrl-7

" omnicompletion
inoremap <C-g><C-o> <C-x><C-o>

" ...
nnoremap <C-y> :pop<cr>
nnoremap <C-c> :update<cr>
inoremap <C-c> <esc>:update<cr>a

" Copy/paste with X11
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" mappings for F keys
nnoremap <F8> :nohl<cr>
inoremap <F8> <ESC>:nohl<cr>a

nnoremap <F9> :%s/\s\+$//g<cr>:nohl<cr>
inoremap <F9> <ESC>:%s/\s\+//g<cr>:nohl<cr>

nnoremap <F10> '[=']
inoremap <F10> <ESC>'[=']

nnoremap <F11> =i{
inoremap <F11> <ESC>=i{

nnoremap <F12> gg=G
inoremap <F12> <ESC>gg=G

inoremap <C-t> <right>

" ctrlp
let g:ctrlp_map='<Leader>t'
let g:ctrlp_cmd='CtrlPBuffer'
let g:ctrlp_match_window_bottom=0
let g:ctrlp_match_window_reversed=0

" supertab
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<c-n>'

" gundo
let g:gundo_right=1
nnoremap <Leader>u :GundoToggle<CR>

" tcomment
let g:tcommentMapLeaderOp1='<Leader>c'
let g:tcommentMapLeaderOp2='<Leader>C'

" EasyMotion
hi link EasyMotionTarget Special
hi link EasyMotionShade Comment

" Haskell module name
let g:hs_module_no_mappings=1

" easy link opening in a browser
function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ ]*")
  :if line==""
  let line = matchstr (line0, "ftp[^ ]*")
  :endif
  :if line==""
  let line = matchstr (line0, "file[^ ]*")
  :endif
  let line = escape (line, "#?&;|%")
  " echo line
  exec ":silent !chromium ".line
endfunction

nnoremap <F7> :call Browser ()<cr>
