" no vi compatibility
set nocompatible

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'Shougo/neocomplcache'
Bundle 'Twinside/vim-haskellFold'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'ujihisa/neco-ghc'
Bundle 'kana/vim-filetype-haskell'

Bundle 'a.vim'
Bundle 'YankRing.vim'

" filetype settings (required for vundle)
filetype on
filetype indent on
filetype plugin on

syntax enable
set background=light
let g:solarized_contrast="high"
let g:solarized_visibility="high"
let g:solarized_italic=0
colorscheme solarized

" fsync doesn't hurt on ext4 :)
set fsync

" automatically change directory
set autochdir

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

" one space is enough
set nojoinspaces

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
autocmd FileType python set sts=4 sw=4
autocmd FileType ruby set sts=4 sw=4

" Omni-completion
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \ if &omnifunc == "" |
        \ setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif

" show the trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" but not in instert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" set leader
let mapleader=","

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

" ...
nmap <C-y> :pop<cr>
nmap <C-c> :update<cr>
imap <C-c> <esc>:update<cr>a

" Copy/paste with X11
nmap <Leader>y "+y
nmap <Leader>p "+p
vmap <Leader>y "+y
vmap <Leader>p "+p

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

" enable neocomplcache
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_syntax_length=4

" neocomplcache key mappings
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" <CR>: close popup and save indent.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" Yank Ring
let yankring_replace_n_pkey='<A-p>'
let yankring_replace_n_nkey='<A-n>'

" NERD commenter
let NERDSpaceDelims=1
let NERDCompactSexyComs=1
let NERDRemoveExtraSpaces=1

" EasyMotion
hi link EasyMotionTarget Special
hi link EasyMotionShade Comment

" fuzzyfinder
" http://www.vim.org/scripts/script.php?script_id=1984
nnoremap <C-k> :FufBuffer<cr>
nnoremap <C-j> :FufFile<cr>

" easy link opening in firefox
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
  exec ":silent !firefox ".line
endfunction

map <F7> :call Browser ()<cr>
