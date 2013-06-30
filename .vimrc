" Plugins {{{
  set nocompatible

  " Load everything in ~/.vim/bundles
  set runtimepath+=~/.vim/bundle/vim-addon-manager/
  call vam#ActivateAddons([
  \ 'github:MarcWeber/vim-addon-mw-utils',
  \ 'github:altercation/vim-colors-solarized',
  \ 'github:derekwyatt/vim-scala',
  \ 'github:digitaltoad/vim-jade',
  \ 'github:ervandew/supertab',
  \ 'github:garbas/vim-snipmate',
  \ 'github:honza/vim-snippets',
  \ 'github:JuliaLang/julia-vim',
  \ 'github:kien/ctrlp.vim',
  \ 'github:Lokaltog/vim-easymotion',
  \ 'github:mileszs/ack.vim',
  \ 'github:scrooloose/nerdtree',
  \ 'github:scrooloose/syntastic',
  \ 'github:Shougo/unite.vim',
  \ 'github:Shougo/vimproc.vim',
  \ 'github:tomtom/tlib_vim',
  \ 'github:tpope/vim-surround',
  \ 'github:vim-scripts/pig.vim',
  \ 'github:xolox/vim-easytags',
  \ 'github:xolox/vim-misc',
  \], {'auto_install' : 0})
  " \ 'github:hattya/python_fold.vim',  " slow slow slow
  " \ 'github:pangloss/vim-javascript', " slow slow slow
  " \ 'github:Raimondi/delimitMate',    " gets in the way
  " \ 'github:sontek/rope-vim',         " slow slow slow
  " \ 'github:majutsushi/tagbar',       " doesn't work when I need it
  " \ 'github:jcf/vim-latex'            " messes with my shortcuts
  " \ 'github:klen/python-mode',        " slow slow slow
  " \ 'github:xolox/vim-shell',         " never use it
  " \ 'github:Valloric/YouCompleteMe',  " crashes

  " for plugins that don't appear anywhere on git
  set runtimepath+=~/.vim/unmanaged/matlab/
" }}}

" Environment {{{
  if has('win32') || has('win64')
    set backspace=indent,eol,start  " enable backspace
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
      " Use /.vim for runtime path on Windows
    set guifont=Consolas:h9:cANSI   " font for GUI on Windows
    set clipboard=unnamed           " copy to clipboard
  endif

  if has('gui_macvim')
    set macmeta   " lets me use <A-...> in MacVim
    set guifont=Consolas:h12
  endif

  if has('unix') && !has('mac')
    set guifont=Monospace\ 9
  endif

  "set clipboard=unnamed    " always copy to windows/mac clipboard for use in other apps
  set hidden                " allow for hidden buffers
  set ffs=unix,dos          " save files with unix line endings
  syntax on                 " syntax highlighting
  filetype plugin indent on " use plugin, indentation style for filetype
  set textwidth=0           " don't automatically cut lines
  set fileencoding=utf-8    " default to UTF-8
  set switchbuf=usetab      " when using :bn and such, iterate across tabs too
  set mouse=a               " enable mouse usage on some terminals
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


  set backup                          " enable backups
  let s:etcdir=$HOME.'/.vimetc/'
  let &backupdir=s:etcdir.'backup/'   " backup directory
  let &directory=s:etcdir.'swap/'     " swap file directory (crash recovery)
  let &viewdir=s:etcdir.'views/'      " view directory (where you last were)
  if !has('win32') && !has('win64')
    silent execute '!mkdir -p ' . s:etcdir
    silent execute '!mkdir -p ' . &backupdir
    silent execute '!mkdir -p ' . &directory
    silent execute '!mkdir -p ' . &viewdir
    autocmd BufWinLeave * silent! mkview
      "save view for files matching '*' when leaving a buffer
    autocmd BufWinEnter * silent! loadview
      "load view for files matching '*' when entering a buffer
  else
    set noswapfile nobackup nowritebackup
  endif
  set viminfo=                          " disable viminfo
