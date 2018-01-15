" How directories are handled:
"   - the working directory is set to the dir that vim is opened in.
"   - while working in a project, I'll leave this as the base dir, as
"   this makes it easy for easy-tags to find the tags file.
"   - just use NT to create new files, as you can choose the dir to
"   put it in.

:let mapleader = ","

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'Valloric/YouCompleteMe'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'sjl/vitality.vim'
Plug 'danro/rename.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/vim-auto-save'
Plug 'xolox/vim-easytags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'
call plug#end()

" Make * start on current word
:nnoremap * *N

" Show full file path in status bars
set statusline+=%F

" Toggle tagbar
nmap <Leader>tb :TagbarOpenAutoClose<CR>
let g:tagbar_sort = 0

" Configure vim-easyclip
" - 'm' command shadows Vim's 'add mark' command, so map that
"   to something else
nnoremap am m

" Configure vim-fugitive
nnoremap <Leader>b :Gblame<Enter>

" Quick way to close/delete current buffer
nnoremap <Leader>d :bdelete<Enter>

" Quick way to switch to last active buffer
nmap <Tab> :b#<Enter>

" Use j and k for PageUp and PageDown
"nnoremap <C-k> <PageUp>
"nnoremap <C-j> <PageDown>
nnoremap <C-k> <C-u> 
nnoremap <C-j> <C-d>

" Quick way to sort selected lines
vnoremap <Leader>su :sort u<Enter>

" Configure vim-autosave (used to get syntastic to show results quicker)
"let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
"let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
"let g:auto_save_silent = 0  " do not display the auto-save notification
""let g:auto_save_postsave_hook = 'TagsGenerate'  " this will run :TagsGenerate after each save

" Configure BufExplorer
nnoremap <Leader>e :ToggleBufExplorer<Enter>

" Tell Vim to look for a tags file in the directory of the current
" file, in the current directory and then search up until your $HOME,
" stopping on the first hit
set tags=./tags,tags;$HOME

" Configure vim-easytags
" look for a project-specific tags file
" - option 2 means create a project-specific file if it doesn't exist
":set tags=./tags;
:let g:easytags_dynamic_files = 1
" update tags file asyncrounously, as Vim locks otherwise
:let g:easytags_async = 3
" Note- ~/.ctags is where I define the various patterns that should
" be excluded by exuberant ctags when it's generating tags.

" Configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" Ignore line-too-long errors:
let g:syntastic_quiet_messages = { 'regex': 'E501' }
nnoremap <Leader>s :SyntasticCheck<Enter>

" Configure vim-session
let g:session_autosave = 'yes'
let g:session_autoload = 'no'

" Ultisnips config
set runtimepath+=~/.vim/my_snippets/
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
let g:UltiSnipsSnippetsDir="~/.vim/my_snippets/UltiSnips"

" Mappings to help with setting trace points with ipdb
" allow for quick insertion of ipdb.set_trace above current line
nnoremap <Leader>I Oimport ipdb; ipdb.set_trace(); ##############NOPUSH<esc>
nnoremap <Leader>i oimport ipdb; ipdb.set_trace(); ##############NOPUSH<esc>
" delete all debug lines lines in a file
nnoremap <Leader>id :g/import ipdb/d<CR>

" Nerdcommenter config
let g:NERDCreateDefaultMappings = 0
filetype plugin on
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" use toggle command to comment based on top line
nnoremap <silent> <Leader>c :call NERDComment(0,"toggle")<C-m>
vnoremap <silent> <Leader>c :call NERDComment(0,"toggle")<C-m>

" NERDTree config
let NERDTreeIgnore = ['\.pyc$']
nnoremap <Leader>n :NERDTreeToggle<Enter>
" open NERDTree on the file you're editing
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" automatically delete the buffer of a file deleted in NerdTree
let NERDTreeAutoDeleteBuffer = 1
" auto close NerdTree after opening a file
let NERDTreeQuitOnOpen = 1
" Use 'x' for toggling the zoom, like in tag browser
let NERDTreeMapCloseDir='\x'
let NERDTreeMapToggleZoom='x'

" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" Auto-save files when focus lost
:au FocusLost * silent! wa

" Toggle line highlight based on Insert mode
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
b
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$|log\|tmp$|',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Make clipboard accessible to OS X
set clipboard=unnamed

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*/node_modules,*/assets,*/CVS,*/_work,*/static/v,*/casperjs
set wildignore+=*/hiprender/assets

" Automatically load changes to files
set autoread
" above doesn't work by itself; this ties the checks to cursor movements
au CursorHold,CursorHoldI * checktime

" Setup up colorscheme
let g:rehash256 = 1 " bring 256 color version as close to GUI version as poss
colorscheme molokai

" Various UI settings
" In normal vim, the font is determined by the terminal settings, but
" in MacVim, we need to set this explicitly:
set guifont=Monaco:h16
set guioptions=
set colorcolumn=80
highlight ColorColumn ctermbg=7

" Macvim-specific settings
let macvim_skip_colorscheme=1
" don't blink cursor
set gcr=a:blinkon0

" Ctrlp configuration
" set current working directory based on .git location
let g:ctrlp_working_path_mode = 'r'
"nnoremap <Leader>p :CtrlPTag<Enter>
nnoremap <Leader>r :CtrlPBufTag<Enter>

" Command-T configuration 
let g:CommandTMaxFiles=300000
nnoremap <Leader>ra :CommandTTag<Enter>
" make <esc> key work for exiting command-t
"""
set ttimeoutlen=50
if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
endif
"""

" Grep'ing/Ag'ing for files
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
"------------------------------------------------------------
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number
 
" Time out on keycodes
set ttimeout ttimeoutlen=200
" Time out mappings
set timeoutlen=500
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
 
"------------------------------------------------------------
" Indentation options
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
"------------------------------------------------------------
" Mappings
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
"nnoremap <C-L> :nohl<CR><C-L>
" also, clear all syntax checking info from screen
nnoremap <C-L> :nohl<CR>:SyntasticReset<CR><C-L>

 
" Turn on word wrapping
set wrap
set textwidth=79
"------------------------------------------------------------
