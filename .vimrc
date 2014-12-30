" Vundle {{{
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
Plugin 'Lokaltog/vim-easymotion'
Plugin 'justinmk/vim-sneak'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'wting/rust.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'kien/ctrlp.vim'
Plugin 'roman/golden-ratio'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'miyakogi/conoline.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rsi'
Plugin 'dahu/vim-lotr'
Plugin 'tommcdo/vim-exchange'
" Colourschemes
Plugin 'flazz/vim-colorschemes'
" No more plugins after here
call vundle#end()
filetype plugin indent on
" }}}

" General Options {{{
set nobackup		" no backup files (doesn't seem to work sometimes)
set noswapfile		" no swap files (don't even see the point of these)
set hidden			" allow switching buffers without saving changes first
set nocompatible	" don't be vi
set autoindent		" what is says
set smartindent		" more indent-y stuff
set clipboard=unnamed " don't force me to use "* to yank and paste the system clipboard
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
behave mswin		" allow mouse
set ruler			" show cursor position
set laststatus=2	" always have a status line
set number			" line numbers on by default
set t_Co=256		" moar colours
" Select colour scheme depending on OS
if has("win32")
	colorscheme vibrantink
else
	colorscheme vibrantink
endif
set ignorecase		" um, ignore case
set smartcase		" override ignorecase if the search pattern contains upper case
" Set font, depending on OS
if has("win32")
	set guifont=Sauce_Code_Powerline:h9:cANSI
"else
	"set guifont=Consolas\ for\ Powerline\ FixedD:h10:cANSI
endif
set autochdir		" change cwd to that of file/buffer being edited
set vb t_vb=		" no bell
set guioptions-=T	" no gui toolbar
set guioptions-=m	" no gui menubar
set linebreak 		" word-wrap on
set scrolloff=5		" scroll when we get close to the top/bottom

syntax enable " enable syntax highlighting
syntax on

" Set window size, Windows only
if has("win32")
	if has("gui_running")
	  " GUI is running or is about to start.
	  " Set the size of the gvim window.
	  set lines=54 columns=120
	else
	  " This is console Vim.
	  if exists("+lines")
		set lines=50
	  endif
	  if exists("+columns")
		set columns=100
	  endif
	endif
endif
"}}}

" Filetype autocmd stuff {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType ruby compiler ruby
augroup END
" }}}

" Includes {{{
source $VIMRUNTIME/vimrc_example.vim
" Remap cut, copy and paste to Windows keys.
"source $VIMRUNTIME/mswin.vim  " No thanks
" c-v pastes to the *right* of the cursor pos, remain in normal mode
"map <c-v> a<c-v><esc>
"}}}

" Mappings {{{
let mapleader=','

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set listchars=tab:¸\ ,eol:¬

" Easymotion mappings:
map \ <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" Map window switching keys
" These ones maximise the window after switching:
"nnoremap <C-H> <C-W>h<C-W>_
"nnoremap <C-J> <C-W>j<C-W>_
"nnoremap <C-K> <C-W>k<C-W>_
"nnoremap <C-L> <C-W>l<C-W>_
" These ones do not change the window size when switching:
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
" <C-M> maximises current window
nnoremap <C-M> <C-W>_
set wmh=0 " allow minimum height windows (status line only)

" Remappings of some of the above keys, these ones allow us to move between
" buffers rather than windows since I started using the buftabline plugin
" thingy.
nnoremap <C-L> :bn<CR>
nnoremap <C-H> :bp<CR>

" Quick edit of _vimrc
nnoremap <leader>v :edit $MYVIMRC<CR>
" Quick source of _vimrc
nnoremap <leader>sv :so $MYVIMRC<cr>
" Quick save and source of _vimrc
cmap ww w %<cr>:so %<cr>

" Make %% expand to the path of the active buffer, only in command mode
cnoremap <expr> %%  getcmdtype()==':' ? expand('%:h').'/' : '%%'

" Clear search highlighting shortcut:
nnoremap <leader>c :nohlsearch<CR>
" A little cleverer (but I think it'll probably cause a headache later):
"nnoremap <cr> :noh<cr>

" Map - (minus) to open the current folder in netrw (or NERDTree)
noremap - :NERDTree<cr>

" Map c-j/k to scroll the window around the cursor
"map <c-j> j<c-e>
"map <c-k> k<c-y>

" Fancy search and replace set up: works in visual mode with selected text,
" expanded properly. Obv. you have to complete the rest of the s///g command yourself.
vnoremap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/

" Map jk to <esc> only in insert mode
inoremap jk <esc>

" Make it so that using long, wrapped lines will behave like normal lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
noremap <buffer> <silent> ^ g^
noremap <buffer> <silent> _ g_

" Pagedown with space
nnoremap <Space> <PageDown>
" Pageup with shift space?  Why not!
nnoremap <S-Space> <PageUp>

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Insert new line above without going into insert mode
nnoremap <S-Enter> O<ESC>

" Force gm to go the middle of the ACTUAL line, not the screen line
nnoremap <silent> gm :exe 'normal '.(virtcol('$')/2).'\|'<CR>

" Toggle linenumbers with leader-N
nnoremap <leader>N :setlocal number!<cr>

" Q = :q, quicker quit?  Not sure really...
nnoremap Q :qa<cr>

" <C-T> will move the cursor to the middle of the screen
" and then make the window scroll that line to the top
" of the screen
nmap <C-T> Mz<CR>

" CtrlP mappings, I'm not even sure what this plugin is for...
let g:ctrlp_map = '<C-P>'

" vim-bookmarks settings
let g:bookmark_sign='> '
let g:bookmark_annotation_sign = '>#'
highlight SignColumn guibg=Black
highlight SignColumn ctermbg=0
" gundo mappings
nnoremap <leader>gu :GundoToggle<cr>
"}}}

" vim-airline configuration {{{
" Fed up trying to sort out fonts, let's just do away with the arrows.
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
" }}}

" vim-session configuation {{{
let g:session_autosave='no'
let g:session_autoload='no'
nnoremap <leader>os :OpenSession<cr>
nnoremap <leader>ss :SaveSession<cr>
" }}}
