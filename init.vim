  
" -------------------------------------
"  Maintainer:
"     Bryan Oliver 
"
"  Inspired_by:
"      * https://github.com/feltnerm/dotfiles/blob/master/vimrc
"      * http://amix.dk/vim/vimrc.html
"      * https://github.com/tomasr/dotfiles/blob/master/.vimrc
"      * https://gitlab.com/dwieeb/dotfiles
"
" -------------------------------------
"
"
" TODO LEARNING
"   perform a command, then map that command onto a search
"
"   perform a search and replace, keep part of the found search, and pass it
"   into the replaced line, something like :%s/NeoBundle /call
"   dein#add('$1')/g where $1 is the old string that we don't want to change
"
"   Mark a point and then come back to it

if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
  call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
call dein#begin(expand('~/.config/nvim'))

export NVM_DIR="$HOME/.nvm" 
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm 
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

call dein#add('Shougo/dein.vim')

" default set of vim settings
" if needed, add 
" runtime! plugin/sensible.vim
" then put overrides below that line
call dein#add('tpope/vim-sensible')

" Command execution within vim, not sure how t use yet
" call dein#add('Shougo/vimproc.vim', {'build': {'unix': g:make}})

" -------------------------------------
"  Productivity Plugins
" -------------------------------------

" TODO nvim theme
" Neobundle 'mhartington/oceanic-next'

" fuzzy search for files. Shougo deprecated, see Denite.vim
" call dein#add('Shougo/unite.vim'
" call dein#add('Shougo/denite')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/neomru.vim')
call dein#add('chemzqm/denite-extra')
call dein#add('pocari/vim-denite-gists')

" Outline source for vim-unite. No idea what that means
" call dein#add('Shougo/unite-outline'

" No readme. No idea what this does
" call dein#add('tacroe/unite-mark'

" I'm going to (unsafely) assume this is a color scheme for unite searches
" call dein#add('ujihisa/unite-colorscheme'

if has("nvim")
    " code interactive typing completion 
    call dein#add('Shougo/deoplete.nvim')
else
    " code interactive typing completion, deprecated by shougo in favor of
    " deoplete
    call dein#add('Shougo/neocomplete.vim')
endif

" call dein#local('~/GitHub', {},['nvim-typescript'])


" call dein#add('mhartington/nvim-typescript', {'do': './install.sh'})

" does not work
" call dein#add('mhartington/nvim-typescript')

" display toggle and navigate marks in the sidebar
call dein#add('kshenoy/vim-signature')

" auto-comment stuff with gc or gcc
call dein#add('tpope/vim-commentary')

" auto bracket/quotes. cs"' for example
" TODO - can't get it to work
call dein#add('tpope/vim-surround')

" repeats . with the entire map instead of last native command within the map
call dein#add('tpope/vim-repeat')

" shortcut keymappings from tpope
" [f and ]f navigate between files in a directory
" [os is :set spell
" ]os is :set nospell
" =os :set invspell
call dein#add('tpope/vim-unimpaired')

" Vim sugar for unix shell commands
" :Delete : delete a buffer and the file on disk simultaneously
" :Unlink like delete but keeps the now empty buffer
" :Rename in current directory
" :Chmod permissions of current file
" :SudoWrite write a priveledged file with sudo
" :SudoEdit edit a priv file with sudo
call dein#add('tpope/vim-eunuch')

" Indentation highlights for a file. TODO - couldn't get it to work
call dein#add('nathanaelkane/vim-indent-guides')

" Highlights the first occurences of characters to the left and right of your
" cursor - TODO not working

call dein#add('unblevable/quick-scope')

" text objects to give you more targets
" di' deletes everything within '' or ""
" di]
" di)
" d2i)
call dein#add('wellle/targets.vim')

" save vim sessions 
" :Obsess to start recording
" :Obsess! to throw it away
" vim -S to load it
call dein#add('tpope/vim-obsession')

" Extend % matching for HTML, Latex, and other langs
" TODO - no idea what that means
call dein#add('dwieeb/vim-matchit')

" make your own text objects
call dein#add('kana/vim-textobj-user')

" text objects for indented blocks of lines
" provide text objects to sleect a block of lines which are similarly indented
" to the current line
" TODO - no idea what this means
call dein#add('kana/vim-textobj-indent')

" -------------------------------------
"  Integration Plugins
" -------------------------------------

" gpg
" transparent editing of gpg encrypted files
call dein#add('jamessan/vim-gnupg')

" git
" GBlame
" TODO - learn more commands from this
" TODO - not working
call dein#add('tpope/vim-fugitive')

" shows a git diff in the gutter, with + - lines
" TODO learn commands for going through a diff
call dein#add('airblade/vim-gitgutter')

