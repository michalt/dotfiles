"
" Plugins
"

call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'RRethy/vim-illuminate'
Plug 'Shirk/vim-gas'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'chiel92/vim-autoformat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dart-lang/dart-vim-plugin'
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf-vim', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
" Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neomake/neomake'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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

" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'method', 'modified' ] ]
  \ },
  \ 'component_function': {
    \ 'filename': 'LightLineFilename',
  \ },
  \ }
    " \ 'method': 'NearestMethodOrFunction',

function! LightLineFilename()
  return expand('%f')
endfunction

" omnicompletion
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

" fsync doesn't hurt on a modern fs :)
set fsync

" line numbering
set relativenumber number

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

" disable concealing
set conceallevel=0

" allow buffers to be hidden
set hidden

" always show tab line
set showtabline=1

" the line width
set textwidth=80
set colorcolumn=+1

" Better display for messages
set cmdheight=2

" scrolling offset
set scrolloff=3

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=50

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

" use mouse in normal mode
set mouse=n

" Syntax highlighting gets confused by long comments
autocmd BufEnter * :syntax sync minlines=1024

" Reload file on change
autocmd BufEnter,FocusGained * checktime

" only enable the cursor line for the active window
autocmd WinEnter,FocusGained * setlocal cursorline
autocmd WinLeave,FocusLost * setlocal nocursorline
autocmd FocusGained * hi CursorLineNR cterm=reverse
autocmd FocusLost * hi CursorLineNR cterm=bold

" colors
highlight! VertSplit ctermfg=7 ctermbg=7 term=NONE
highlight! SpecialKey ctermfg=LightGray ctermbg=Black
highlight! SpecialComment ctermfg=DarkGray
highlight! Search ctermfg=NONE ctermbg=NONE cterm=reverse
" this helps with gitgutter
highlight! link SignColumn LineNr

" set leader
let mapleader=" "

" pane management
nnoremap <C-t> <C-w><S-h>

" terminal movement
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-t> <C-\><C-n><C-w><C-p>
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif

" save
inoremap <C-s> <ESC>:w<CR>a
nnoremap <C-s> :w<CR>

" Ctrl-Backspace
imap <C-BS> <C-W>

" make it more consistent
nnoremap Y y$

" select the pasted text
noremap <Leader>V `[v`]

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

" Auto-semicolon/-comma
inoremap ;; <C-o>$;
inoremap ,, <C-o>$,

" inoremap (( ()<C-G>U<Left>
" inoremap {{ {}<C-G>U<Left>
" inoremap << <><C-G>U<Left>
" inoremap '' {}<C-G>U<Left>
" inoremap "" {}<C-G>U<Left>

" inoremap )) <ESC>])a
" inoremap }} <ESC>]}a
" inoremap >> <ESC>a
" inoremap '' <ESC>]'a
" inoremap "" <ESC>]'a

inoremap <C-g> <ESC>
inoremap <M-g> <ESC>

" show filename
nnoremap <Leader>g <C-g>

" Haskell
autocmd FileType haskell setlocal textwidth=80
autocmd FileType haskell nnoremap <Leader>hm :GhcModSigCodegen<CR>
autocmd FileType haskell nnoremap <Leader>hs :GhcModSplitFunCase<CR>
autocmd FileType haskell nnoremap <Leader>hi :GhcModTypeInsert<CR>
autocmd FileType haskell nnoremap <Leader>ht :GhcModType<CR>
autocmd FileType haskell nnoremap <Leader>hc :GhcModCheck<CR>

" Rust
autocmd FileType rust setlocal textwidth=100
autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`', '<':'>'}
" autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`', '<':'>'}
let g:rustfmt_autosave=1

"
" Plugin configuration
"

" Illuminate
let g:Illuminate_delay=200

" Obsession
let g:sessions_dir = '~/.config/nvim/sessions'
exec 'nnoremap <Leader>S :Obsession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>R :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" TabNine

