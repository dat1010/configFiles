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
call plug#end()

map <C-n> :NERDTreeToggle<CR>
let NerdTreeShowLineNumbers=1
let NERDTreeQuitOnOpen = 1
autocmd FileType nerdtree setlocal relativenumber
" NerdTree set color 
hi Directory guifg=#FF0000 ctermfg=cyan

" Search down into subfolders and allows tab-completion
 set path+=**

" " Display all matching files for tab comlete
 set wildmenu
 set rnu

 " This should disable automatic commetns
set formatoptions-=cro
colors desert

