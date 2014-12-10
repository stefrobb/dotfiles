" My vimrc file.  It's a mess, it'll always be a mess.  Good luck even
" understanding what the various incantations are supposed to do.  I didn't
" really comment very well probably because I didn't (and still don't) really
" understand what the hell I'm doing.

" This is Vundle stuff and is probably wrong.
set nocompatible
filetype off
if has("unix")
	" Unix
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif
if has("win32")
	" Windows
	set rtp+=~/vimfiles/bundle/Vundle.vim/
	let path='~/vimfiles/bundle'
	call vundle#begin(path)
endif
" Common
Plugin 'gmarik/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'vim-scripts/CycleColor'
Plugin 'justinmk/vim-sneak'
Plugin 'ap/vim-buftabline'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'wting/rust.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
" No more plugins after here
call vundle#end()
filetype plugin indent on
" End of Vundle gibberish

" General Options {{{
" Fed up of backup and swap files polluting the place and getting orphaned
set nobackup
set noswapfile
" Allow you to have multiple files open and change between them without saving
set hidden
set nocompatible
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
" Allow mouse:
behave mswin
set ruler
set laststatus=2
set number
set t_Co=256
colorscheme base16-atelierdune
"colorscheme desert
set ignorecase
" Set font
set guifont=Consolas\ for\ Powerline\ FixedD:h10:cANSI
set smartcase
" Auto change dir to current buffer
set autochdir
" Turn off bell, this could be more annoying, but I'm not sure how
set vb t_vb=
" No GUI toolbar
set guioptions-=T
" No GUI menu bar
set guioptions-=m
" Don't break words when we wrap lines
set linebreak 
"}}}
" Includes {{{
source $VIMRUNTIME/vimrc_example.vim
" Remap cut, copy and paste to Windows keys.
"source $VIMRUNTIME/mswin.vim  " No thanks
" c-v pastes to the *right* of the cursor pos, remain in normal mode
"map <c-v> a<c-v><esc>
"}}}

let mapleader=','

" Plugin stuff {{{

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
"set listchars=tab:¸\ ,eol:A

map \ <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

"source $VIMRUNTIME/macros/matchit.vim
"}}}

syntax enable

" Set window size
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=54 columns=120
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
end

" Vimscript file settings -- -- -- -- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType ruby compiler ruby
augroup END
" }}}

" Mappings {{{
" Map window switching keys
"nnoremap <C-H> <C-W>h<C-W>_
nnoremap <C-J> <C-W>j<C-W>_
nnoremap <C-K> <C-W>k<C-W>_
"nnoremap <C-L> <C-W>l<C-W>_
" <C-M> maximises current window
nnoremap <C-M> <C-W>_
set wmh=0

" Remappings of some of the above keys, these ones allow us to move between
" buffers rather than windows since I started using the buftabline plugin
" thingy.
nnoremap <C-L> :bn<CR>
nnoremap <C-H> :bp<CR>

" Quick edit of _vimrc
nnoremap <leader>v :edit $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<cr>
" Clear search highlighting shortcut:
nnoremap <leader>c :nohlsearch<CR>
" A little cleverer (but I think it'll probably cause a headache later):
"nnoremap <cr> :noh<cr>

" let's autoload this file whenever we save it
cnoremap ww :w %<cr>:so %<cr>

" Map - (minus) to open the current folder in netrw (or NERDTree)
noremap - :NERDTree<cr>

" map c-j/k to scroll the window around the cursor
"map <c-j> j<c-e>
"map <c-k> k<c-y>

" Fancy search and replace set up: works in visual mode with selected text,
" expanded properly. Obv. you have to complete the rest of the s///g command yourself.
vnoremap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/

" map jk to <esc> only in insert mode
inoremap jk <esc>
" pagedown with space
nnoremap <Space> <PageDown>
" pageup with shift space?  Why not!
nnoremap <S-Space> <PageUp>

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" insert new line above without going into insert mode
nnoremap <S-Enter> O<ESC>

" Force gm to go the middle of the ACTUAL line, not the screen line
nnoremap <silent> gm :exe 'normal '.(virtcol('$')/2).'\|'<CR>

" Toggle linenumbers with leader-N
nnoremap <leader>N :setlocal number!<cr>

" Q = :q, quicker quit?  Not sure really. .. 
nnoremap Q :q<cr>
"}}}

" lightline configuration {{{
set encoding=utf-8
scriptencoding utf-8
set laststatus=2
let g:lightline = {
      \ 'component': {
      \   'readonly': '%{&readonly?"\u2b64":""}',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }
"}}}