" haskell-vim
let g:haskell_indent_case=4
let g:haskell_indent_where=2
let g:haskell_indent_do=4
let g:haskell_indent_guard=4
let g:haskell_indent_case_alternative=4
let g:haskell_indent_disable=1

" FZF
let g:fzf_layout = { 'down': '100%' }
let g:fzf_preview_window='up:50%'
let g:fzf_buffers_jump=1
let $BAT_THEME='GitHub'

nnoremap <Leader>f :<C-u>Files<CR>
nnoremap <Leader>g :<C-u>GFiles<CR>
nnoremap <Leader>b :<C-u>Buffers<CR>
nnoremap <Leader>h :<C-u>History:<CR>
nnoremap <Leader>c :<C-u>Commands<CR>
nnoremap <Leader>s :<C-u>BLines<CR>
nnoremap <Leader>l :<C-u>Lines<CR>
 nnoremap <Leader>/ :<C-u>Rg <C-R><C-W><CR>
 nnoremap <Leader>? :<C-u>Rg 


" CtrlSF
" let g:ctrlsf_auto_focus = { "at": "start" }
" let g:ctrlsf_position = 'bottom'
" hi ctrlsfMatch cterm=NONE ctermfg=black ctermbg=lightgrey
" autocmd FileType ctrlsf DisableWhitespace

" nmap <Leader>/ <Plug>CtrlSFCwordPath<CR>
" nmap <Leader>?  <Plug>CtrlSFPrompt<CR>
" nnoremap <Leader>t :CtrlSFToggle<CR>
" let g:ctrlsf_mapping = {
"     \ "next": "J",
"     \ "prev": "K",
"     \ }

" LSP
" To debug hie-wrapper add this:
"   '--debug', '--vomit', '--logfile', '/home/michal/hie.log'
" Commented out in case it turns out to be useful
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rust-analyzer'],
  \ 'haskell': ['ghcide', '--lsp'],
  \ 'dart': ['/home/michal/soft/dart-sdk/bin/dart', '/home/michal/soft/dart-sdk/bin/snapshots/analysis_server.dart.snapshot', '--lsp'],
  \ }
nnoremap <silent> <c-]> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gn :call LanguageClient#diagnosticsNext()<CR>
nnoremap <silent> gp :call LanguageClient#diagnosticsPrevious()<CR>

let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
" let g:LanguageClient_changeThrottle = 0.0

" coc.vim
set signcolumn=yes

hi CocErrorHighlight ctermfg=Red ctermbg=LightGray
" hi CocHighlightText  ctermbg=220

" inoremap <silent><expr> <c-space> coc#refresh()
" nmap <silent> <c-]> <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> gp <Plug>(coc-diagnostic-prev)
" nmap <silent> gn <Plug>(coc-diagnostic-next)
" nmap <Leader>rn <Plug>(coc-rename)

" This gives nicer auto-formatting for when opening new block with `{`.
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" vista.vim
let g:vista_sidebar_position='vertical topleft'
let g:vista_default_executive='coc'
let g:vista_sidebar_width=40
let g:vista_close_on_jump=1
let g:vista#renderer#enable_icon=0
" These don't seem to actually work... :/
" let g:vista_fzf_opt=[$FZF_DEFAULT_OPTS]
" let g:vista_keep_fzf_colors=1

nnoremap <Leader>v :Vista!!<CR>

" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" vim-autoformat
let g:formatters_haskell = ['ormolu']
let g:formatdef_ormolu = '"ormolu"'
autocmd BufWrite *.dart :Autoformat
" autocmd BufWrite * :Autoformat
noremap <Leader>F :Autoformat<CR>

" vim-highlightedyank
let g:highlightedyank_highlight_duration=300
highlight link HighlightedyankRegion Visual

" indentLine
let g:indentLine_color_term=254
let g:indentLine_char = '▏'

" sneak
highlight! Sneak ctermfg=NONE ctermbg=NONE cterm=reverse
nmap t <Plug>Sneak_s
nmap T <Plug>Sneak_S


" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-markdown
let g:vim_markdown_conceal=0
