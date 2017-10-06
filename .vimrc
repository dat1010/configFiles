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
" https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
