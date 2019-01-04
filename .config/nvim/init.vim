if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim
set rtp+=/usr/local/opt/fzf
set path+=**  " Recursive find
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/dist/*	" OSX/Linux

let g:python_host_prog=expand('$HOME/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog=expand('$HOME/.pyenv/versions/neovim3/bin/python')
let g:ruby_host_prog=expand('$HOME/.gem/ruby/2.3.0/bin/neovim-ruby-host')

if dein#load_state('~/.cache/dein')
  " CORE
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein')
  " DEOPLETE PLUGINS REQS
  call dein#add('autozimu/LanguageClient-neovim', { 'rev': 'next', 'build': './install.sh' })
  " MAY HAVE TO MANUALLY RUN :GoInstallBinaries or :GoUpdateBinaries
  call dein#add('mattn/webapi-vim')
  call dein#add('fatih/vim-go', { 'on_ft': ['go'], 'build': 'GoInstallBinaries' })
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('mhartington/nvim-typescript', { 'build': './install.sh' })
  call dein#add('rust-lang/rust.vim', { 'on_ft': ['rust'] })
  call dein#add('sebdah/vim-delve', { 'on_ft': ['go'] })
  call dein#add('Shougo/neco-syntax')
  call dein#add('majutsushi/tagbar')

  " DEOPLETE
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-clang')
  call dein#add('zchee/deoplete-go', { 'build': 'make' })
  call dein#add('zchee/deoplete-jedi')
  call dein#add('zchee/deoplete-zsh')

  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('benekastah/neomake')
  call dein#add('junegunn/fzf.vim')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('justinmk/vim-sneak')
  call dein#add('mhinz/vim-grepper')

  " APPEARANCE
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('mhartington/oceanic-next')
  call dein#add('prettier/vim-prettier')
  " call dein#add('cohama/lexima.vim')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-repeat')
  call dein#add('Yggdroot/indentLine')
  call dein#add('Valloric/MatchTagAlways', { 'on_ft': ['javascript', 'javascript.jsx', 'html', 'xml'] })
  call dein#add('airblade/vim-gitgutter')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('jeffkreeftmeijer/vim-numbertoggle')

  " JS / JSX / WEB
  call dein#add('othree/yajs.vim', { 'on_ft': 'javascript' })
  call dein#add('othree/html5.vim', { 'on_ft': 'html' })
  call dein#add('othree/xml.vim', { 'on_ft': 'xml' })
  call dein#add('othree/es.next.syntax.vim', { 'on_ft': 'javascript' })
  call dein#add('othree/javascript-libraries-syntax.vim', { 'on_ft': ['javascript', 'javascript.jsx'] })
  call dein#add('jparise/vim-graphql', { 'on_ft': ['graphql'] })
  call dein#add('mattn/emmet-vim', { 'on_ft': ['javascript', 'javascript.jsx', 'html', 'xml'] })
  call dein#add('vim-scripts/yaml.vim', { 'on_ft': ['yaml'] })
  call dein#add('uarun/vim-protobuf', { 'on_ft': 'proto'})
  call dein#add('iamcco/markdown-preview.nvim', { 'build': 'cd app & yarn install' })

  " CLOUD TOOLS
  call dein#add('hashivim/vim-terraform', { 'on_ft': 'terraform' })
  call dein#add('juliosueiras/vim-terraform-completion', { 'on_ft': 'terraform' })


  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  if dein#check_install()
    call dein#install()
  endif

  if dein#check_update()
    call dein#update()
  endif

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable

set mouse=r  " DISABLE MOUSE
set encoding=utf8
set hidden
set nomodeline
set secure
set nobackup nowritebackup noswapfile autoread
set hlsearch incsearch ignorecase smartcase
set wildmenu
set backspace=indent,eol,start
set clipboard+=unnamed,unnamedplus
set showcmd
set showmatch
set showmode
set ruler
set number relativenumber
set nofoldenable
set scrolloff=1
set sidescrolloff=5
set colorcolumn=+1
set formatoptions+=o
set linespace=0
set noerrorbells
set nojoinspaces
set splitbelow
set splitright
set display+=lastline
set updatetime=250
set timeoutlen=500
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set conceallevel=1
set undolevels=100
set nowrap
set autowrite

" for vim 7
set t_Co=256
" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" APPEARANCE
set background=dark
syntax on
colorscheme OceanicNext
let g:oceanic_next_terminal_bold=1
let g:oceanic_next_terminal_italic=1
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic
highlight Pmenu guibg=#161616

" FORMATTING
au FileType go,c,asm,python,sh setlocal sw=4 ts=4 sts=4 expandtab
au FileType make setlocal sw=4 ts=4 sts=4 noexpandtab

" LANGUAGE SERVERS
let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start'],
    \ 'go': ["$GOPATH/bin/go-langserver"],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

" COMPLETION
let g:neosnippet#enable_completed_snippet=1
let g:neosnippet#snippets_directory="~/.config/nvim/mysnips"
let g:deoplete#enable_at_startup=1

" GENERAL LETS
let g:NERDCustomDelimiters={ 'conf': { 'left': '#' } }
let g:NERDCustomDelimiters={ 'javascript': { 'left': '{/*', 'right': '*/}', 'leftAlt': '//' } }
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:fzf_buffers_jump=1
let g:fzf_history_dir='~/.local/share/fzf-history'
let g:fzf_tags_command='fd | ctags --links=no -L-'
let g:gitgutter_enabled=0
let g:indentLine_char="•"
let g:indentLine_color_term=239
let g:indentLine_enabled=1
let g:lexima_enable_basic_rules=1  " AUTOCLOSE PAIRS
let g:lexima_enable_newline_rules=1 " AUTOCLOSE PAIRS

