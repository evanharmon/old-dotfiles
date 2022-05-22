if &compatible
  set nocompatible               " Be iMproved
endif

set rtp+=expand("$HOME/.fzf")
set rtp+=/usr/local/opt/fzf
set rtp+=expand("$HOME/.fnm")
set path+=**  " Recursive find
set path+=~/JUCE/modules
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/dist/*	" OSX/Linux
set shell=/bin/zsh
set tags+=~/JUCE/modules/tags

let g:python_host_prog=expand('$PYENV_ROOT/versions/$PYENV2_NAME/bin/python')
let g:python3_host_prog=expand('$PYENV_ROOT/versions/$PYENV3_NAME/bin/python')
let g:ruby_host_prog=expand('$HOME/.rbenv/shims/neovim-ruby-host')

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif

call plug#begin(expand('$HOME/.local/share/nvim/plugged'))
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'chriskempson/base16-vim'
Plug 'xiyaowong/nvim-transparent'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-grepper'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'hail2u/vim-css3-syntax' " updates vim's built-in css to support CSS3
Plug 'cakebaker/scss-syntax.vim'

Plug 'majutsushi/tagbar'
Plug 'uarun/vim-protobuf'
Plug 'Valloric/MatchTagAlways'
Plug 'vhdirk/vim-cmake'

" not actively using these plugs
" Plug 'rust-lang/rust.vim'
" Plug 'fatih/vim-go'
" Plug 'sebdah/vim-delve'
" Plug 'jph00/swift-apple'
" Plug 'jhkersul/vim-jest-snippets'
" Plug 'jparise/vim-graphql'
" Plug 'hashivim/vim-terraform'
" Plug 'juliosueiras/vim-terraform-completion'

" Devicons Must be last
Plug 'ryanoasis/vim-devicons'

call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}
EOF

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
set timeoutlen=500
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set conceallevel=2
set undolevels=100
set undodir=~/.config/nvim/undodir
set nowrap
set autowrite
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set scrollback=100000
set shiftround

" autocmd BufEnter * silent! lcd %:p:h
" for vim 7
set t_Co=256
" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" APPEARANCE
set background=dark
syntax on
" base16-atlas is good too
colorscheme base16-ia-dark
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic
highlight Pmenu guibg=#161616

" FORMATTING
au FileType go,c,cpp,asm,python,sh,swift,sh,zsh setlocal sw=4 ts=4 sts=4 expandtab
au FileType make setlocal sw=4 ts=4 sts=4 noexpandtab
au FileType markdown setlocal conceallevel=0
au BufRead,BufNewFile Dockerfile* set filetype=Dockerfile
au BufRead,BufNewFile Dockerfile* set syntax=Dockerfile

" GENERAL LETS
let g:gitgutter_enabled=0
let g:indentLine_char="•"
let g:indentLine_color_term=239
let g:indentLine_enabled=1
let g:indentLine_fileTypeExclude=['markdown']
let g:sneak#label=1
let g:mkdp_auto_start=0
let g:mkdp_auto_close=0

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
let g:go_term_mode="split"
let g:go_fmt_command="goimports"
let g:go_list_height=0
let g:go_term_mode="split"
let g:go_term_height=10
let g:go_term_width=10
let g:delve_new_command="enew"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" RUST
let g:rustfmt_autosave=1
let g:rust_clip_command='pbcopy'

" SCSS
au FileType scss set comments^=:///

" CPP
function! ClangCheckImpl(cmd)
  if &autowrite | wall | endif
  echo "Running " . a:cmd . " ..."
  let l:output = system(a:cmd)
  cexpr l:output
  cwindow
  let w:quickfix_title = a:cmd
  if v:shell_error != 0
    cc
  endif
  let g:clang_check_last_cmd = a:cmd
endfunction

function! ClangCheck()
  let l:filename = expand('%')
  if l:filename =~ '\.\(cpp\|cxx\|cc\|c\)$'
    call ClangCheckImpl("clang-check " . l:filename)
  elseif exists("g:clang_check_last_cmd")
    call ClangCheckImpl(g:clang_check_last_cmd)
  else
    echo "Can't detect file's compilation arguments and no previous clang-check invocation!"
  endif
endfunction

nmap <silent> <F5> :call ClangCheck()<CR><CR>
" INFRASTRUCTURE AS CODE
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" FZF SETUP WITH PREVIEW
" fzf + rg + preview
let g:fzf_buffers_jump=1
let g:fzf_history_dir='~/.local/share/fzf-history'
" let g:fzf_tags_command='fd | ctags --links=no -L-'
let g:fzf_tags_command = 'ctags -R'
let $FZF_PREVIEW_COMMAND='bat --color=always {}'
let $FZF_DEFAULT_OPTS='--layout=reverse'
let $BAT_THEME='TwoDark'

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': '--prompt ""'}, 'right:70%'), <bang>0)

" stop fzf preview from traversing back past .git folder
function s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')
endfunction

command! ProjectGFiles execute 'GFiles' s:find_git_root()

" Rip Grep
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always ".shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')}),
  \ <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let vertical = 1
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)
  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&relativenumber', 0)
endfunction

runtime macros/matchit.vim

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
" Still need to fix / test cpp support
" let g:ale_cpp_clangd_options='-compile-commands-dir=build --header-insert=iwyu --suggest-missing-includes'
let g:ale_linters_explicit=1
let g:ale_fix_on_save=1
let g:ale_linters={
\ 'css': ['prettier'],
\ 'go': ['gopls'],
\ 'graphql': ['prettier'],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'javascript.jsx': ['prettier'],
\ 'json': ['prettier'],
\ 'less': ['prettier'],
\ 'markdown': ['prettier'],
\ 'rust': ['rustfmt'],
\ 'scss': ['prettier'],
\ 'sh': ['language_server'],
\ 'swift': ['swiftlint'],
\ 'terraform': ['fmt'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'xml': ['xmllint'],
\ 'yaml': ['prettier'],
\}
" Still need to fix / test cpp support
let g:ale_fixers={
\ 'css': ['prettier'],
\ 'graphql': [],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'javascript.jsx': ['prettier'],
\ 'json': ['prettier'],
\ 'less': ['prettier'],
\ 'markdown': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'scss': ['prettier'],
\ 'yaml': ['prettier'],
\}

" COC SETUP BEGIN
autocmd FileType json syntax match Comment +\/\/.\+$+
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" What is this for????
function! s:check_back_space() abort
  let col=col('.') - 1
  return !col || getline('.')[col - 1]=~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype=='vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
if exists(':CocActionAsync')
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>rn  <Plug>(coc-rename)
" COC SETUP END

" SNIPPETS BEGIN
" Use <C-l> to trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> to select text for visual text of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

let g:coc_snippet_next = '<c-j>' " Use <C-j> to jump to forward placeholder, which is default
let g:coc_snippet_prev = '<c-k>' " Use <C-k> to jump to backward placeholder, which is default
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Make <tab> used for trigger completion, completion confirm, snippet expand
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" SNIPPETS END

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" GENERAL KEY MAPPINGS
let mapleader="\<SPACE>"
nnoremap <leader>= <C-w>=
noremap <leader>q :q<CR>
noremap <leader>w :w<CR>
noremap <leader>q! :q!<CR>
nnoremap <ESC> :noh<return><ESC>
nnoremap <leader><leader> <c-^>
nnoremap <bar> <C-w><bar>

" File Management
nmap <Leader>b :Buffers<CR>
nmap <Leader>p :GFiles<CR>
nmap <Leader>P :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>m :History<CR>


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
" Open file under cursor in vertical split
nnoremap gf :vertical wincmd f<CR>
