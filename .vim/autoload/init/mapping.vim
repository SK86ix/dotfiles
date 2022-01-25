""""""""""""""""""""""""""""""
" MAPPING (ref: many lines from https://github.com/amix/vimrc)
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Leader
""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"

" Force saving
nmap <leader>w :w!<cr>:cclose<cr>


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" visual mode pressing * or # searches for the current selection
" super useful! from an idea by michael naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Split window
nmap sh :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Swap window!
" to the very right
nnoremap <C-w><C-h> <C-w><S-h>
" to the very left
nnoremap <C-w><C-l> <C-w><S-l>
" to the very top
nnoremap <C-w><C-k> <C-w><S-k>
" to the very bottom
nnoremap <C-w><C-j> <C-w><S-j>

" Resize windows
nnoremap <C-w><S-h> :vertical resize -4<CR>
nnoremap <C-w><S-l> :vertical resize +4<CR>
nnoremap <C-w><S-j> :resize +4<CR>
nnoremap <C-w><S-k> :resize -4<CR>

" Close the current buffer
map <leader>bd :Bclose<CR>:tabclose<CR>gT

" Close all the buffers
map <leader>ba :bufdo bd<CR>

map <leader>k :bnext<CR>
map <leader>j :bprevious<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My keymaps
nnoremap j gj
nnoremap k gk
inoremap <silent> jj <ESC>
nnoremap <Leader>z :noh<CR>
nnoremap <Leader>. :NERDTreeToggle ~/.vim/autoload/<CR>
nnoremap n nzz
nnoremap N Nzz

" Increment/Decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Select all
nmap <C-a> gg<S-v>G

" Don't yank with..
nnoremap x "_x
nnoremap s "_s
nnoremap S "_S
nnoremap c "_c
nnoremap C "_C

" Show Files in the current directory
nnoremap <Leader>F :Files<CR>

" Move fast in line
nnoremap <S-h> ^
nnoremap <S-l> $

" Stay in visual mode when inserting indent
vnoremap > >gv
vnoremap < <gv

" Quit all
nnoremap <Leader>qq :qall<CR>

" Auto reload config files
nnoremap <Leader><Leader> :source $MYVIMRC<CR>:noh<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<CR>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cnoremap $h e ~/
cnoremap $d e ~/Desktop/
cnoremap $j e ./
cnoremap $c e <C-\>eCurrentFileDir("e")<CR>
cnoremap $s e ~/.vim/autoload/

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cnoremap $q <C-\>eDeleteTillSlash()<CR>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command mode abbreviation :checkhealth
cab CH checkhealth


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