" es6
" syntax highlighter for js
call dein#add('othree/yajs.vim')

" typescript
call dein#add('HerringtonDarkholme/yats.vim')
call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})

" scss
" syntax for scss
call dein#add('cakebaker/scss-syntax.vim')

" misc
" various syntax hacks for vim
call dein#add('scrooloose/syntastic')

" terraform
" adds the :Terraform command
" :TerraformFmt runs terraform fmt against current buffer
" TODO - wtf is terraform
call dein#add('hashivim/vim-terraform')

" -------------------------------------
"  Appearance & Theme Plugins
" -------------------------------------

call dein#add('mhartington/oceanic-next')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('nanotech/jellybeans.vim')
call dein#add('edkolev/tmuxline.vim')

if dein#check_install()
  call dein#install()
  let pluginsExist=1
endif

call dein#end()

if dein#check_install()
  call dein#install()
  let pluginsExist=1
endif

" --
"  Typescript
" --


" ------------------------------------
"  gitgutter settings
" ------------------------------------

let g:gitgutter_realtime = 1


" if executable('eslint')
"     let g:syntastic_javascript_checkers = [ 'eslint' ]
" endif

let g:syntastic_typescript_checkers = [ 'tslint', 'tsc' ]

let g:syntastic_html_tidy_ignore_errors = [
    \ '<ion-',
    \ '<ui-',
    \ 'discarding unexpected </ion-',
    \ 'discarding unexpected </ui-',
    \ 'proprietary attribute "ng-',
    \ 'proprietary attribute "on',
    \ 'trimming empty <i>' ]
let g:syntastic_quiet_messages = {
    \ "type": "style",
    \ "regex": "main redeclared in this block"}

" ------------------------------------
"  airline settings
" ------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline_theme = 'jellybeans'

" ------------------------------------
"  Unite settings
" ------------------------------------

"call unite#custom#source('file_rec, file_rec/async, file_rec/git', 'matchers', ['converter_relative_word', 'matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#profile('default', 'context.smartcase', 1)
"call unite#custom#profile('default', 'context.ignorecase', 1)
"let g:unite_prompt = '» '
"let g:unite_source_history_yank_enable = 1

" ------------------------------------
"  Unite mark settings
" ------------------------------------

"let g:unite_source_mark_marks =
"            \   "abcdefghijklmnopqrstuvwxyz"
"            \ . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

" ------------------------------------
"  neocomplete/deoplete settings
" ------------------------------------

let g:acp_enableAtStartup = 0

if has("nvim")
    let g:deoplete#enable_at_startup = 1
else
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
endif

" ------------------------------------
"  tmuxline settings
" ------------------------------------

" :Tmuxline airline to set manual colors
" :TmuxlineSnapshot! tmuxline.conf to save colors
let g:tmuxline_preset = 'nightly_fox'
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '}

" -------------------------------------
"  autocommands
" -------------------------------------

" -------
" Import from Mhart's init.vim
" -------
"
autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType javascript,typescript,typescript.tsx,json setl foldmethod=syntax
autocmd FileType html,css,scss,typescript.tsx,vue imap <silent><buffer><expr><tab> <sid>expand_html_tab()
let g:user_emmet_mode='a'
let g:user_emmet_complete_tag = 0
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,typescript.tsx,vue EmmetInstall
autocmd FileType typescript,typescript.tsx setl omnifunc=TSOmniFunc
let g:nvim_typescript#max_completion_detail=50
let g:nvim_typescript#completion_mark=''
let g:nvim_typescript#javascript_support=1
let g:nvim_typescript#expand_snippet=0
" let g:nvim_typescript#vue_support=1
let g:nvim_typescript#diagnostics_enable=1

autocmd FileType typescript,typescript.tsx,javascript map <silent> <leader>gd :TSDoc <cr>
autocmd FileType typescript,typescript.tsx,javascript map <silent> <leader>gt :TSType <cr>
autocmd FileType typescript,typescript.tsx,javascript map <silent> <leader>gtd :TSTypeDef <cr>
autocmd FileType typescript,typescript.tsx,javascript map <silent> <leader>@ :Denite -buffer-name=TSDocumentSymbol TSDocumentSymbol <cr>
autocmd FileType typescript,typescript.tsx,javascript map <silent> <leader># :Denite -buffer-name=TSWorkspaceSymbol TSWorkspaceSymbol <cr>
autocmd FileType typescript,typescript.tsx,javascript map <silent> <leader>ti :TSImport <cr>
autocmd FileType typescript,typescript.tsx,javascript nnoremap <m-Enter> :TSGetCodeFix<CR>

