set nocompatible
filetype plugin indent on
syntax on

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'guns/vim-sexp'
  Plug 'Olical/vim-scheme', { 'for': 'scheme', 'on': 'SchemeConnect' }
  Plug 'craigemery/vim-autotag'
  Plug 'yuki-ycino/fzf-preview.vim'
call plug#end()

set background=dark
colorscheme palenight

set clipboard=unnamedplus
set relativenumber
set termguicolors
set encoding=utf-8
set noswapfile

" On pressing tab, insert 2 spaces
set expandtab
" " show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" " when indenting with '>', use 2 spaces width
set shiftwidth=2

set number relativenumber
set nu rnu
let mapleader = ','
let maplocalleader="\<space>"

nmap <leader>r :so $MYVIMRC<CR>
nmap <leader>v :PlugInstall<CR>
nmap <leader>gm :GitMessenger<CR>
nmap <leader>f :FZF<CR>
nmap <leader>s :Rg 
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>g :G<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>d :noh<CR>
nmap <leader>z :Git difftool -y<CR>
nmap <leader>1 :Gwrite<CR><C-h>:q<CR>:q<CR>
nmap <leader>9 :Gread<CR>:w<CR>:q<CR>:q<CR>
nmap <leader>m :Gcommit -m<space>
nmap <leader>i :tabdo e<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap <C-k> gt
nmap <C-j> gT
vmap <leader>c gc
" nmap <leader>a ibinding.pry<ESC>
" imap <leader>a binding.pry
" iabbrev <buffer> dbg puts "------------------$$$$$$$$$$$$>"


" nerdtree icons
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeDirArrows = 1

set wildmode=list:longest,list:full
" let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,fg+:#ffffff,bg+:0 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
" let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,fg+:#ffffff,bg+:0 --layout=reverse  --margin=1,4'
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" function! FloatingFZF()
"   let buf = nvim_create_buf(v:false, v:true)
"   call setbufvar(buf, '&signcolumn', 'no')

"   let height = float2nr(12)
"   let width = float2nr(85)
"   let horizontal = float2nr((&columns - width) / 2)
"   let vertical = 6

"   let opts = {
"         \ 'relative': 'editor',
"         \ 'row': vertical,
"         \ 'col': horizontal,
"         \ 'width': width,
"         \ 'height': height,
"         \ 'style': 'minimal'
"         \ }

"   call nvim_open_win(buf, v:true, opts)
" endfunction

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'hl':      ['fg', 'String'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
"Rg preview window
"command! -bang -nargs=* Rg  
"  \ call fzf#vim#grep('rg --smart-case --line-number --no-heading --color=always -no-hidden --ignore '.shellescape(<q-args>), 
"  \ 0,
"  \ fzf#vim#with_preview({'options': '-e --delimiter : --nth 3..'}),
"  \ <bang>0)

command! -bang -nargs=* Rg  
  \ call fzf#vim#grep('rg --smart-case --line-number --no-heading --color=always --colors "path:fg:93,169,245" --colors "line:fg:128,128,128" --colors "match:fg:195,232,141" --no-hidden --ignore '.shellescape(<q-args>), 
  \ 0,
  \ fzf#vim#with_preview({'options': '-e --delimiter : --nth 3..'}),
  \ <bang>0)
"nerdtree auto open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" export FZF_DEFAULT_OPTS='
"  --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
"  --color info:254,prompt:37,spinner:108,pointer:235,marker:235
"'
"

function! SchemeConnectWrapper()
  :SchemeConnect
  exe "normal \<C-w>L"
  vert resize -50
  exe "normal \<C-w>h"
endfunction
command! SConnect call SchemeConnectWrapper()


