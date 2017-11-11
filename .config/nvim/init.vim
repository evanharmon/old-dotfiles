if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath^=$HOME/.config/nvim/repos/github.com/Shougo/dein.vim
set path+=**  " Recursive find
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/dist/*	" OSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  					" Windows

call dein#begin(expand('$HOME/.config/nvim'))
" CORE
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('benekastah/neomake')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-fugitive')
call dein#add('justinmk/vim-sneak')
call dein#add('mhinz/vim-grepper')
" APPEARANCE
call dein#add('mhartington/oceanic-next')
call dein#add('prettier/vim-prettier')
call dein#add('cohama/lexima.vim')
call dein#add('tpope/vim-surround')
call dein#add('Yggdroot/indentLine')
call dein#add('Valloric/MatchTagAlways')
call dein#add('airblade/vim-gitgutter')
" JS / JSX / WEB
call dein#add('pangloss/vim-javascript', { 'on_ft': 'javascript' })
call dein#add('othree/yajs.vim', { 'on_ft': 'javascript' })
call dein#add('othree/html5.vim', { 'on_ft': 'html' })
call dein#add('othree/xml.vim', { 'on_ft': 'xml' })
call dein#add('othree/es.next.syntax.vim', { 'on_ft': 'javascript' })
call dein#add('mxw/vim-jsx')
call dein#add('jparise/vim-graphql', { 'on_ft': ['graphql'] })
call dein#add('mattn/emmet-vim', { 'on_ft': ['javascript', 'javascript.jsx', 'html', 'xml'] })
" OTHERS
call dein#add('vim-scripts/yaml.vim')
call dein#add('fatih/vim-go', { 'on_ft': ['go'] })
call dein#add('rust-lang/rust.vim')
call dein#end()

if dein#check_install()
 call dein#install()
endif

if dein#check_install()
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endif

set mouse=r  " DISABLE MOUSE
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
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
set number						"Hybrid mode
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
set timeoutlen=500
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set conceallevel=1
set undolevels=100
set nowrap
" Stop word wrapping except... on Markdown. That's good stuff.
autocmd FileType markdown setlocal wrap

filetype plugin indent on

" APPEARANCE
syntax enable
" for vim 7
set t_Co=256

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic
hi IndentGuidesOdd  guibg=red   ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4
let &colorcolumn="80,".join(range(120,120),",")
highlight ColorColumn ctermbg=234 guibg=#404042
highlight Pmenu guibg=#161616

" FORMATTING
autocmd FileType go,c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType make setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType neosnippet setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" GENERAL LETS
let g:indentLine_enabled = 1
let g:indentLine_char = "•"
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'fd | ctags --links=no -L-'
let g:lexima_enable_basic_rules = 1  " AUTOCLOSE PAIRS
let g:lexima_enable_newline_rules = 1 " AUTOCLOSE PAIRS
let g:NERDCustomDelimiters = {
    \ 'conf': { 'left': '#' }
    \}
let g:NERDSpaceDelims = 1
let g:rustfmt_autosave = 1
let g:sneak#s_next = 1
let g:deoplete#enable_at_startup = 1
let g:neosnippet#snippets_directory = "~/.config/nvim/mysnips"

" FUNCTIONS
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" NEOMAKE
autocmd! BufWritePost * Neomake
if executable('./node_modules/.bin/eslint')
  let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'
endif
let g:neomake_javascript_eslint_maker = {
    \ 'args': ['-f', 'compact'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_eslint_maker = {
    \ 'args': ['-f', 'compact'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_yaml_enabled_makers = ['yamllint']

" GOLANG
let g:go_snippet_engine = "neosnippet"
let g:go_term_mode = "split"
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" GENERAL KEY MAPPINGS
let mapleader = "\<SPACE>"
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
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>t :Tags<CR>
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
" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" if on iterm2, add key pref for CTRL-H in prefs,
" action send escape sequence,
" type in [104;5u
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap _ <C-w>_

au FileType javascript nmap <leader>fc :/\(\/\/\)\@<!console/<CR>
autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>gt  <Plug>(go-test)
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