let g:neomake_typescript_enabled_makers = []
" let g:neomake_typescript_enabled_makers = ['nvim_ts']
let g:neomake_vue_enabled_makers = []
let g:neoformat_typescript_prettier = g:standard_prettier_settings
let g:neoformat_enabled_typescript = ['prettier']
let g:nvim_typescript#kind_symbols = {
      \ 'keyword': 'keyword',
      \ 'class': '',
      \ 'interface': '',
      \ 'script': 'script',
      \ 'module': '',
      \ 'local class': 'local class',
      \ 'type': '',
      \ 'enum': '',
      \ 'enum member': '',
      \ 'alias': '',
      \ 'type parameter': 'type param',
      \ 'primitive type': 'primitive type',
      \ 'var': '',
      \ 'local var': '',
      \ 'property': '',
      \ 'let': '',
      \ 'const': '',
      \ 'label': 'label',
      \ 'parameter': 'param',
      \ 'index': 'index',
      \ 'function': '',
      \ 'local function': 'local function',
      \ 'method': '',
      \ 'getter': '',
      \ 'setter': '',
      \ 'call': 'call',
      \ 'constructor': '',
      \}


let s:menus.typescript = {
      \ 'description' : 'typescript commands',
      \}
let s:menus.typescript.command_candidates = [
      \['Get Type', 'TSType' ],
      \['Get Doc', 'TSDoc'],
      \['Edit Project Config', 'TSEditConfig'],
      \['Restart Server', 'TSRestart'],
      \['Start Server', 'TSStart'],
      \['Stop Server', 'TSStop'],
      \]

" --------
"  End import
"  -------



autocmd FileType python BracelessEnable +indent
autocmd BufWritePost ~/.vimrc source ~/.vimrc
autocmd BufReadPre *.js setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.ts setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.yml setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.css setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.scss setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.rst setlocal textwidth=80
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif"`'")"'")

" -------------------------------------
"  Filetype settings for extensions
" -------------------------------------

au BufRead,BufNewFile *.wsgi set filetype=python
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.install set filetype=php
au BufRead,BufNewFile *.schema set filetype=javascript
" au BufRead,BufNewFile *.Vue set filetype=Vue

" -------------------------------------
"  General settings
" -------------------------------------

filetype plugin indent on

" allows scrolling in tmux?
set mouse=a

" When searching try to be smart about cases
set smartcase

" For regular expressions turn magic on
set magic " yer a wizard harry - really dan? lol

" Let me hide a buffer with changes
set hidden

" No annoying sound on errors 
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Make esc faster
" set esckeys

" Folds
" set foldmethod=indent

" TODO what is wildignore
set wildignore+=*.db,*.o,*.obj
set wildignore+=*.swp,*.bak,*.lock
set wildignore+=*.git,*.svn
set wildignore+=*DS_Store*
set wildignore+=**/tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.app,*.dmg,*.pdf,*.so

" TODO
set completeopt-=preview

" -------------------------------------
"  Appearance settings
" -------------------------------------

" TODO lookup each
set background=dark
set t_Co=256
set hlsearch
set cursorline
set listchars=tab:>~,nbsp:_,trail:.
set list
set number
set relativenumber
set numberwidth=5
" TODO
set showcmd
if !has("nvim")
    " TODO
    set lazyredraw
end

colorscheme jellybeans

" -------------------------------------
"  File & backup settings
" -------------------------------------

" TODO
set nobackup
set nowb
set noswapfile

" -------------------------------------
"  Text settings
" -------------------------------------

" Use spaces, damn it! lol
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nowrap
set nojoinspaces
set diffopt+=vertical

" -------------------------------------
"  Keyboard shortcuts
" -------------------------------------

" TODO
let mapleader="\<Space>"

" TODO
inoremap jk <Esc>

" Ex mode: no ty
map Q <Nop>

" Disable accidental macro recording when I spaz out on the q key
map qq <Nop>

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" tabs
nnoremap gwN :tabnew<cr>
nnoremap gwC :tabclose<cr>
nnoremap gwT :wincmd T<cr>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Oceanic
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
colorscheme OceanicNext

" Unite
"nnoremap <Leader>p :Unite -start-insert -no-split -no-resize file_rec/git<cr>
"nnoremap <Leader>f :Unite -start-insert -no-split -no-resize file file/new directory/new<cr>
"nnoremap <Leader>b :Unite -start-insert -no-split -no-resize buffer<cr>
"nnoremap <Leader>y :Unite -start-insert -no-split -no-resize history/yank<cr>
"nnoremap <Leader>o :Unite -start-insert -no-split -no-resize outline<cr>
"nnoremap <Leader>/ :Unite -start-insert -no-split -no-resize -no-empty grep/git:.<cr>


" Neocomplete
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Commands
command! W w
command! Q q
