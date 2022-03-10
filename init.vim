" -------------------------------------
"  Maintainer:
"     Bryan Oliver 
"
"  Inspired_by:
"      * https://github.com/feltnerm/dotfiles/blob/master/vimrc
"      * http://amix.dk/vim/vimrc.html
"      * https://github.com/tomasr/dotfiles/blob/master/.vimrc
"      * https://gitlab.com/dwieeb/dotfiles
"      * https://github.com/mhartington/dotfiles
"
" -------------------------------------
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

call dein#add('Shougo/dein.vim')

" default set of vim settings
" if needed, add 
" runtime! plugin/sensible.vim
" then put overrides below that line
call dein#add('tpope/vim-sensible')

" ctrlp
call dein#add('kien/ctrlp.vim')

" splitjoin
call dein#add('AndrewRadev/splitjoin.vim')

call dein#add('neoclide/coc.nvim', {'branch': 'release'})

call dein#add('iamcco/coc-angular')

" vim javascript
call dein#add('pangloss/vim-javascript')

" Command execution within vim, not sure how t use yet
" call dein#add('Shougo/vimproc.vim', {'build': {'unix': g:make}})

" -------------------------------------
"  Productivity Plugins
" -------------------------------------
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('kyazdani42/nvim-tree.lua')


" fuzzy search for files
call dein#add('liuchengxu/vim-clap')

if has("nvim")
    " code interactive typing completion 
    call dein#add('Shougo/deoplete.nvim')
else
    " code interactive typing completion, deprecated by shougo in favor of
    " deoplete
    call dein#add('Shougo/neocomplete.vim')
endif

" go auto complete
call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})

let g:deoplete#sources#go#gocode_binary=$HOME.'/go/bin/gocode'


" Launch gopls when Go files are in use
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" nvim-tree settings
let g:nvim_tree_auto_open = 1

" Run gofmt on save
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()


nmap ; :Clap! files<CR>

" auto-comment stuff with gc or gcc
call dein#add('tpope/vim-commentary')

" airline
call dein#add('vim-airline/vim-airline')

" ale
call dein#add('dense-analysis/ale')

" auto bracket/quotes. cs"' for example
" TODO - can't get it to work
call dein#add('tpope/vim-surround')

" repeats . with the entire map instead of last native command within the map
call dein#add('tpope/vim-repeat')

" golang
call dein#add('fatih/vim-go')

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

let g:indent_guides_start_level = 2
set ts=2 sw=2 et


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
call dein#add('tmhedberg/matchit')

" make your own text objects
call dein#add('kana/vim-textobj-user')

" text objects for indented blocks of lines
" provide text objects to sleect a block of lines which are similarly indented
" to the current line
call dein#add('kana/vim-textobj-indent')

" -------------------------------------
"  Integration Plugins
" -------------------------------------

" gpg
" transparent editing of gpg encrypted files
call dein#add('jamessan/vim-gnupg')

" :Git diff
" :Git add
" :Git commit
" :Git blame
call dein#add('tpope/vim-fugitive')

" ------------------------------------------------------------
" shows a git diff in the gutter, with + - lines
" You can explicitly turn vim-gitgutter off and on (defaults to on):

" turn off with :GitGutterDisable
" turn on with :GitGutterEnable
" toggle with :GitGutterToggle.
" To toggle vim-gitgutter per buffer:

" turn off with :GitGutterBufferDisable
" turn on with :GitGutterBufferEnable
" toggle with :GitGutterBufferToggle
" You can turn the signs on and off (defaults to on):

" turn on with :GitGutterSignsEnable
" turn off with :GitGutterSignsDisable
" toggle with :GitGutterSignsToggle.
" And you can turn line highlighting on and off (defaults to off):

" turn on with :GitGutterLineHighlightsEnable
" turn off with :GitGutterLineHighlightsDisable
" toggle with :GitGutterLineHighli

" turn on with :GitGutterLineNrHighlightsEnable
" turn off with :GitGutterLineNrHighlightsDisable
" toggle with :GitGutterLineNrHighlightsToggle.
call dein#add('airblade/vim-gitgutter')

" es6
" syntax highlighter for js
call dein#add('othree/yajs.vim')

" typescript
call dein#add('HerringtonDarkholme/yats.vim')

" TSDef
" TSDoc
" TSTypeDef
" call dein#local('~/GitHub', {},['nvim-typescript'])
call dein#local('~/Github', {},['nvim-typescript'])

" scss
" syntax for scss
call dein#add('cakebaker/scss-syntax.vim')

" misc
" various syntax hacks for vim
call dein#add('scrooloose/syntastic')

" terraform
" adds the :Terraform command
" :TerraformFmt runs terraform fmt against current buffer
call dein#add('hashivim/vim-terraform')

