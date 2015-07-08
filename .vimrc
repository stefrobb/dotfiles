" use Vim settings over Vi settings
set nocompatible
" enables filetype detection, ftplugins, and indent files 
filetype plugin indent on


" Windows/Linux differences
let s:running_windows = has("win16") || has("win32") || has("win64")
"let s:running_cygwin = has("win32unix")
let g:myvimdir ="~/.vim" " default to .vim
" There's something seriously wrong here, neither of these set
" lines actually change the value, in Windows or Cygwin.
set backupdir="~/.vim/tmp"
set undodir="~/.vim/tmp"
if s:running_windows
  let g:myvimdir ="~/vimfiles" " Windoze uses vimfiles
  set backupdir=
  set undodir=
endif

" Install Vim-Plug if it isn't installed
" (requires curl and git)
if !filereadable(expand(g:myvimdir . "/autoload/plug.vim"))
  echo "Installing Vim-Plug and plugins. Restart after it's done."
  silent call mkdir(expand(g:myvimdir . "/autoload", 1), 'p')
  if s:running_windows
    silent! execute "!curl -kfLo " . expand($USERPROFILE . "\\vimfiles\\autoload\\plug.vim", 1)
          \ . " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  else
    silent! execute "!curl -fLo " . expand(g:myvimdir . "/autoload/plug.vim", 1)
          \ . " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  endif
  autocmd VimEnter * PlugInstall
endif 

" vim-plug plugins {{{
call plug#begin()
Plug 'Lokaltog/vim-easymotion'                         " Extra motions, mapped to \
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Lazy load
Plug 'bling/vim-airline'
Plug 'roman/golden-ratio'                           " Window auto-sizing
Plug 'miyakogi/conoline.vim'                        " Highlight the cursor line
Plug 'kurkale6ka/vim-pairs'                         " Punctuation text objects
		                                            " ` ' ! $ % ^ & * _ - + = : ; @ ~ # | \ , . ? /
Plug 'mhinz/vim-Startify'                           " Startup page and session management
Plug 'yegappan/mru'                                 " MRU list (:MRU)
Plug 'rhysd/clever-f.vim'                           " Use f/t for repeat in-line searching, free your ;
Plug 'godlygeek/tabular'                            " Well? Does it? Sort-of. (:Tab/{regex})
Plug 'tpope/vim-commentary'                         " For commenting, oddly enough (gcc per-line, gc<motion>)
autocmd FileType autohotkey set commentstring=;\ %s
Plug 'zefei/vim-colortuner'                         " Use F8
Plug 'terryma/vim-multiple-cursors'
Plug 'kien/rainbow_parentheses.vim'                 " Multi-coloured brackets!

