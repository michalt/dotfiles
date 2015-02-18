" no vi compatibility
set nocompatible

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'Twinside/vim-haskellFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'feuerbach/vim-hs-module-name'
Plugin 'godlygeek/tabular'
Plugin 'idris-hackers/idris-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'phildawes/racer'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'travitch/hasksyn'
Plugin 'ujihisa/neco-ghc'
Plugin 'wting/rust.vim'

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

" split window below (preview, help, etc.)
set splitbelow

" status line always on
set laststatus=2

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
autocmd BufRead,BufNewFile *.rs set ft=rust

autocmd FileType haskell set sts=4 sw=4
autocmd FileType c set sts=0 sw=8 noet
autocmd FileType cpp set sts=2 sw=2
autocmd FileType cpp let g:syntastic_cpp_compiler_options='-std=c++11'
autocmd FileType python set sts=4 sw=4
autocmd FileType ruby set sts=4 sw=4
autocmd FileType rust set sts=4 sw=4

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" YouCompleteMe with neco-ghc
let g:ycm_semantic_triggers={'haskell' : ['.']}
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_autoclose_preview_window_after_completion=1

" Make eclim work nicely with YouCompleteMe
let g:EclimCompletionMethod='omnifunc'

" show the trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" but not in instert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" set leader
let mapleader=","

" Make syntastic populate list of errors (but don't open it by default)
let g:syntastic_auto_loc_list=0
let g:syntastic_always_populate_loc_list=1

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
nnoremap <C-8> :pop<cr>
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

nnoremap <C-i> :lnext<CR>
nnoremap <C-y> :lprev<CR>

" ctrlp
let g:ctrlp_map='<Leader>t'
let g:ctrlp_cmd='CtrlPBuffer'
let g:ctrlp_match_window_bottom=0
let g:ctrlp_match_window_reversed=0
let g:ctrlp_max_height=16

" supertab
let g:SuperTabDefaultCompletionType='<c-n>'

" gundo
let g:gundo_right=1
nnoremap <Leader>u :GundoToggle<CR>

" tcomment
let g:tcommentBlankLines=0
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
