"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC (ref: many lines from https://github.com/amix/vimrc)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("nvim")
  " Python path setting
  let g:python_host_prog = expand('~/.vim/python-versions/nvim-p2/bin/python')
  let g:python3_host_prog = expand('~/.vim/python-versions/nvim-p3/bin/python3')

  " Ruby path setting
  let g:ruby_host_prog = expand('~/.rbenv/versions/2.7.4/bin/neovim-ruby-host')
endif

" Encoding
set encoding=UTF-8
set fileencoding=UTF-8
set fileencodings=UTF-8,cp932

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" For Windows, use slash when writing file path
set shellslash


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Don't show mode
set noshowmode

" Show title
set title

" Show number
set number

"Cursor setting
if has('vim_starting')
    let &t_ti .= "\e[2 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
    let &t_te .= "\e[0 q"
endif

if has('nvim')
  set guicursor=n-v:block,i-c-ci-ve:ver25,r-cr:hor20,o:hor50
      \,i-c:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175
endif

" Avoid garbled characters in Chinese language windows OS
if has("win16") || has("win32") || has("win32unix")
    let $LANG='en'
    set langmenu=en
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32") || has("win32unix")
    set wildignore+=.git\*,.hg\*,.svn\*,*.exe,*\\node_modules\\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Show horizontal line
set cursorline

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
set showmatch matchtime=1

" How many tenths of a second to blink when matching brackets
set mat=2

" Enable to move one more space of the line
set virtualedit=onemore

" Search from the top again
set wrapscan

" No annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Show command right bottom
set showcmd

" Show words appropritately
set ambiwidth=double
if exists('&ambw')
  set ambiwidth=single
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Show hidden symbols
set list
set listchars=tab:¦_,trail:-,extends:»,precedes:«
" eol:↲,
hi NonText ctermfg=darkgrey
hi SpecialKey ctermfg=darkgrey

" Show hint when searching file with TAB
set wildmode=list:longest


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Auto change current directory when moving buffers
set autochdir


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Enable Clipboard
set clipboard=unnamed
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

" Record undo list
if has('persistent_undo')
  if has("nvim")
    let undo_path = expand('~/.config/nvim/undo')
    exe 'set undodir=' .. undo_path
  else
    let undo_path = expand('~/.vim/undo')
    exe 'set undodir=' .. undo_path
  endif
	set undofile
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTENDED
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ref) https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23

if has ("nvim")
  " With this function you can reuse the same terminal in neovim.
  " You can toggle the terminal and also send a command to the same terminal.

  let s:monkey_terminal_window = -1
  let s:monkey_terminal_buffer = -1
  let s:monkey_terminal_job_id = -1

  function! MonkeyTerminalOpen()
    " Check if buffer exists, if not create a window and a buffer
    if !bufexists(s:monkey_terminal_buffer)
      " Creates a window call monkey_terminal
      new monkey_terminal
      " Moves to the window the right the current one
      wincmd L
      let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

      wincmd J " split below (Move the current window to be at the very bottom)
      resize 16 " resize

      " Change the name of the buffer to "Terminal 1"
      silent file Terminal\ 1
      set nonu
      " Gets the id of the terminal window
      let s:monkey_terminal_window = win_getid()
      let s:monkey_terminal_buffer = bufnr('%')

      " The buffer of the terminal won't appear in the list of the buffers
      " when calling :buffers command
      set nobuflisted
    else
      if !win_gotoid(s:monkey_terminal_window)
      sp
      " Moves to the window below the current one
      wincmd L
      buffer Terminal\ 1
      set nonu
       " Gets the id of the terminal window
       let s:monkey_terminal_window = win_getid()
      endif

      wincmd J " split below (Move the current window to be at the very bottom)
      resize 16 " resize

    endif
  endfunction

  function! MonkeyTerminalToggle()
    if win_gotoid(s:monkey_terminal_window)
      call MonkeyTerminalClose()
    else
      call MonkeyTerminalOpen()
    endif
  endfunction

  function! MonkeyTerminalClose()
    if win_gotoid(s:monkey_terminal_window)
      " close the current window
      hide
    endif
  endfunction

  function! MonkeyTerminalExec(cmd)
    if !win_gotoid(s:monkey_terminal_window)
      call MonkeyTerminalOpen()
    endif

    " clear current input
    call jobsend(s:monkey_terminal_job_id, "clear\n")

    " run cmd
    call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
    normal! G
    wincmd p
  endfunction

  " With this maps you can now toggle the terminal
  nnoremap <C-q> :call MonkeyTerminalToggle()<cr>
  tnoremap <C-q> <C-\><C-n>:call MonkeyTerminalToggle()<cr>

  " This an example on how specify command with different types of files.
      " augroup go
      "     autocmd!
      "     autocmd BufRead,BufNewFile *.go set filetype=go
      "     autocmd FileType go nnoremap <F5> :call MonkeyTerminalExec('go run ' . expand('%'))<cr>
      " augroup END
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc
