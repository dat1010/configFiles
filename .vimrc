if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
	Plug 'scrooloose/nerdtree'
	Plug 'elixir-editors/vim-elixir'
	Plug 'vim-ruby/vim-ruby'
	Plug 'airblade/vim-gitgutter'
	Plug 'vim-airline/vim-airline'
	Plug 'slashmili/alchemist.vim'
	Plug 'vim-test/vim-test'
	Plug 'tpope/vim-endwise'
	Plug 'dense-analysis/ale'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'benmills/vimux'
	Plug 'preservim/vim-markdown'
call plug#end()

map <C-n> :NERDTreeToggle<CR>
let NerdTreeShowLineNumbers=1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
autocmd FileType nerdtree setlocal relativenumber
" NerdTree set color 
hi Directory guifg=#FF0000 ctermfg=cyan

" Search down into subfolders and allows tab-completion
 set path+=**

" " Display all matching files for tab comlete
 set wildmenu
 set rnu

 " This should disable automatic commetns
set formatoptions-=cr

" turn hybrid line numbers on
:set number relativenumber
:set nu rnu


" Settings the colorscheme
:colorscheme default

" To use backspace
set backspace=indent,eol,start

" Tab for autocomplete instead of enter
inoremap <expr> <Tab> getline('.')[col('.') - 2] =~ '\w' ? "<C-N>" : "<Tab>"

" Allows the to use the mouse to select a pane
set mouse=a

" show existing tab with 4 spaces width
" set tabstop=4
" " when indenting with '>', use 4 spaces width
" set shiftwidth=4
" " On pressing tab, insert 4 spaces
" set expandtab
"
set guifont=Fira\ Code:h12

" This copies to clipboard
set clipboard=unnamed

let test#strategy = 'vimux'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>u :call IExExUnitRun()<CR>
nmap <silent> <leader>rc :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rv :TestVisit<CR>

nnoremap <silent> <C-f> :Files<CR>


let g:ale_elixir_elixir_ls_release='~/Documents/programming/ls/elixir-ls/release/'


let g:ale_linters = {
\   'elixir': ['elixir-ls'],
\}

let g:ale_fixers = {
\   'elixir': ['mix_format'],
\}

let g:ale_completion_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1


" Run nearest test in a tmux terminal
let mapleader = ","
map <silent> <leader>r :TestNearest<CR>



let mapleader = ","
" Add elixir pry
function! AddPryBelow()
  call append(line("."), "require IEx; IEx.pry")
endfunction

map <silent> <leader>p :call AddPryBelow()<CR>

inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" Toggle relative line number (great for pairing)
let s:relative = 1

function! ToggleRelative()
    if s:relative  == 0
        let s:relative = 1
        set nonumber
        set number relativenumber

    else
        let s:relative = 0
        set nonumber
        set number norelativenumber

    endif
endfunction

noremap <silent> <leader>a :call ToggleRelative()<CR>