" Disabled plugins
"Plug 'wellle/targets.vim'    							" More text object targets
"Plug 'MattesGroeger/vim-bookmarks'                     " Per-line bookmarks
"Plug 'sjl/gundo.vim'                                   " Multiple undos for many mistakes
"Plug 'tpope/vim-rsi'                                   " Readline mappings in insert/command mode
"Plug 'jeetsukumaran/vim-indentwise'                    " Move by indent-level: [+ and [-
"Plug 'kien/ctrlp.vim'                                  " Fuzzy file finder (not really diggin' this)

" Colourschemes
Plug 'flazz/vim-colorschemes'
call plug#end()
" }}}

" General Options {{{
set nobackup		" no backup files (doesn't seem to work sometimes)
set noswapfile		" no swap files (don't even see the point of these)
set nowritebackup

set hidden			" allow switching buffers without saving changes first
set nocompatible	" don't be vi
set autoindent		" what is says
set smartindent		" more indent-y stuff
set nostartofline	" don't reset column on page up/down
set nofoldenable	" all folds open initially
set clipboard=unnamed " don't force me to use "* to yank and paste the system clipboard
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
behave mswin		" allow mouse
set ruler			" show cursor position
set laststatus=2	" always have a status line
set number			" line numbers
set t_Co=256		" moar colours
" Select colour scheme depending on OS
if s:running_windows
	"colorscheme BlackSea
	"colorscheme adrian
	"colo gruvbox
	"colo solarized
	"colo spectro
	"colo torte
"	colo wintersday
	colo primary
	set background=dark
else
	colorscheme wombat256mod
	colo gotham
endif
set ignorecase		" um, ignore case
set smartcase		" override ignorecase if the search pattern contains upper case
" Set font, depending on OS
if s:running_windows
	set guifont=Sauce_Code_Powerline:h9:cANSI
"else
	"set guifont=Consolas\ for\ Powerline\ FixedD:h10:cANSI
endif
set autochdir           " change cwd to that of file/buffer being edited
set vb t_vb=            " no bell
set guioptions-=T       " no gui toolbar
set guioptions-=m       " no gui menubar
set linebreak           " word-wrap on
set scrolloff=5         " scroll when we get close to the top/bottom
set selection=inclusive " required for multiple cursors plugin

" Tab completion, don't match binaries
set wildmode=longest:list,full
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=*~,*.swp,*.tmp

syntax enable " enable syntax highlighting
syntax on

" Set window size, Windows only
if s:running_windows
	if has("gui_running")
	  " GUI is running or is about to start.
	  " Set the size of the gvim window.
	  set lines=54 columns=160
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
	au FileType vim setlocal fo-=c fo-=r fo-=o
 	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType ruby compiler ruby
augroup END
" }}}

" Includes {{{
"source $VIMRUNTIME/vimrc_example.vim
" Remap cut, copy and paste to Windows keys.
"source $VIMRUNTIME/mswin.vim  " No thanks
" c-v pastes to the *right* of the cursor pos, remain in normal mode
"map <c-v> a<c-v><esc>
"}}}

" Mappings {{{
let mapleader=','

" Save
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set listchars=tab:¸\ ,eol:¬

" Easymotion mappings:
map \ <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" Window behaviour/manipulation mappings:
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
" Switch windows using Tab
nnoremap <tab> <c-w>w
nnoremap <S-tab> <c-w>W


" Buffer behaviour/manipulation mappings:
" Move left/right between buffers
nnoremap <C-L> :bn<CR>
nnoremap <Right> :bn<CR>
nnoremap <C-H> :bp<CR>
nnoremap <Left> :bp<CR>
" Quick switch to previous buffer
nnoremap <Leader><Tab> :b#<CR>
" Delete buffer
nnoremap <silent> <Leader>X :bd!<CR>


" Quick edit of _vimrc
nnoremap <leader>v :edit $MYVIMRC<CR>
" Quick source of _vimrc
nnoremap <leader>sv :so $MYVIMRC<cr>
" Quick save and source of _vimrc
cmap ww w %<cr>:so %<cr>

" Make %% expand to the path of the active buffer, only in command mode
cnoremap <expr> %%  getcmdtype()==':' ? expand('%:h').'/' : '%%'

" Clear search highlighting shortcut:
nnoremap <leader>c :noh<CR>
" A little cleverer (but I think it'll probably cause a headache later):
"nnoremap <cr> :noh<cr>

" Centre search results
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Map F10 to open the current folder in netrw (or NERDTree)
noremap <F10> :NERDTree<cr>

" Map c-j/k to scroll the window around the cursor
"map <c-j> j<c-e>
"map <c-k> k<c-y>

" Fancy search and replace set up: works in visual mode with selected text,
" expanded properly. Obv. you have to complete the rest of the s///g command yourself.
vnoremap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/

" Map jk/kj to <esc> only in insert mode
inoremap jk <esc>
inoremap kj <esc>

" Use H and L are beginning/end of line movements
nnoremap H ^
nnoremap L g_

" Change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" Make it so that using long, wrapped lines will behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g^	" Swap 0 and ^
noremap <silent> $ g$
noremap <silent> ^ g0	" Swap 0 and ^
noremap <silent> _ g_

" C-Up/Down *moves* entire line up/down.
nnoremap <C-Up> <ESC>:m .-2<CR>
nnoremap <C-Down> <ESC>:m .+1<CR>

" Pagedown with space
nmap <Space> <C-f>
" Backspace as page up? Yups.
nnoremap <bs> <C-b>

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Insert new line above without going into insert mode
"(uses mark o to return to the previous cursor column)
nnoremap <S-Enter> moO<Esc>`o

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

" Make Y yank to EOL, more vimmy.
nnoremap Y y$

" Column Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-locked together. Allows you to see twice as much code at once
" (disables the wrap setting and expands folds to work better)
nnoremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" Global substitution skeleton, just add the search/replace pattern
nnoremap gs :%s//g<Left><Left>

" visually select all
nnoremap vae ggVG
" vv selects the text of the current line
nnoremap vv ^vg_
"}}}

" vim-bookmarks settings {{{
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
" Display the buffers in the tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
" }}}

"" vim-session configuation {{{
"let g:session_autosave='no'
"let g:session_autoload='no'
"nnoremap <leader>os :OpenSession<cr>
"nnoremap <leader>ss :SaveSession<cr>
"" }}}


" highlight 81st column if reached {{{
" Example line Example line Example line Example line Example line Example li>>>E<<<ple line 
" Doesn't work well in vsplits though
function! MarkMargin (on)
  highlight colorcolumn ctermbg=DarkRed
  highlight colorcolumn guibg=DarkRed
  if exists('b:MarkMargin')
    try
      call matchdelete(b:MarkMargin)
    catch /./
    endtry
    unlet b:MarkMargin
  endif
  if a:on
    let b:MarkMargin = matchadd('ColorColumn', '\%81v', 100)
  endif
endfunction

augroup MarkMargin
  autocmd!
  autocmd BufEnter * :call MarkMargin(1)
augroup END
" }}}

" Reopen files on the same line as you last edited
" (note, edited, not necessarily the same as the
" cursor line.)
function! s:JumpToLastKnownCursorPosition()
    if line("'\"") <= 1 | return | endif
    if line("'\"") > line("$") | return | endif
    " Ignore git commit messages and git rebase scripts
    if expand("%") =~# '\(^\|/\)\.git/' | return | endif
    execute "normal! g`\"" |
endfunction
autocmd BufReadPost * call s:JumpToLastKnownCursorPosition()

" ----------------------------------------------------------------------------
" <F8> | Color scheme selector
" ----------------------------------------------------------------------------
function! s:rotate_colors()
  if !exists('s:colors_list')
    let s:colors_list =
    \ sort(map(
    \   filter(split(globpath(&rtp, "colors/*.vim"), "\n"), 'v:val !~ "^/usr/"'),
    \   "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"))
  endif
  if !exists('s:colors_index')
    let s:colors_index = index(s:colors_list, g:colors_name)
  endif
  let s:colors_index = (s:colors_index + 1) % len(s:colors_list)
  let name = s:colors_list[s:colors_index]
  execute 'colorscheme' name
  redraw
  echo name
endfunction
nnoremap <F8> :call <SID>rotate_colors()<cr>