" JAVASCRIPT
let g:prettier#config#print_width=80
let g:prettier#config#tab_width=2
let g:prettier#config#use_tabs='false'
let g:prettier#config#bracket_spacing='true'
let g:prettier#config#single_quote='true'
let g:prettier#config#trailing_comma='es5'
let g:prettier#config#jsx_bracket_same_line='true'
let g:prettier#exec_cmd_async=1
let g:used_javascript_libs='react'
let g:vim_jsx_pretty_colorful_config=1
let g:jsx_ext_required=0

" GOLANG
let g:go_snippet_engine="neosnippet"
let g:go_term_mode="split"
let g:go_fmt_command="goimports"
let g:go_list_height=0
let g:go_term_mode="split"
let g:go_term_height=10
let g:go_term_width=10
let g:delve_new_command="enew"

let g:sneak#s_next=1
let g:deoplete#sources#clang#libclang_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" RUST
let g:rustfmt_autosave=1
let g:rust_clip_command='pbcopy'

" INFRASTRUCTURE AS CODE
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" FUNCTIONS
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
au! User FzfStatusLine call <SID>fzf_statusline()

" LINTERS / COMPLETIONS
"" NEOMAKE
if executable('./node_modules/.bin/eslint')
  let g:neomake_javascript_eslint_maker={
    \ 'args': ['-f', 'compact'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }
  let g:neomake_jsx_eslint_maker={
    \ 'args': ['-f', 'compact'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }
  let g:neomake_javascript_eslint_exe='./node_modules/.bin/eslint'
  let g:neomake_javascript_enabled_makers=['eslint']
  let g:neomake_jsx_enabled_makers=['eslint']
endif
if executable(expand('$HOME/bin/terraform'))
  let g:neomake_terraform_exe=expand('$HOME/bin/terraform')
  let g:neomake_terraform_maker={
      \ 'args': ['validate'],
      \ 'errorformat': '%f:%l:%c: %m',
      \ }
  if executable(expand('$HOME/bin/tflint'))
    let g:neomake_terraform_tflint_exe=expand('$HOME/bin/tflint')
    let g:neomake_terraform_tflint_maker={
      \ 'args': ['.'],
      \ 'errorformat': '%f:%l:%c: %m',
      \ }
  endif
  let g:neomake_terraform_enabled_makers=['terraform', 'tflint']
endif
let g:neomake_yaml_enabled_makers=['yamllint']
au! BufWritePost * Neomake
"" DEOPLETE
" OMNI IS TOO SLOW AND NOT ASYNC
" let g:deoplete#omni_patterns = {}
" call deoplete#custom#option('omni_patterns', {
  " \ 'complete_method': 'omnifunc',
  " \ 'terraform': '[^ *\t"{=$]\w*',
  " \ })

" call deoplete#initialize()

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file=expand('%')
  if l:file=~#'^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file=~#'^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" COMPLETION
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"


" GENERAL KEY MAPPINGS
let mapleader="\<SPACE>"
nnoremap <leader>= <C-w>=
noremap <leader>q :q<CR>
noremap <leader>w :w<CR>
noremap <leader>q! :q!<CR>
nnoremap <ESC> :noh<return><ESC>
nnoremap <leader><leader> <c-^>
nnoremap <Tab> :bnext!<CR>
nnoremap <S-Tab> :bprev!<CR><Paste>
nnoremap <bar> <C-w><bar>
xnoremap p pgvy
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" File Management
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>m :History<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <leader>* :Grepper -tool rg -cword -noprompt<cr>
nnoremap <leader>g :Grepper -tool rg<cr>
nnoremap <leader>G :Grepper -tool rg -buffers<cr>

" WINDOWS
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" if on iterm2, add key pref for CTRL-H in prefs,
" action send escape sequence, type in [104;5u
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap _ <C-w>_

" FILE TYPE MAPPINGS
au FileType javascript nmap <leader>fc :/\(\/\/\)\@<!console/<CR>
au FileType go nmap <leader>ggb :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>ggt  <Plug>(go-test)
au FileType go nmap <leader>ggr  <Plug>(go-run)
au FileType go nmap <leader>gdd :DlvDebug
au FileType go nmap <leader>gdt :DlvTest