"}}}

" Undo History {{{
  if !has('win32') && !has('win64') && v:version >= 703
    set undofile        " Save undo's after file closes
    let &undodir=s:etcdir.'undo/' " where to save undo histories
    silent execute '!mkdir -p ' . &undodir
    set undolevels=1000     " How many undos
    set undoreload=10000    " number of lines to save for undo
  end
" }}}

" Keys {{{
  " Switching splits
  noremap <C-j> <C-W>j
  noremap <C-k> <C-W>k
  noremap <C-l> <C-W>l
  noremap <C-h> <C-W>h

  noremap <C-Up>    <C-W>k
  noremap <C-Down>  <C-W>j
  noremap <C-Left>  <C-W>h
  noremap <C-Right>   <C-W>l

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
    if &relativenumber == 0
      set relativenumber
    else
      set number
    endif
  endfunction

  " clear highlighted search term
  nnoremap <silent> <Esc> :nohlsearch<CR>
  nnoremap <silent> <C-c> :nohlsearch<CR>

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
  inoremap <C-f>  <C-o>w
  inoremap <C-b>  <C-o>b

  " alternatives to arrow keys in insert mode (steps on switch split keys)
  " inoremap <C-j>  <Down>
  " inoremap <C-k>  <Up>
  " inoremap <C-h>  <Left>
  " inoremap <C-l>  <Right>

  " fix weird behaviour in xterm that results in arrow keys entering 'ABCD'
  noremap OD  <Left>
  noremap OC  <Right>
  noremap OA  <Up>
  noremap OB  <Down>

  " Disable help by F1
  noremap <F1> <Nop>
  inoremap <F1> <Nop>
"}}}

" UI {{{
  if has('win32') || has('win64')
    color desert
  else
    color solarized
    if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
      let g:solarized_termcolors = &t_Co  " solarized has bugs in Terminal.app
      let g:solarized_termtrans = 1
      colorscheme solarized
    endif
  endif
  set background=dark " dark background
  set cursorline      " Hightlight current line
  set ruler           " Show line ruler
  set number          " line numbers
  set hlsearch        " highlight search matches
  set incsearch       " search before enter
  set ignorecase      " ignore case if all lower case search
  set smartcase       " case sensitive if upper case search
  set wildmenu        " see options listed
  set scrolloff=3     " minimum number of lines below cursor
  set foldenable      " auto fold code
  " set foldmethod=expr " fold based on language-specific expr
  set showcmd         " show partial command in lower right
  set wrap            " wrap lines

  set list            " enable the following
  set listchars=tab:\ \   " tabs look like spaces
  set listchars+=trail:\~  " periods for extra whitespace
  set listchars+=extends:>    " character to show at end when wrapping
  set listchars+=precedes:<   " character to show at beginning when wrapping

  set completeopt=menuone,longest " popup menu for completions, insert longest match first
"}}}

" Status Line {{{
  "<path/to/file.pig      Line: 45/200 Col: 10/ 90 Filetype: [pig] Encoding: utf-8
  set statusline=%F       " full path to this file, 40 char max
  set statusline+=%=      " switch to right side
  set statusline+=Line:\ %l/%L  " line numbers
  set statusline+=\ Col:\ %c/%{col('$')-1}    " col numbers
  set statusline+=\ Filetype:\ %y             " filetype
  set statusline+=\ Encoding:\ %{&encoding}   " file encoding
  set laststatus=2        " always show status line
" }}}

" Etc {{{
  set history=1000  " long history
  set spell         " spell check
"}}}

