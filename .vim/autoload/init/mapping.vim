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

" Swap window!
" to the very right
nnoremap <C-w><C-h> <C-w><S-h>
" to the very left
nnoremap <C-w><C-l> <C-w><S-l>
" to the very top
nnoremap <C-w><C-k> <C-w><S-k>
" to the very bottom
nnoremap <C-w><C-j> <C-w><S-j>

" Resize windows with option hjkl
if has("mac") || has("macunix")
    " k(+)
    nnoremap ∆ :resize +2<CR>
    " j(-)
    nnoremap ˚ :resize -2<CR>
    " l(+)
    nnoremap ¬ :vertical resize +2<CR>
    " h(-)
    nnoremap ˙ :vertical resize -2<CR>
endif

" Close the current buffer
map <leader>bd :Bclose<CR>:tabclose<CR>gT

" Close all the buffers
map <leader>ba :bufdo bd<CR>

map <leader>k :bnext<CR>
map <leader>j :bprevious<CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
" map <leader>tm :tabmove<CR>
map <leader>t<leader> :tabnext<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<CR>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " move a line of text using alt+[jk] or command+[jk] on mac
" nmap <m-j> mz:m+<cr>`z
" nmap <m-k> mz:m-2<cr>`z
" vmap <m-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" if has("mac") || has("macunix")
"   nmap <D-j> <M-j>
"   nmap <D-k> <M-k>
"   vmap <D-j> <M-j>
"   vmap <D-k> <M-k>
" endif

" My keymaps
nnoremap j gj
nnoremap k gk
inoremap <silent> jj <ESC>
nnoremap <Leader>z :noh<CR>
nnoremap <Leader>. :new ~/.vim<CR>
nnoremap n nzz
nnoremap N Nzz

"" Don't yank with..
nnoremap x "_x
nnoremap s "_s
nnoremap S "_S
nnoremap c "_c
nnoremap C "_C

"" Move fast in line
nnoremap <S-h> ^
nnoremap <S-l> $

"" Stay in visual mode when inserting indent
vnoremap > >gv
vnoremap < <gv

"" Quit all
nnoremap <Leader>qq :qall<CR>

"" Auto reload config files
nnoremap <Leader><Leader> :source $MYVIMRC<CR>:noh<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<CR>

" Shortcuts using <leader>
" map <leader>sn ]s
" map <leader>sp [s
" add to the dictionary
map <leader>sa zg
" get possible words list
map <leader>s? z=


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

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Time and date
iab xdate <C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
" UTC
iab xudate <C-r>=system("date -u '+%Y-%m-%d %H:%M:%S' \| tr -d '\n'")<CR>
iab improt import


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
