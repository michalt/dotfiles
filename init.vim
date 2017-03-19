"
" Plugins
"

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-cursorword'
Plug 'jiangmiao/auto-pairs'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl'
Plug 'mbbill/undotree'
Plug 'neomake/neomake'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'sirver/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
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
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'component_function': { 'filename': 'LightLineFilename' }
  \ }
function! LightLineFilename()
  return expand('%')
endfunction

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" fsync doesn't hurt on a modern fs :)
set fsync

" line numbering
set number
set relativenumber

" show the command line
set showcmd

" don't jump to any brackets
set showmatch

" sane case settings
set ignorecase
set smartcase

" highlight search
set hlsearch

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
set textwidth=100
set colorcolumn=+1

" wrapping is convenient
set wrap

" don't redraw when executing macros, etc.
set lazyredraw

" persistent undo
set undodir=~/.config/nvim/undo
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
autocmd BufEnter * :syntax sync minlines=1024

" Reload file on change
autocmd BufEnter,FocusGained * checktime

" only enable the cursor line for the active window
autocmd WinEnter,FocusGained * setlocal cursorline
autocmd WinLeave,FocusLost * setlocal nocursorline

" colors
hi! VertSplit ctermfg=7 ctermbg=7 term=NONE

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

" The original caret 0 swap
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

inoremap <C-g> <ESC>
inoremap <M-g> <ESC>

"
" Plugin configuration
"

" vim-session
let g:session_directory='~/.config/nvim/sessions'

" haskell-vim
let g:haskell_indent_case=4
let g:haskell_indent_where=2
let g:haskell_indent_do=4
let g:haskell_indent_guard=4
let g:haskell_indent_case_alternative=4
let g:haskell_indent_disable=1


" FZF

" File preview using Highlight
let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" Use ripgrep and highlight the line
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

nnoremap <Leader>f :<C-u>Files<CR>
nnoremap <Leader>b :<C-u>Buffers<CR>
nnoremap <Leader>h :<C-u>History:<CR>
nnoremap <Leader>c :<C-u>Commands<CR>
nnoremap <Leader>s :<C-u>BLines<CR>
nnoremap <Leader>S :<C-u>Lines<CR>
nnoremap <Leader>/ :<C-u>Rg <C-R><C-W><CR>
nnoremap <Leader>? :<C-u>Rg 

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete_delay=100

" YouCompleteMe

let g:ycm_semantic_triggers = {'haskell' : ['.']}

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-session
let g:session_autoload = 'no'
