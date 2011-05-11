" use my own color scheme
" colorscheme inkpot
colorscheme m

" no vi compatibility
set nocompatible

" fsync doesn't hurt on ext4 :)
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
set statusline+=\ %t\ \ %M\ %R\ %H
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

" one space is enough
set nojoinspaces

" wrapping is convenient
set wrap
set sidescroll=4

" persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=100
set undoreload=1000

" tags, or tags in upper directory
set tags=tags;

" spell checking
set spell
set spelllang=en,pl
set spellsuggest=10

" the dictionary.. ;)
set dictionary=/usr/share/dict/words

" additional context when scrolling
set scrolloff=4
set sidescrolloff=8

" wild menu for commands
set wildmenu
set wildmode=full
set wildignore=*.o,*.obj,*.hi,*.aux,*.toc,*.pdf,*.doc,*.class

"syntax highlighting
if has("syntax")
	syntax on
endif

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

" filetype settings
if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif

" 256 colors are cool
if ($TERM == "xterm-256color")
  set t_Co=256
  set t_AB=[48;5;%dm
  set t_AF=[38;5;%dm
endif

" set leader
let mapleader=","

" haskellmode settings
autocmd BufEnter *.hs compiler ghc
let g:ghc="/usr/bin/ghc"
let g:haddock_browser="/usr/bin/firefox"
let g:haddock_docdir="/usr/share/doc/ghc/html"
let g:haddock_indexfiledir = "/home/m/.vim/"

" haskell indent
" http://www.vim.org/scripts/script.php?script_id=1968
let g:haskell_indent_if=2
let g:haskell_indent_case=2

" sane asm syntax
let asmsyntax="nasm"

" taglist plugin
let Tlist_Use_Right_Window=1
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_Exit_Only_Window=1
let Tlist_Inc_Winwidth=0

" NERD commenter
let NERDSpaceDelims=1
let NERDCompactSexyComs=1
let NERDRemoveExtraSpaces=1

" LocateOpen settings
:let g:locateopen_ignorecase=1
:let g:locateopen_smartcase=1

" show the trailing whitespace as error
highlight link WhitespaceEOL Error
autocmd Syntax * syn match WhitespaceEOL /\s\+$\| \+\ze\t/

" url handling
" highlight URL	cterm=none	ctermfg=21	ctermbg=none
" autocmd BufRead * match URL /\(http\:\/\/\|ftp\:\/\/\|www\.\)\S*/
" autocmd BufNewFile * match URL /\(http\:\/\/\|ftp\:\/\/\|www\.\)\S*/

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
autocmd FileType cpp set sts=4 sw=4
autocmd FileType python set sts=4 sw=4
autocmd FileType ruby set sts=4 sw=4

" Omni-completion
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \ if &omnifunc == "" |
        \ setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif


" easy link opening in firefox
function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http://[^ ]*")
    :if line==""
        let line = matchstr (line0, "www\.[^ ]*\.[^ ]*")
    :endif
    :if line==""
        let line = matchstr (line0, "ftp://[^ ]*")
    :endif
    :if line==""
        let line = matchstr (line0, "file://[^ ]*")
    :endif
    let line = escape (line, "#?&;|%")
    exec "!firefox ".line
endfunction

map <F7> :call Browser ()<cr>


" l on Dvorak is pain to type
noremap t l
noremap l t

" make it more consistent
nmap Y y$

" buffers
nmap <C-p> <esc>:bprev<cr>
nmap <C-n> <ESC>:bnext<CR>
nmap <C-j> :buffers<cr>
nmap <C-_> :A<cr> " Ctrl-7

" fuzzyfinder
" http://www.vim.org/scripts/script.php?script_id=1984
nnoremap <C-k> :FufBuffer<cr>
nnoremap <C-x> :FufFile<cr>

" Align plugin
" http://www.vim.org/scripts/script.php?script_id=294
vmap <C-i> :Align 

" ...
nmap <C-y> :pop<cr>
nmap <C-g><c-t> :TlistToggle<cr>
nmap <C-c> :update<cr>
imap <C-c> <esc>:update<cr>a

" Copy/paste with X11
nmap ,y "+y
nmap ,p "+p
vmap ,y "+y
vmap ,p "+p

" mappings for F keys
nmap <F8> :nohl<cr>
imap <F8> <ESC>:nohl<cr>a

nmap <F9> :%s/\s\+$//g<cr>:nohl<cr>
imap <F9> <ESC>:%s/\s\+//g<cr>:nohl<cr>

nmap <F10> '[=']
imap <F10> <ESC>'[=']

nmap <F11> =i{
imap <F11> <ESC>=i{

nmap <F12> gg=G
imap <F12> <ESC>gg=G

imap <C-t> <right>
