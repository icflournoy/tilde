" icflournoy's vimrc
" https://dougblack.io/words/a-good-vimrc.html
" http://learnvimscriptthehardway.stevelosh.com/chapters/42.html
" http://learnvimscriptthehardway.stevelosh.com/chapters/12.html#autocommand-structure
" http://learnvimscriptthehardway.stevelosh.com/chapters/06.html#local-leader

execute pathogen#infect()
filetype plugin indent on
filetype indent on  " load filetype-specific indent files

let mapleader = '\' " leader key is \
let maplocalleader = '-' " lead local key is -

syntax enable       " enable syntax processing

set noerrorbells
set novisualbell

" Tabs n' Spaces!
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in a tab when inserting/removing tab
set shiftwidth=4    " number of spaces during reindent operations
set expandtab       " tabs are spaces. TAB is a shortcut for 'insert 4 spaces'

set number          " show line numbers
set textwidth=120   " wrap text after 120 lines
set colorcolumn=+1  " visually show border
highlight ColorColumn ctermbg=darkgrey guibg=lightgrey

set cursorline      " underline current line

set lazyredraw      " redraw only when absolutely nessecary

set showmatch       " highlight matching [{()}]

set incsearch       " search as characters are entered
set hlsearch        " highlight matches

" Status line
set showcmd         " show last command entered in bottom right
set laststatus=2    " always show status line

set wildmenu        " visually show autocomplete

" Movement
nmap j gj           " move down one visual line
nmap k gk           " move up one visual line

" Buffers
set hidden          " allows buffers to be hidden if you've modified a buffer (?)

set swapfile
set dir=~/.tmp

set nobackup
set nowritebackup

" Shortcuts
nmap <leader>T :enew<cr>            " create new empty buffer
nmap <leader>l :bnext<cr>           " move to next buffer
nmap <leader>h :bprevious<cr>       " move to previous buffer
nmap <leader>bq :bp <BAR> bd #<cr>  " close current buffer, move to previous one aka "closing a tab"
nmap <leader>bl :ls<cr>             " list open buffers
nmap <leader>q :q<cr>               " quit
map <leader>b :NERDTreeToggle<cr>   " open NERDTree

autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>    " '-c' comments out the line in python

nmap <leader><space> :nohlsearch<CR> " shortcut to clear search highlights

" When opening .cfg files under my Nagios repo apply the filetype
autocmd BufNewFile,BufRead */Nagios/*.cfg set filetype=nagios

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1 " not sure what this does

let g:NERDTreeDirArrowExpandable = ">"
let g:NERDTreeDirArrowCollapsible = "v"

" Open NERDTree automatically when vim starts up with no files specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" This should close vim if the only window left open is NERDTree
" What I want it to do is close vim if there's nerdtree and an empty window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
