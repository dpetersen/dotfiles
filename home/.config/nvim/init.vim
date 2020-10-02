" Disable vi compatibility
set nocompatible

" Used for some plugins to display fancy symbols.  Hopefully doesn't blow
" things up.
set encoding=utf-8

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'spiiph/vim-space'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-bundler'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-obsession'
Plug 'noprompt/vim-yardoc'
Plug 'tpope/vim-eunuch'
Plug 'mhinz/vim-startify'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/tcd.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-dispatch'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoyank.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'plasticboy/vim-markdown', { 'for': [ 'md', 'markdown' ] }
Plug 'hashivim/vim-terraform', { 'for': 'tf' }
Plug 'vim-ruby/vim-ruby', { 'for': 'rb' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rhysd/vim-go-impl', { 'for': 'go' }
Plug 'leafgarland/typescript-vim', { 'for': 'ts' }
Plug 'Quramy/tsuquyomi', { 'for': 'ts' }
Plug 'jason0x43/vim-js-indent', { 'for': 'js' }
Plug 'tpope/vim-jdaddy', { 'for': 'json' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile', 'for': 'yaml'} 
Plug 'janko-m/vim-test'
Plug 'towolf/vim-helm'

call plug#end()

let mapleader=","
let maplocalleader=","

" Use higher contrast zenburn scheme
let g:zenburn_high_Contrast=1
colorscheme zenburn

" No need for the Error Bell in any form, thanks
set noerrorbells
set novisualbell

" Use filetype appropriate indent
filetype plugin indent on

" As recommended by coc.nvim. Milliseconds until swap is written, but also
" used for CursorHold event that is essentially the "hover" event, I think.
set updatetime=300

" Automatically indent
set autoindent
set smartindent

" Always try and do syntax highlighting
syntax on

" Use spaces instead of tabs at the start of the line
set smarttab
set expandtab

" Highlight the line that the cursor is on.
set cursorline

" Always show line numbers
set number

" Reset the window title in non-GUI mode to something a little more helpful.
set title

" Use a manual foldmethod so that folds persist in files
set foldmethod=marker

" Tab completion in command mode shows all possible completions, shell style.
set wildmenu
set wildmode=longest:full,full

" Remember global variables across vim sessions
set viminfo^=!

" Set minimum split height to 1 line instead of 2
set wmh=0

" A split will default to being creating under or to the right of the current.
set splitbelow splitright

" Always show diffs veritcally regardless of the space available. Horizontal
" diffs are unreadable to me.
set diffopt=vertical

" Indent plugin settings for Zenburn
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
augroup indentguidesaugroup
  autocmd!
  autocmd VimEnter,Colorscheme * hi IndentGuidesOdd ctermbg=236
  autocmd VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=240
augroup END

" Show a statusline always.
set laststatus=2

" Custom Fugitive shortcuts
noremap <leader>gs :Gstatus <CR>
noremap <leader>gc :Gcommit <CR>
noremap <leader>gd :Gdiff <CR>
noremap <leader>gb :Gblame <CR>

" Use slim highlighting for emblem templates
augroup emblem_as_slim_augroup
  autocmd BufNewFile,BufRead *.emblem set filetype=slim
augroup END

" Make Y behave to EOL like most capitolized normal-mode commands.
noremap Y y$

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" Close omnicompletion preview window when you are finished inserting.
" source:
" http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove-the-preview-window-after-autocompletion-in-vim
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Allow reselection of last pasted text.
" source:
" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Toggle paste mode on and off.
" source: http://amix.dk/vim/vimrc.html
map <leader>pp :setlocal paste!<cr>

" Ale linter options
let g:ale_linters = {'go': ['gofmt', 'go build']}
let g:airline#extensions#ale#enabled = 1

" Fix for UTF-8 annoyances in vagrant ubuntu
let g:NERDTreeDirArrows=0

" Let me toggle NERDTree easiy
nnoremap <leader>nt :NERDTreeToggle<cr>

" Show NERDTree next to startify when you start without selecting a file.
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif
" Don't open NERDTree's selection in a split under startify.
autocmd User Startified setlocal buftype=

" Don't use the special powerline fonts in the tmux theme, since I don't have
" or want that. Well, maybe I want it, but...
let g:tmuxline_powerline_separators = 0

au BufNewFile,BufRead *.dockerfile set filetype=dockerfile

" For the terraform plugin and to consistently format Terraform files.
let g:terraform_fmt_on_save = 1

" Use ripgrep for search if available
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" https://vim.fandom.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" it's incredibly flakey and often folds mid-edit, sometimes making editing
" impossible
let g:vim_markdown_folding_disabled = 1

" CoC stuff options {{{

" I'm going to wait a minute before I just globally remap a bunch of stuff for
" CoC, but I will put some of it here and then in specific languages probably
" copy-paste a few things before I completely switch to this plugin.

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" }}}

" Unite mappings {{{
map <leader>ar :UniteResume<CR>
map <leader>ab :Unite -no-split -start-insert buffer<CR>
map <leader>ay :Unite -start-insert history/yank<CR>
map <leader>af :Unite -no-split -start-insert file_rec/neovim<CR>
map <leader>ag :Unite grep:.<CR>

let g:unite_source_grep_command = 'rg'
let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
let g:unite_source_grep_recursive_opt = ''

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
        inoremap <silent><buffer><expr> <C-x> unite#do_action('split')
        inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction
" }}}

" My custom normal/insert mode mappings {{{

" Remap jk or to be the same as Esc to leave Insert mode.
inoremap jk <Esc>
inoremap jj <Esc>
inoremap <esc> <nop>

" Quick editing and reloading of .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" C-j in insert mode escapes normal mode and writes the file. With shift,
" write and quit. This requires a terminal setting or it might just freeze
" your display and nothing else, which is rad. See:
" http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
inoremap <C-j> <Esc>:w<Enter>
inoremap <C-s> <Esc>:w<Enter>
nnoremap <C-s> :w<Enter>

" '<leader>dp/s/v' brings up an :e/sp/vsp prompt in the context of the current file's directory
noremap <leader>dp :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>ds :sp <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>dv :vsp <C-R>=expand("%:p:h") . "/" <CR>

" '<leader>df' opens up NetRW in the directory of the current file
noremap <leader>df <leader>dp<CR>

" '<leader>dd' opens up NetRW in Vim's current directory
noremap <leader>dd :e .<CR>

" Create directional shortcuts for moving among between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" Toggle TagBar. I don't use it a lot, but it's helpful.
nnoremap <leader>t :TagbarToggle<CR>

" It's 'm' for make. Even though it's not running make. Deal with it.
nnoremap <leader>m :Dispatch<CR>

" Close/open quickfix/preview windows from anywhere. Why has it taken me so
" long to map this?
nnoremap <leader>qq :cclose<CR>
nnoremap <leader>qp :pclose<CR>
nnoremap <leader>qo :copen<CR>

" C-Enter in insert mode starts a new indented line below. I know this doesn't
" *look* like Ctrl-Enter, but that seems to be how it's sent in iterm2.
" Hopefully that carries over to other places I work.
inoremap <C-M> <Esc>o

" Base64 encode/decode. Special detection because, of course, OSX has its own
" super special base64 that doesn't do stuff like base64 encode things?
if has("unix")
  vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>

  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    vnoremap <leader>64e c<c-r>=system('base64 -w0', @")<cr><esc>
  else
    vnoremap <leader>64e c<c-r>=system('openssl base64 -e -A', @")<cr><esc>
  endif

  " The pneumonic to remember the mapping is Kubernetes Secret Decode/Encode.
  " You need to linewise visually select the entire secret block (or as much
  " of it as you care to decode) first. I use the vim-indent-object to make
  " this a little faster (vii).
  vnoremap <leader>ksd :'<,'>normal $vT <leader>64d<cr>
  vnoremap <leader>kse :'<,'>normal $vT <leader>64e<cr>
endif

" }}}

" Search Related options {{{

" Highlight searched terms
set hlsearch

" bind \ to clear highlighting, though search term remains and 'n' works
noremap <silent> \ :silent nohlsearch<CR>

" Use incremental search
set incsearch

" Searches are case insensitive, unless upper case letters are used
set ignorecase
set smartcase

" }}}

" Ruby specific options {{{

" This will highlight trailing whitespace and tabs preceded by a space character
let ruby_space_errors = 1

" Syntax highlight ruby operators (+, -, etc)
let ruby_operators = 1

augroup rubyindentstyle
  autocmd!
  autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 expandtab

  autocmd FileType ruby hi link yardGenericTag rubyInstanceVariable
  autocmd FileType ruby hi link yardGenericDirective rubyInstanceVariable
augroup END

" }}}

" Typescript specific options {{{

augroup typescriptindentstyle
  autocmd!

  " don't use indent from the leafgarland/typescript-vim
  let g:typescript_indent_disable = 1

  autocmd FileType typescript set autoindent shiftwidth=2 softtabstop=2 expandtab
augroup END
" }}}

" GoLang options {{{
augroup golangstyle
  autocmd!
  autocmd FileType go set tabstop=2 shiftwidth=2 noexpandtab
  autocmd FileType go noremap <leader>gt :GoTest <CR>
  autocmd FileType go noremap <leader>gT :GoTestFunc <CR>
  autocmd FileType go noremap <leader>gi :GoInfo <CR>

	" rails.vim-inspired switch commands, stolen from vim-go docs
	autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
	autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
	autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

if has('nvim')
  function! GoStatusLine()
    return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
  endfunction

  function! AirlineInit()
          let g:airline_section_c = get(g:, 'airline_section_c', g:airline_section_c)
          let g:airline_section_c .= g:airline_left_sep . ' %{GoStatusLine()}'
  endfunction
  autocmd User AirlineAfterInit call AirlineInit()
endif

" Use vim-dispatch for appropriate commands. Currently only build, but maybe
" some day test as well: https://github.com/fatih/vim-go/pull/402
let g:go_dispatch_enabled = 1

" This is a hacky fix for :GoTest breaking when you use testify. It's parsing
" the errors and expecting things to look very specific, even though testify
" isn't doing anything that the standard testing library doesn't support. This
" stops it from opening a nonexistant file because it's incorrectly parsing
" the error message.
let g:go_jump_to_error=0

" Just autoimport for me, OK?
let g:go_fmt_command = "goimports"

" }}}

" Rust options {{{
augroup rustlangstyle
  autocmd!
  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs let b:dispatch = 'cargo run'

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  nmap <silent> cgd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " Symbol renaming.
  nmap <leader>gr <Plug>(coc-rename)

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>ga <Plug>(coc-codeaction-selected)
  nmap <leader>ga <Plug>(coc-codeaction-selected)
augroup END

" part of rust-lang/rust.vim
let g:rustfmt_autosave = 1
" }}}

" Coffee specific options {{{
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" }}}

" Javascript specific options {{{
autocmd BufNewFile,BufReadPost *.js setl shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.hbs setl shiftwidth=2 expandtab
" }}}

" CSS specific options {{{
autocmd BufNewFile,BufReadPost *.css setl shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.scss setl shiftwidth=2 expandtab
" }}}

" JSON specific options {{{

augroup jsonindentstyle
  autocmd!
  autocmd FileType json set autoindent shiftwidth=2 softtabstop=2 expandtab
augroup END

" }}}
