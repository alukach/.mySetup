""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader Key (default: \)
" let mapleader = "`"

" Fast saving
nmap <leader>w :w!<cr>

" Fast opening
nmap <leader>e :e .<cr>

" Fast closing
nmap <leader>q :q<cr>

" Fast editing of the .vimrc
"map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu "Turn on WiLd menu

set cmdheight=1  "The commandbar height

set incsearch "Make search act like search in modern browsers

set number "Line numbers


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " Not really sure what this does
syntax on "Enable syntax hl

" Set font
set gfn=Monospace\ 6
set shell=/bin/bash

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax Highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.less set filetype=less


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
"set smarttab

set pastetoggle=<leader>p "Toggle paste indent
set showmode

set lbr
set tw=500

"set ai "Auto indent
"set si "Smart indent
"set wrap "Wrap lines
"set ww=<,>,[,]

" Better Wordwrap
setlocal wrap linebreak nolist
set virtualedit=
setlocal display+=lastline
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t

" Tabs
nmap <C-t> :tabnew .<CR>
nmap - :tabp<cr>
nmap = :tabn<cr>
" Move tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Split windows and buffers
" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>

" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

" Switch between window splits using big J or K and expand the split to its 
" full size. 
" 
" Move vertically in the window through the horizontal splits... 

" Resize Horiz Splits... 
map <C-J> :resize +2<CR> 
map <C-K> :resize -2<CR>
" Full-Expand Horiz Splits
map <C-A-J> <C-w>j<C-w>_ 
map <C-A-K> <C-w>k<C-w>_ 

" Resize Vert Splits... 
map <C-H> :10winc ><CR> 
map <C-L> :10winc <<CR>
" Full-Expand Vert Splits
map <C-A-H> <C-w>h<C-w>\| 
map <C-A-L> <C-w>l<C-w>\| 

map <C-P> :set scrollbind<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filetype plugin indent on
"
"call pathogen#infect()
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()
