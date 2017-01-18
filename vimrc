"  Configuration file for Vim
"  (http://www.vim.org)

"  ryanss <ryanssdev@icloud.com>
"  https://github.com/ryanss/vim
"  MIT License

if has('win32') || has('win64')
    let VIMDIR = expand("$HOME/vimfiles")
else
    let VIMDIR = expand("$HOME/.vim")
endif

" Automatically setup Vundle on first run
if !isdirectory(VIMDIR."/bundle/Vundle.vim")
    call system("git clone https://github.com/VundleVim/Vundle.vim.git ".VIMDIR."/bundle/Vundle.vim")
endif
set nocompatible
filetype off
execute "set rtp+=".expand(VIMDIR."/bundle/Vundle.vim")
call vundle#begin()
let g:vundle#bundle_dir=VIMDIR."/bundle"
Plugin 'VundleVim/Vundle.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/closetag.vim'
Plugin 'othree/html5.vim'
Plugin 'rstacruz/sparkup'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/vader.vim'
Plugin 'ryanss/vim-hackernews'
call vundle#end()

" Automatically install bundles on first run
if !isdirectory(expand(VIMDIR."/bundle/vim-airline"))
    execute 'silent BundleInstall'
    execute 'silent GoInstallBinaries'
    execute 'silent q'
endif


filetype plugin indent on   " detect file type and load indents and plugins
syntax on                   " turn on syntax highlighting
colorscheme jellybeans      " syntax highlighting colours

set autoread                " auto reload buffer when file modified externally
set clipboard=unnamed       " yank and paste using system clipboard
set encoding=utf-8          " default character encoding
set hidden                  " do not unload buffers that get hidden
set noswapfile              " do not use a swap file for buffers
set nowritebackup           " do not make backup before overwriting file

set laststatus=2            " always show the status line
set nowrap                  " do not wrap text
set number                  " show line numbers
set scrolloff=3             " keep minimal number of lines above/below cursor
set showcmd                 " show command line at bottom of screen
set sidescroll=3            " scroll sideways 3 characters at a time
set splitright              " open vertical split right of current window
set visualbell              " use visual bell instead of beeping
set wildmenu                " tab auto-complete for commands
set wildignore=*.pyc        " stuff for auto-complete to ignore

set backspace=2             " make backspace behave normally
set expandtab               " insert tabs as spaces
set shiftwidth=4            " number of spaces for auto indent and line shift
set cindent                 " syntax-aware auto indent
set smarttab                " <BS> deletes a shiftwidth worth of space
set softtabstop=4           " number of spaces pressing <Tab> counts for
set tabstop=4               " number of spaces a <Tab> in the file counts for

" Smaller indents on css and html files
autocmd! Syntax css,html,htmldjango,js setlocal shiftwidth=2 tabstop=2 softtabstop=2

set showmatch               " briefly jump to matching bracket
set ignorecase              " ignore case when pattern matching
set smartcase               " only if all characters are lower case
set incsearch               " highlight matches while typing search
set hlsearch                " keep previous search highlighted

" Turn off highlighting of previous search
noremap <C-n> :nohlsearch<CR>

let mapleader = ","
let g:mapleader = ","
let g:user_emmet_leader_key = '<C-e>'

imap jk <Esc>
noremap ; :

" Prevent overwriting default register (system clipboard) when inconvenient
vnoremap x "_x
vnoremap c "_c
vnoremap p "_dP

" Poor man's CtrlP
noremap <Leader>e :e **/*

" Move between open buffers easier
noremap <C-J> :bp<CR>
noremap <C-K> :bn<CR>
noremap <Leader>d :bd!<CR>:bp<CR>

" Move between vertical splits easier
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Git/fugitive shortcuts
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gf <C-W>h<C-W>czR
nnoremap <Leader>gp :Git push<CR>

" Mappings for misc plugins
map <SPACE> <Plug>(easymotion-s2)
map <Leader>a <Plug>(EasyAlign)
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Shortcuts to edit and reload vim config
nnoremap <Leader>r :execute "edit ".VIMDIR."/vimrc"<CR>
nnoremap <Leader>R :execute "source ".VIMDIR."/vimrc"<CR>

set guioptions=
if has('win32') || has('win64')
    set guifont=Consolas:h12
else
    set guifont=Menlo:h14
endif

" Airline customizations
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_section_y = airline#section#create(['%p', '%%'])
let g:airline_section_z = airline#section#create_right(['%l', '%c'])

" Closetag settings
let g:closetag_html_style=1
autocmd! FileType html,htmldjango execute "source ".VIMDIR."/bundle/closetag.vim/plugin/closetag.vim"

" Highlight characters when lines get too long
augroup LongLines
    autocmd!
    autocmd BufEnter * match none
    autocmd BufEnter *.py,*.vim,.vimrc match ErrorMsg '\%>80v.\+'
    autocmd BufEnter *.html,*.js,*.php match ErrorMsg '\%>100v.\+'
augroup END

" Vim can manage golang imports in files automatically
let g:go_fmt_command = "goimports"

" Format XML with gg=G
autocmd! FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Automatically wrap text while typing in Markdown and rST documents
autocmd! BufNewFile,BufReadPost *.md set filetype=markdown
autocmd! Filetype markdown,rst setlocal textwidth=79

" Remove trailing whitespace and empty lines at end of file
augroup whitespace
    autocmd!
    autocmd BufWritePre * :let cursor = getpos('.')
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePre * :%s/\($\n\s*\)\+\%$//e
    autocmd BufWritePost * :call setpos('.', cursor)
augroup END