" -------------------------------------
"  Appearance & Theme Plugins
" -------------------------------------

" Blue vim theme
call dein#add('mhartington/oceanic-next', {'build': './install.sh'})

" Tmux status line
call dein#add('edkolev/tmuxline.vim')

" Install all the things above this line
if dein#check_install()
  call dein#install()
endif
call dein#end()

syntax on 

" ------------------------------------
"  gitgutter settings
" ------------------------------------

let g:gitgutter_realtime = 1


" if executable('eslint')
"     let g:syntastic_javascript_checkers = [ 'eslint' ]
" endif

" Ignore custom html ionic tags
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
"  golang settings
" ------------------------------------
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" let g:go_auto_sameids = 1

" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" ------------------------------------
"  airline settings
" ------------------------------------

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
" let g:airline_theme = 'jellybeans'

" ------------------------------------
"  neocomplete/deoplete settings
" ------------------------------------

let g:acp_enableAtStartup = 0

if has("nvim")
    " let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources={} 
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

" disaledeoplete for scala
autocmd FileType scala let b:deoplete_disable_auto_complete = 1


" -------
" Import from Mhart's init.vim
" -------
" Todo readd and fix typescript
" 
autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType javascript,typescript,typescript.tsx,json setl foldmethod=syntax
autocmd FileType html,css,scss,typescript.tsx,vue imap <silent><buffer><expr><tab> <sid>expand_html_tab()
let g:user_emmet_mode='a'
let g:user_emmet_complete_tag = 0
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,typescript.tsx,vue EmmetInstall
" autocmd FileType typescript,typescript.tsx setl omnifunc=TSOmniFunc
" autocmd FileType typescript,typescriptreact,javascript setl omnifunc=TSOmniFunc
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gd :TSDoc <cr>
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gt :TSType <cr>
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gtd :TSTypeDef <cr>
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gtD :TSDef <cr>
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>@ :Denite -buffer-name=TSDocumentSymbol TSDocumentSymbol <cr>
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader># :Denite -buffer-name=TSWorkspaceSymbol TSWorkspaceSymbol <cr>
" autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>ti :TSImport <cr>
" autocmd FileType typescript,typescriptreact,javascript nnoremap <m-Enter> :TSGetCodeFix<CR>

" --------
"  End import
"  -------
let g:python3_host_prog=/usr/bin/python3
autocmd FileType python BracelessEnable +indent
autocmd BufWritePost ~/.vimrc source ~/.vimrc
autocmd BufReadPre *.js setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.ts setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.yml setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.css setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.scss setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
autocmd BufReadPre *.rst setlocal textwidth=80
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

" -------------------------------------
"  Filetype settings for extensions
" -------------------------------------

au BufRead,BufNewFile *.wsgi set filetype=python
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.install set filetype=php
au BufRead,BufNewFile *.schema set filetype=javascript
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

" -------------------------------------
"  General settings
" -------------------------------------

filetype plugin indent on
filetype plugin on

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
set wildignore+=*.db,*.o,*.obj
set wildignore+=*.swp,*.bak,*.lock
set wildignore+=*.git,*.svn
set wildignore+=*DS_Store*
set wildignore+=**/tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.app,*.dmg,*.pdf,*.so
set completeopt-=preview

" -------------------------------------
"  Appearance settings
" -------------------------------------

set background=dark
set t_Co=256
set hlsearch
set cursorline
set listchars=nbsp:_,trail:.,tab:\ \
"set list
set number
set relativenumber
set numberwidth=5
set showcmd
if !has("nvim")
    set lazyredraw
end

" -------------------------------------
"  File & backup settings
" -------------------------------------

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
"
let g:clap_insert_mode_only = v:true
let g:clap_layout = { 'relative': 'editor' }
let g:clap_enable_icon = 1
let g:clap_theme = 'oceanicnext'
nnoremap <silent> <c-p>      :Clap files<CR>
nnoremap <silent> <leader>a  :Clap grep<CR>
nnoremap <silent> <leader>h  :Clap help_tags<CR>
nnoremap <silent> <leader>u  :DeinUpdate<CR>
noremap <silent> <leader>f :Neoformat<CR>
let g:neoformat_vue_prettier = {
      \ 'exe': 'vue-formatter',
      \ 'stdin': 1,
      \}
let g:neoformat_zsh_shfmt = {
      \ 'exe': 'shfmt',
      \ 'args': ['-i ' . shiftwidth()],
      \ 'stdin': 1,
      \ }
let g:neoformat_enabled_zsh = ['shfmt']
let mapleader="\<Space>"
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

" Neocomplete
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Commands
command! W w
command! Q q

colorscheme OceanicNext

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by COC LanguageClient [LC]
let g:go_def_mapping_enabled = 0
