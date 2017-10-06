call plug#begin()
	Plug 'scrooloose/nerdtree'
	Plug 'elixir-editors/vim-elixir'
call plug#end()

map <C-n> :NERDTreeToggle<CR>

" Search down into subfolders and allows tab-completion
set path+=**

" Display all matching files for tab comlete
set wildmenu
set rnu
