if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set nobackup		  " do not keep a backup file, use versions instead
set nowritebackup " do not write to backup file
set noswapfile    " do not create swap file

set history=50		" keep 50 lines of command line history
set ruler		      " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		  " do incremental searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" pathogen config
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " For all ruby files
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et 

    autocmd FileType yaml set foldmethod=indent

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

    " Automatically load .vimrc changes
    autocmd BufWritePost vimrc source $MYVIMRC 
    autocmd BufWritePost .vimrc source $MYVIMRC 
  augroup END
endif " has("autocmd")

color railscasts

set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set ic
set autoindent
set number
set numberwidth=3
set nowrap

vmap <C-C> "+y
vmap <C-X> "+x
imap <C-V> <SPACE><ESC>"+gPi

map <S-Up> dd <up>P
map <S-Down> dd p

"These are mappings for the longlines mode equivalent"
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Common Plugins
syntax on
filetype plugin indent on

runtime! ftdetect/*.vim     " Filetype plugins
runtime! macros/matchit.vim " Advanced % matching

" Folding based on syntax
set foldmethod=syntax

let g:xml_syntax_folding=1
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"  
au FileType xml setlocal foldmethod=syntax 

map fmt :silent 1,$!xmllint --format --recover - 2>/dev/null<CR> 

set linebreak
set cursorline

" Remove the annoying beep
set vb t_vb="""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ruby debug-ide settings
let g:ruby_debugger_fast_sender = 1
map <F5> :call g:RubyDebugger.step()<CR>
map <F6> :call g:RubyDebugger.next()<CR>
map <F7> :call g:RubyDebugger.finish()<CR>
map <F8> :call g:RubyDebugger.continue()<CR>

" NERDTree Settings
let NERDTreeChDirMode=2
let g:NERDTreeMapActivateNode='<CR>'

" Tlist settings
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Enable_Fold_Column=0

" Statusline modifications, added Fugitive Status Line & Syntastic Error
" Message
set statusline=[%t]\ [Type=%y]\ %{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Improve autocomplete menu colors
highlight PMenu gui=bold guibg=#444444 guifg=#ECECEC

set guioptions-=m  " Remove menu bar
set guioptions-=T  " Remove toolbar
set guioptions-=r  " Remove right-hand scroll bar 
set guioptions-=L  " Remove left-hand scroll bar

" Vim supports dictionary autocomplete
set dictionary=/usr/share/dict/words 

" syntastic settng for vim to use |:sign| for marking syntax errors 
let g:syntastic_enable_signs=1 

" Remap command key
nnoremap <Leader>T :CommandT<CR> 

" Provides nice wild menu completion, makes command completion in ambigous
" case very easy
set wildmenu wildmode=full 
