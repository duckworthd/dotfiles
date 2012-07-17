" Plugins {{{
  set nocompatible

  " Load everything in ~/.vim/bundles
  set runtimepath+=~/.vim/bundle/vim-addon-manager/
  call vam#ActivateAddons([
  \ 'github:ervandew/supertab',
  \ 'github:garbas/vim-snipmate',
  \ 'github:MarcWeber/vim-addon-mw-utils',
  \ 'github:tomtom/tlib_vim',
  \ 'github:honza/snipmate-snippets',
  \ 'github:kien/ctrlp.vim',
  \ 'github:xolox/vim-easytags',
  \ 'github:pangloss/vim-javascript',
  \ 'github:scrooloose/nerdtree',
  \ 'github:klen/python-mode',
  \ 'github:vim-scripts/pig.vim',
  \ 'github:derekwyatt/vim-scala',
  \ 'github:tpope/vim-surround',
  \], {'auto_install' : 0})
  " \ 'github:Raimondi/delimitMate',
  " \ 'github:majutsushi/tagbar',
  " \ 'github:jcf/vim-latex'

  " for plugins that don't appear anywhere on git
  set runtimepath+=~/.vim/unmanaged/matlab/
" }}}

" Environment {{{
  if has('win32') || has('win64')
    set backspace=indent,eol,start  " enable backspace
		set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
      " Use /.vim for runtime path on Windows
    set guifont=Consolas:h9:cANSI   " font for GUI on Windows
  endif

  if has('gui_macvim')
    set macmeta   " lets me use <A-...> in MacVim
  endif

  "set clipboard=unnamed    " always copy to windows/mac clipboard for use in other apps
  set hidden                " allow for hidden buffers
  set ffs=unix,dos          " save files with unix line endings
  syntax on                 " syntax highlighting
  filetype plugin indent on " use plugin, indentation style for filetype
  set textwidth=0           " don't automatically cut lines
  set fileencoding=utf-8    " default to UTF-8
  set switchbuf=usetab      " when using :bn and such, iterate across tabs too
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
  silent execute '!mkdir -p ' . s:etcdir
  silent execute '!mkdir -p ' . &backupdir
  silent execute '!mkdir -p ' . &directory
  silent execute '!mkdir -p ' . &viewdir
  au BufWinLeave * silent! mkview
    "save view for files matching '*' when leaving a buffer
  au BufWinEnter * silent! loadview
    "load view for files matching '*' when entering a buffer
"}}}

" Undo History {{{
  if v:version >= 703
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
  noremap <Up>   gk
  noremap <Down> gj

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
"}}}

" UI {{{
  color desert
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
  set foldmethod=expr " fold based on language-specific expr
  set showcmd         " show partial command in lower right
  set wrap            " wrap lines

  set list            " enable the following
  set listchars=tab:\ \   " tabs look like spaces
  set listchars+=trail:\~  " periods for extra whitespace
  set listchars+=extends:>    " character to show at end when wrapping
  set listchars+=precedes:<   " character to show at beginning when wrapping
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
    let g:easytags_file = s:etcdir.'/tags'
      " Where easytags saves its tag info
    let g:easytags_on_cursorhold = 1
      " If you stop typing for a bit, :UpdateTags runs
    "let g:easytags_autorecurse = 1
      " :UpdateTags updates everything in the same directory as
      " the current file.
    nnoremap <leader>ut :UpdateTags --recurse<CR>
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

  " python-mode {{{
    let g:pymode_lint_write = 0     " don't run code checker on save
    let g:pymode_options_indent = 0 " don't step on my indentation
    let g:pymode_options_other = 0  " don't set wrap, textwidth
  " }}}

  " vim-javascript {{{
    let g:html_indent_inctags = "html,body,head,tbody"
    let g:html_indent_script1 = "inc"
    let g:html_indent_style1 = "inc"
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
      au!
      au FileType javascript :call JavaScriptFold()
      au FileType javascript :setlocal fen
    augroup END
  " }}}

  " Pig {{{
    augroup pig
      au!
      au BufNewFile,BufRead *.pig :setlocal filetype=pig syntax=pig foldmethod=indent
        " whenever you open/read a .pig file, use pig syntax
    augroup END
  " }}}

  " vimrc {{{
    augroup vimrc
      au!
      au BufNewFile,BufRead .vimrc :setlocal foldmethod=marker
    augroup END
  " }}}
" }}}
