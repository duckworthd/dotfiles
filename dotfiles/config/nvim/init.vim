" Plugins {{{
  set nocompatible

  " Some plugins expect a POSIX-compatible shell (fish isn't).
  if &shell =~# 'fish$'
    set shell=sh
  endif

  " Download vim-plug if necessary.
  if empty(glob("$HOME/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif

  " Load everything in ~/.vim/bundle.
  call plug#begin('~/.vim/bundle')

  " PaperColor color scheme.
  Plug 'NLKNguyen/papercolor-theme'

  " Automatically format files.
  Plug 'Chiel92/vim-autoformat'

  " status bar
  Plug 'bling/vim-airline'

  " status bar themes.
  Plug 'vim-airline/vim-airline-themes'

  " golang support
  Plug 'fatih/vim-go',  { 'for':  ['go'] }

  " align text by "=" or ":" or whatever else
  Plug 'godlygeek/tabular'

  " file search.
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " async syntax checking
  Plug 'w0rp/ale'

  " Better C++ syntax highlighting
  Plug 'octol/vim-cpp-enhanced-highlight'

  " file navigation
  Plug 'scrooloose/nerdtree'

  " visual undo tree
  Plug 'sjl/gundo.vim'

  " Simple Python folding
  Plug 'tmhedberg/SimpylFold'

  " delete surrounding parentheses, etc
  Plug 'tpope/vim-surround'

  " Context-aware completion backend.
  Plug 'Valloric/YouCompleteMe', { 'do' : './install.py --clang-completer --rust-completer --go-completer' }

  " syntax highlighting for markdown + latex
  Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown'] }
  Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown'] }

  " kill buffers without messing up window layout
  " :BD (close buffer)
  Plug 'vim-scripts/bufkill.vim'

  " Copy to clipboard using OSC52.
  Plug 'haya14busa/vim-poweryank'

  call plug#end()
" }}}

" Machine-local vimrc {{{
  if filereadable(expand("~/.config/nvim/init-local.vim"))
    source ~/.vimrc-local
  endif
" }}}

" Environment {{{
  if has('win16') || has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME " Use /.vim for runtime path on Windows
    set guifont=Consolas:h9:cANSI   " font for GUI on Windows
  endif

  if has('gui_macvim')
    set macmeta   " lets me use <A-...> in MacVim
  endif

  if has('unix') && !has('mac')
    set guifont=Monospace\ 9
  endif

  " ignore these files/folders when tab-completing paths
  set wildignore+=*.pyc,*.o,*.so,*.obj,*.swp,*.zip,*.tar,*.gz,*.exe,*.dll
  set wildignore+=*/tmp/*,*/.git/*,*/.svn/*,*/.hg/*,*/target/*

  set backspace=indent,eol,start  " enable backspace the way you'd expect
  "set clipboard=unnamed    " always copy to windows/mac clipboard for use in other apps
  set hidden                " allow for hidden buffers
  set ffs=unix,dos          " save files with unix line endings
  syntax on                 " syntax highlighting
  filetype plugin indent on " use plugin, indentation style for filetype
  set textwidth=0           " don't automatically split lines after they get too long
  set encoding=utf-8        " default to UTF-8
  set fileencoding=utf-8    " default to UTF-8
  set switchbuf=usetab      " when using :bn and such, iterate across tabs too
  set mouse=a               " enable mouse usage on some terminals
  set virtualedit=block     " lets you move the cursor past the end of the line
                            " when selecting blocks of text
  set lazyredraw            " don't update display while executing a macro
  set formatoptions+=j      " when joining lines prefixed with comment
                            " characters, remove them before joining
  set autoread              " if a buffer hasn't been edited and has been
                            " changed by another program, reload it when
                            " :checktime is called.
  set ttimeoutlen=100       " Wait 100ms for escape sequences. This is causes
                            " vim to stop pausing upon entering <Esc>-O.
" }}}

" Tabs {{{
  set expandtab     " tabs replaced with spaces
  set tabstop=2     " number of spaces a tab counts for
  set shiftwidth=2  " tab appears 2 spaces long
  set softtabstop=2 " backspace deletes tabs of length 2
  set autoindent    " indent same as last line
" }}}

" Backups {{{
  " backups will be written to ~/.vimetc/backup, but must be restored manually.
  " no location history is kept, so if 2 files share the same name the last
  " one you edited will overwrite the other

  " Create a directory (and all its parents) if it's missing, otherwise do
  " nothing.
  function! CreateDirectoryIfMissing(path)
    if !isdirectory(expand(a:path))
      call mkdir(expand(a:path), 'p')
    endif
  endfunction

  set backup                          " enable backups
  let s:etcdir=$HOME.'/.vimetc'
  let &backupdir=s:etcdir.'/backup'   " backup directory
  let &directory=s:etcdir.'/swap'     " swap file directory (crash recovery)
  let &viewdir=s:etcdir.'/views'      " view directory (where you last were)
  if exists("*mkdir")
    call CreateDirectoryIfMissing(s:etcdir  )
    call CreateDirectoryIfMissing(&backupdir)
    call CreateDirectoryIfMissing(&directory)
    call CreateDirectoryIfMissing(&viewdir  )
    " autocmd BufWinLeave * silent! mkview
    "   "save view for files matching '*' when leaving a buffer
    " autocmd BufWinEnter * silent! loadview
    "   "load view for files matching '*' when entering a buffer
  else
    set noswapfile nobackup nowritebackup
  endif
  set viminfo=                          " disable viminfo
"}}}

" Undo History {{{
  if !has('win32') && !has('win64') && v:version >= 703
    set undofile        " Save undo's after file closes
    let &undodir=s:etcdir.'/undo' " where to save undo histories
    call CreateDirectoryIfMissing(&undodir)
    set undolevels=1000     " How many undos
    set undoreload=10000    " number of lines to save for undo
  end
" }}}

" Keys {{{
  " Switching splits
  nnoremap <C-j> <C-W>j
  nnoremap <C-k> <C-W>k
  nnoremap <C-l> <C-W>l
  nnoremap <C-h> <C-W>h

  nnoremap <C-Up>    <C-W>k
  nnoremap <C-Down>  <C-W>j
  nnoremap <C-Left>  <C-W>h
  nnoremap <C-Right> <C-W>l

  " up/down within a single wrapped line
  nnoremap <Up>   gk
  nnoremap <Down> gj
  vnoremap <Up>   gk
  vnoremap <Down> gj
  inoremap <Up>   <C-o>gk
  inoremap <Down> <C-o>gj

  " ALT+(+/-) to resize buffer
  noremap <A-k>   <C-w>+
  noremap <A-j>   <C-w>-
  noremap <A-h>   <C-w><lt>
  noremap <A-l>   <C-w>>

  " change directory to that of current file
  noremap <leader>cd  :cd %:p:h<CR>:pwd<CR>

  " move line up/down
  nnoremap  <C-A-j>   :m+<CR>
  nnoremap  <C-A-k>   :m--<CR>

  " relative line numbers
  noremap <leader>ln  :call ToggleRelativeLineNumbers()<CR>
  function! ToggleRelativeLineNumbers()
    if (&relativenumber == 1)
      set norelativenumber
    else
      set relativenumber
    endif
  endfunction

  " clear highlighted search term
  nnoremap <silent> <C-S-c> :nohlsearch<CR>

  " quicker scroll up/down
  noremap <C-e> 3<C-e>
  noremap <C-y> 3<C-y>

  " start binding window scrolling together
  noremap <leader>sb  :set scrollbind!<CR>

  " Don't use Shift+direction
  noremap <S-Down>  <Down>
  noremap <S-Up>    <Up>

  " start/end of line in insert mode
  inoremap <C-a>  <C-o>^
  inoremap <C-e>  <C-o>$

  " previous/next word in insert mode
  inoremap <C-f>  <C-o>W
  inoremap <C-b>  <C-o>B

  " Disable help by F1
  noremap <F1> <Nop>
  inoremap <F1> <Nop>

  " Disable 'open documentation' shortcut
  nnoremap K <Nop>
  vnoremap K <Nop>

  " delete all trailing whitespace
  nnoremap <leader>dw :%s/\v\s+$//g<CR><C-o>

  " Reload all buffers that have been changed by other programs.
  noremap <leader>ee :checktime<CR>

  " Re-select text when changing tabbing in visual mode.
  vnoremap < <gv
  vnoremap > >gv

  " Fix syntax highlighting with folding.
  nnoremap U :syntax sync fromstart<CR>:redraw!<CR>

  " Copy from global clipboard
  nnoremap <leader>v "+p
  inoremap <C-v> <Esc>"+pa

  " Disable Ex mode.
  noremap Q <Nop>
"}}}

" UI {{{
  function! MaybeSetColorScheme(name)
    " Sets colorscheme if scheme is available. Returns true if successful.
    let l:pat = 'colors/'.a:name.'.vim'
    let l:colorscheme_exists = !empty(globpath(&rtp, l:pat))
    if l:colorscheme_exists
      execute 'colorscheme' a:name
    endif
    return l:colorscheme_exists
  endfunction

  if $TERM =~ "-256color"
    set t_Co=256      " force vim to assume terminal supports 256 colors.
    set t_ut=         " disable 'background color erase' -- important for tmux.
                      " See https://sunaku.github.io/vim-256color-bce.html
  endif

  " Cursor only in active window.
  augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
  augroup END

  " Note: You can explore a colorscheme by running,
  "   :source $VIMRUNTIME/syntax/hitest.vim
  call MaybeSetColorScheme("PaperColor")  " Use PaperColor scheme if available.
  set background=dark     " dark background
  set cursorline          " Hightlight current line
  set ruler               " Show line ruler
  set number              " line numbers
  set hlsearch            " highlight search matches
  set incsearch           " search before pressing <CR>
  set ignorecase          " ignore case in search...
  set smartcase           " ...unless one of the characters is upper case
  set wildmenu            " see options listed in minibuffer
  set scrolloff=3         " minimum number of lines below cursor
  set foldenable          " auto fold code
  set foldmethod=syntax   " fold based on syntax.
  set foldlevel=100       " start with everything unfolded.
  set showcmd             " show partial command in lower right
  set wrap                " wrap lines

  set list                  " enable the following
  set listchars=tab:>-      " tabs look like '>-'
  set listchars+=trail:\•   " • for extra whitespace
  set listchars+=extends:>  " character to show at end when wrapping
  set listchars+=precedes:< " character to show at beginning when wrapping

  set completeopt=menuone,longest " popup menu for completions, insert longest match first
  set ttyfast             " indicates a fast terminal connection.

  " color trailing whitespace red
  augroup whitespace
    autocmd!
    highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=red guifg=white
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
  augroup END
"}}}

" Status Line {{{
  " SEE vim-airline FOR TAB COMPLETION
  " "<path/to/file.pig      Line: 45/200 Col: 10/ 90 Filetype: [pig] Encoding: utf-8
  " set statusline=%F       " full path to this file, 40 char max
  " set statusline+=%=      " switch to right side
  " set statusline+=Line:\ %l/%L  " line numbers
  " set statusline+=\ Col:\ %c/%{col('$')-1}    " col numbers
  " set statusline+=\ Filetype:\ %y             " filetype
  " set statusline+=\ Encoding:\ %{&encoding}   " file encoding
  set laststatus=2        " always show status line
" }}}

" Etc {{{
  set history=1000  " long history
"}}}

" Plugins Configuration {{{

  " ale {{{
    " E111: Error on 2-space tabs
    " E114: Error on 2-space tabs (comment)
    " W311: Error on 2-space tabs
    " F403: Error on 'from xx import *'
    let g:ale_python_flake8_options = '--ignore=E111,E114,F403,W311'

    if filereadable(expand('~/.at_google'))
      let g:ale_linters = {
      \   'python': [],
      \ }
    endif
  " }}}

  " NERDTree {{{
    nnoremap <leader>nt   :NERDTreeToggle<CR>
    let NERDTreeIgnore = ['\.pyc$']
  " }}}

  " fzf {{{
    " Inside the fzf pane, you can use
    " C-t: Open in tab.
    " C-x: Open in horizontal split.
    " C-v: Open in vertical split.
    noremap <leader>cp :Files<CR>
    noremap <leader>cb :Buffers<CR>
    noremap <leader>ct :Tags<CR>
  " }}}

  " Tabular {{{
    " these patterns only match the first = or : on a line
    nnoremap <Leader>t= :Tabularize /^[^=]*\zs=<CR>
    vnoremap <Leader>t= :Tabularize /^[^=]*\zs=<CR>
    nnoremap <Leader>t: :Tabularize /^[^:]*\zs:<CR>
    vnoremap <Leader>t: :Tabularize /^[^:]*\zs:<CR>
    nnoremap <Leader>t, :Tabularize/(\\|,/l0l0r0r1r0r1r0r1r0r1r0r1<CR>
    vnoremap <Leader>t, :Tabularize/(\\|,/l0l0r0r1r0r1r0r1r0r1r0r1<CR>
  " }}}

  " gundo.vim {{{
    nnoremap <Leader>gu :GundoToggle<CR>
  " }}}

  " vim-airline {{{
    let g:airline_theme="molokai"  " Status bar theme.
  " }}}

  " vim-pandoc {{{
    let g:pandoc#syntax#conceal#use = 0   " disable replacing raw text with pretty versions
  " }}}

  " YouCompleteMe {{{
    " Jump to definition.
    " C-o: Jump back.
    " C-i: Jump forward.
    nnoremap <Leader>yd :YcmCompleter GoTo<CR>

    " Show references in quickfix list.
    nnoremap <Leader>yr :YcmCompleter GoToReferences<CR>

    " A large number, effectively disabling YCM by default.
    let g:ycm_min_num_of_chars_for_completion = 100000

    " Don't let YCM disable Syntastic
    let g:ycm_show_diagnostics_ui = 0

    " Only enable YCM for specific languages.
    let ycm_enabled = 3
    augroup ycm
      autocmd!
      autocmd FileType cpp        let g:ycm_min_num_of_chars_for_completion = ycm_enabled
      autocmd FileType javascript let g:ycm_min_num_of_chars_for_completion = ycm_enabled
      autocmd FileType python     let g:ycm_min_num_of_chars_for_completion = ycm_enabled
      autocmd FileType vim        let g:ycm_min_num_of_chars_for_completion = ycm_enabled
    augroup END
  " }}}

  " vim-poweryank{{{
    " Copy to clipboard over SSH.
    map <Leader>y <Plug>(operator-poweryank-osc52)
  " }}}

" }}}

" Languages {{{
  " vimrc {{{
    augroup vim
      autocmd!
      autocmd FileType vim :setlocal foldmethod=marker
    augroup END
  " }}}

  " giant files {{{
    let g:LargeFile=1024 * 1024 * 10  " bigger than 10MB? disable some options
    function! DisableBigFileOptions(f)
      if getfsize(a:f) > g:LargeFile
        set eventignore+=FileType     " don't detect filetype
        setlocal noswapfile bufhidden=unload undolevels=-1
      else
        set eventignore-=FileType
      endif
    endfunction

    function! MaybeFoldByIndent()
      " Sets foldmethod for buffer based on number of lines.
      if line('$') > 1000
        setlocal foldmethod=indent  " fold based on indentation. 'syntax' is too slow on large files
      endif
    endfunction

    augroup LargeFile
      autocmd!
      autocmd BufReadPre * let f=expand("<afile>") | call DisableBigFileOptions(f)
      autocmd BufReadPost * :call MaybeFoldByIndent()
    augroup END
  " }}}

  " python {{{
    augroup python
      autocmd!
      autocmd FileType python :setlocal tabstop=2 shiftwidth=2 softtabstop=2
    augroup END
  " }}}

  " golang {{{
    augroup golang
      autocmd!
      autocmd FileType go :setlocal tabstop=4 shiftwidth=4 softtabstop=4 foldnestmax=1
    augroup END
  " }}}

  " markdown {{{
    augroup markdown
      autocmd!
      autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    augroup END
  " }}}
" }}}
