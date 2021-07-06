"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG MANAGER
call plug#begin('~/.vim/plugged')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EDITOR TOOLS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --file tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" --file search
if isdirectory('/usr/local/opt/fzf')
      Plug '/usr/local/opt/fzf'
else
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'

" --search files -Ag
Plug 'rking/ag.vim'

" --live preview replacing
Plug 'markonm/traces.vim'

" --easymotion
Plug 'easymotion/vim-easymotion'

" --brackets pair
Plug 'jiangmiao/auto-pairs'

" --repeat action
Plug 'tpope/vim-repeat'

" --surround ysiw"->add"" / cs"'->change"to' / ds"->delete""
Plug 'tpope/vim-surround'

" -- indent guides
Plug 'nathanaelkane/vim-indent-guides'

" --scroll
Plug 'yuttie/comfortable-motion.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LANGUAGE SUPPORTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --lang support
let g:polyglot_disabled = ['java']
Plug 'sheerun/vim-polyglot'

" --intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --commenter leader(space)+c+leader
Plug 'preservim/nerdcommenter'

" --snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

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

" --flutter
Plug 'natebosch/vim-lsc-dart'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => APPEARANCE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --color scheme
Plug 'w0ng/vim-hybrid'

" --file icons
Plug 'ryanoasis/vim-devicons'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NVIM SPECIFIC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("nvim")
      " --for better syntax highlighting
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
      " --ranger as a file explorer
      Plug 'kevinhwang91/rnvimr'
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG MANAGER
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COLOR SCHEME
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/plugged/vim-hybrid/colors/hybrid.vim"))
      set background=dark
      colorscheme hybrid
endif
