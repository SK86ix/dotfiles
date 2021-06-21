" VIM-PLUG MANAGER
call plug#begin('~/.vim/plugged')

" EDITOR TOOL
" --file tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" --file seach
if isdirectory('/usr/local/opt/fzf')
      Plug '/usr/local/opt/fzf'
else
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'
" --search files -Ag
Plug 'rking/ag.vim'
" --replacing
Plug 'markonm/traces.vim'
" --lang support
let g:polyglot_disabled = ['java']
Plug 'sheerun/vim-polyglot'
" --intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" --commenter leader(space)+c+leader
Plug 'preservim/nerdcommenter'
" --brackets pair
Plug 'jiangmiao/auto-pairs'
" --repeat action
Plug 'tpope/vim-repeat'
" --surround ysiw"->add"" / cs"'->change"to' / ds"->delete""
Plug 'tpope/vim-surround'
" -- indent guides
Plug 'nathanaelkane/vim-indent-guides'
" --snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
if has("nvim")
      " --for better syntax highlighting
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
" --easymotion
Plug 'easymotion/vim-easymotion'
" --ranger as a file explorer
if has("nvim")
      Plug 'kevinhwang91/rnvimr'
endif
" --async lint engine
Plug 'dense-analysis/ale'
" --lsp implementing (like ale)
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'rhysd/vim-lsp-ale'
" --post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" --html,xml tag completion
Plug 'alvan/vim-closetag'
" --emmet
Plug 'mattn/emmet-vim'
" --sass
Plug 'AtsushiM/search-parent.vim'
Plug 'AtsushiM/sass-compile.vim'
" --git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" APPERANCE
" --line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" --color scheme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
" --scroll
Plug 'yuttie/comfortable-motion.vim'
" --file icons
Plug 'ryanoasis/vim-devicons'

call plug#end()


" COLORSHEME
if filereadable(expand("~/.vim/plugged/vim-hybrid/colors/hybrid.vim"))
      set background=dark
      colorscheme hybrid
endif
