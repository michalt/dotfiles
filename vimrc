"
" Plugins
"

call plug#begin('~/.vim/plugged')

Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'Valloric/YouCompleteMe'
Plug 'altercation/vim-colors-solarized'
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'itchyny/vim-cursorword'
Plug 'jiangmiao/auto-pairs'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl'
Plug 'mbbill/undotree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tsukkee/unite-tag'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'wellle/targets.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" Add plugins to &runtimepath
call plug#end()

"
" General settings
"

" filetype settings
filetype on
filetype indent on
filetype plugin on

syntax enable
set background=light
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
let g:airline_theme="solarized"

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" fsync doesn't hurt on a modern fs :)
set fsync

" line numbering
set number
set relativenumber
autocmd FocusLost * :set norelativenumber
autocmd FocusGained * :set relativenumber

" show the command line
set showcmd

" don't jump to any brackets
set showmatch

" sane case settings
set ignorecase
set smartcase

" highlight search
set hlsearch

" better mouse support
set ttymouse=xterm2

" big nice viminfo
set viminfo='1000,f1,:1000,/1000,n~/.viminfo

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
set colorcolumn=81

" wrapping is convenient
set wrap

" highlight current line
set cursorline
function! s:Blink()
  setlocal nocursorline
  redraw
  sleep 50m

  setlocal cursorline
  redraw
endfunction
autocmd FocusGained * call s:Blink()

" persistent undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000

" spell checking
set spelllang=en,pl
set spellsuggest=10

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
set novisualbell

" use clipboard
set clipboard=unnamedplus

" Syntax highlighting gets confused by long comments
autocmd BufEnter * :syntax sync minlines=256

" set leader
let mapleader=" "

" Ctrl-Backspace
imap <C-BS> <C-W>

" make it more consistent
nnoremap Y y$

" select the pasted text
noremap gV `[v`]

" when syntax highlighting goel wrong
noremap <C-l> <C-l>:syntax sync fromstart<CR>
inoremap <C-l> <ESC><C-l>:syntax sync fromstart<CR>a

" quickfix
nnoremap <Leader>qo :copen<CR>
nnoremap <Leader>qc :cclose<CR>
nnoremap <Leader>qn :cnext<CR>
nnoremap <Leader>qp :cprev<CR>

function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction

" The original carat 0 swap
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

inoremap <C-g> <ESC>
inoremap <M-g> <ESC>

nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-L> <C-w>l
nnoremap <C-H> <C-w>h

"
" Plugin configuration
"

" FZF

nnoremap <Leader>f :<C-u>Files<CR>
nnoremap <Leader>b :<C-u>Buffers<CR>
nnoremap <Leader>h :<C-u>History:<CR>
nnoremap <Leader>c :<C-u>Commands<CR>
nnoremap <Leader>s :<C-u>BLines<CR>
nnoremap <Leader>S :<C-u>Lines<CR>
nnoremap <Leader>/ :<C-u>call fzf#vim#ag("<C-R><C-W>", { 'options':  '--color hl:9,hl+:9 --preview="/home/michal/code/show_context/show_context.sh {}" --preview-window up:8' })<CR>
" let g:fzf_launcher = 'xterm -title vimfzf -geometry 100x40 -e sh -c %s'

" vim-multiple-cursors

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-h>'
let g:multi_cursor_quit_key='<Esc>'

" Unite

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
  \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

let g:unite_source_rec_async_command =
  \ ['ag', '--follow', '--nocolor', '--nogroup',
  \  '--hidden', '-g', '']

call unite#custom#source('file,file/new,buffer,file_rec,line', 'matchers', 'matcher_fuzzy')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" nnoremap <Leader>f :<C-u>Unite -input= -resume -start-insert file_rec/async:!<CR>
" nnoremap <Leader>b :<C-u>Unite -start-insert buffer<CR>
" nnoremap <Leader>/ :<C-u>Unite -auto-preview -start-insert grep:.::<C-R><C-W><CR>
nnoremap <Leader>? :<C-u>Unite -auto-preview -start-insert grep:.<CR>
nnoremap <Leader>P :<C-u>Unite -start-insert history/yank<CR>
" nnoremap <Leader>s :<C-u>Unite -auto-preview -input=<C-R><C-W> -start-insert line<CR><right>
" nnoremap <Leader>S :<C-u>Unite -auto-preview -start-insert line:.<CR>
nnoremap <Leader>l :<C-u>UniteResume<CR>

" YouCompleteMe

let g:ycm_semantic_triggers = {'haskell' : ['.']}

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Syntastic
let g:syntastic_hs_checkers=['ghc_mod']

" vim-session
let g:session_autoload = 'no'
