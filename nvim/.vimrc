set t_Co=256
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set smartindent
set scrolloff=10
set noswapfile


call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
let g:gruvbox_transparent_bg=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox
set background=dark

let mapleader=" "

nnoremap <leader>w :w!<CR>
nnoremap <leader>q :wq!<CR>
nnoremap <leader>ev :edit ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
nnoremap <leader>pi :PlugInstall<CR>
inoremap jj <ESC>

inoremap <UP>       <NOP>
inoremap <DOWN>     <NOP>
inoremap <LEFT>     <NOP>
inoremap <RIGHT>    <NOP>

nnoremap <UP>       <NOP>
nnoremap <DOWN>     <NOP>
nnoremap <LEFT>     <NOP>
nnoremap <RIGHT>    <NOP>
