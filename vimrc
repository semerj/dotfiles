" don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax enable

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

call vundle#end()

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

set autoindent
set autoread                            " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                         " Fix broken backspace in some setups
set backupcopy=yes                      " see :help crontab
set clipboard=unnamed                   " yank and paste with the system clipboard
set directory-=.                        " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                           " expand tabs to spaces
set ignorecase                          " case-insensitive search
set incsearch                           " search as you type
set laststatus=2                        " always show statusline
set list                                " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                              " show line numbers
set ruler                               " show where you are
set scrolloff=3                         " show context above/below cursorline
set shiftwidth=2                        " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                           " case-sensitive search if any caps
set softtabstop=2                       " insert mode tab and backspace use 2 spaces
set tabstop=8                           " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                            " show a navigable menu for tab completion
set wildmode=longest,list,full

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" keyboard shortcuts
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" save current buffer when you hit Esc twice
map <Esc><Esc> :w<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
" let g:gitgutter_enabled=0  " turn off gitgutter

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" python pep8
" autocmd FileType python setlocal colorcolumn=80

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP


""""""""""""""""""""""""""
" vimrc.local moved here "
""""""""""""""""""""""""""
colorscheme solarized                      " gui settings
set nocursorline                           " don't highlight current line
set hlsearch                               " highlight search
"nmap <leader>hl :let @/ = ""<CR>
" turn off search highlight with ,/
nnoremap <leader>/ :nohlsearch<CR>
" exit insert mode with jj
inoremap jj <ESC>
" automatically save the current buffer when you hit Esc twice
map <Esc><Esc> :w<CR>

" Disambiguate ,a & ,t from the Align plugin, making them fast again.
"
" This section is here to prevent AlignMaps from adding a bunch of mappings
" that interfere with the very-common ,a and ,t mappings. This will get run
" at every startup to remove the AlignMaps for the *next* vim startup.
"
" If you do want the AlignMaps mappings, remove this section, remove
" ~/.vim/bundle/Align
function! s:RemoveConflictingAlignMaps()
  if exists("g:loaded_AlignMapsPlugin")
    AlignMapsClean
  endif
endfunction
command! -nargs=0 RemoveConflictingAlignMaps call s:RemoveConflictingAlignMaps()
silent! autocmd VimEnter * RemoveConflictingAlignMaps

" Make asyncrun.vim cooperate with vim-fugitive
" https://github.com/skywind3000/asyncrun.vim/wiki/Cooperate-with-famous-plugins#fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" If use Vim8, you can execute python file asynchronously by
" skywind3000/asyncrun.vim and output automatically the result to the quickfix
" window (http://liuchengxu.org/posts/use-vim-as-a-python-ide/)"
" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

augroup SPACEVIM_ASYNCRUN
  autocmd!
  " Automatically open the quickfix window
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
  exec 'w'
  if &filetype == 'sh'
    exec "AsyncRun! time bash %"
  elseif &filetype == 'python'
    exec "AsyncRun! time python %"
  endif
endfunction

" Copies only the text that matches search hits. Works with multiline matches.
" Search for a pattern, then enter :CopyMatches to copy all matches to the
" clipboard, or :CopyMatches x where x is any register to hold the result.
" (http://vim.wikia.com/wiki/Copy_search_matches)
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