" Plugins {{{
  if has('win32') || has('win64')
    let s:ctags_loc = $HOME.'/.vim/lib/ctags58/ctags'
  else
    let s:ctags_loc = 'ctags'
  endif

  " TagBar {{{
    nnoremap <leader>tb :TagbarToggle<CR>
      " Open/Close TagBar
    let g:tagbar_autoclose = 0
      " Don't close tagbar when selecting a tag
    let g:tagbar_ctags_bin = s:ctags_loc
      " where to find ctags
  " }}}

  " easytags {{{
    let g:easytags_cmd  = s:ctags_loc
    let g:easytags_file = s:etcdir.'tags'
      " Where easytags saves its tag info
    let g:easytags_on_cursorhold = 0
      " If you stop typing for a bit, :UpdateTags runs
    let g:easytags_autorecurse = 1
      " :UpdateTags updates everything in the same directory as
      " the current file.
    nnoremap <leader>ut :UpdateTags<CR>
      " Force tag update for all files under the source tree of the
      " currently open file.
  " }}}

  " NERDTree {{{
    nnoremap <leader>nt   :NERDTreeToggle<CR>
  " }}}

  " CtrlP {{{
    let g:ctrlp_working_path_mode = 2
      " 0: use pwd
      " 1: use directory of current file
      " 2: use nearest ancestor with .git, .svn. or whatever
    noremap <leader>cp :CtrlP<CR>
    noremap <leader>cb :CtrlPBuffer<CR>
  " }}}

  " " python-mode {{{
  "   let g:pymode_lint = 0           " don't run code checker on save
  "   let g:pymode_indent = 0         " don't step on my indentation
  "   let g:pymode_options = 0        " don't set wrap, textwidth
  " " }}}

  " rope {{{
    " see Python section of languages
  " }}}

  " vim-javascript {{{
    let g:html_indent_inctags = "html,body,head,tbody"
    let g:html_indent_script1 = "inc"
    let g:html_indent_style1 = "inc"
  " }}}

  " EasyMotion {{{
    let g:EasyMotion_leader_key = '<Space>'
  " }}}

  " unite.vim {{{
    call unite#filters#matcher_default#use(['matcher_fuzzy']) " use fuzzy matching

    " enable copy/paste history
    let g:unite_source_history_yank_enable = 1
    let g:unite_enable_start_insert = 1
    let g:unite_enable_short_source_names = 1
    " nnoremap <leader>t :<C-u>Unite -start-insert file_rec<CR>
    " nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
    nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
    nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    -start-insert history/yank<cr>
    nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  -start-insert buffer<cr>

    " Custom mappings for the unite buffer
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      " Play nice with supertab
      let b:SuperTabDisabled=1
      " Enable navigation with control-j and control-k in insert mode
      imap <buffer> <C-j>   <Plug>(unite_select_next_line)
      imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    endfunction

  " }}}
" }}}

" Languages {{{
  " Javascript {{{
    function! JavaScriptFold()
      setlocal foldmethod=syntax
      setlocal foldlevelstart=0
      syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend

      function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
      endfunction
      setlocal foldtext=FoldText()
    endfunction

    augroup javascript
      autocmd!
      autocmd FileType javascript :call JavaScriptFold()
      autocmd FileType javascript :setlocal foldenable foldmethod=syntax
    augroup END
  " }}}

  " Pig {{{
    augroup pig
      autocmd!
      autocmd BufNewFile,BufRead *{.pig,.pig.substituted,.pig.expanded} :setlocal filetype=pig syntax=pig foldmethod=indent
        " whenever you open/read a .pig file, use pig syntax
    augroup END
  " }}}

  " Python {{{
    augroup python
      autocmd!
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete " use pythoncomplete for tab completion
      autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-n>"   " use preceding characters to decide what to show

      " go to def, rename in python
      autocmd FileType python map <leader>j :RopeGotoDefinition<CR>
      autocmd FileType python map <leader>r :RopeRename<CR>
      autocmd Filetype python setlocal foldmethod=indent
    augroup END
  " }}}

  " vimrc {{{
    augroup vim
      autocmd!
      autocmd FileType vim :setlocal foldmethod=marker
    augroup END
  " }}}
  "
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

    augroup LargeFile
      autocmd!
      autocmd BufReadPre * let f=expand("<afile>") | call DisableBigFileOptions(f)
    augroup END
  " }}}
" }}}
