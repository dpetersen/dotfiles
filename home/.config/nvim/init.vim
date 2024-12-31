" Disable vi compatibility
set nocompatible

" Used for some plugins to display fancy symbols.  Hopefully doesn't blow
" things up.
set encoding=utf-8

call plug#begin('~/.config/nvim/plugged')

Plug 'folke/neodev.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
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
Plug 'preservim/tagbar'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
" I think this is out of date, since it requires Unite?
Plug 'Shougo/neoyank.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'justinmk/vim-sneak'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/nvim-nio'
Plug 'mfussenegger/nvim-dap'
Plug 'andythigpen/nvim-coverage'
Plug 'github/copilot.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'ZeroKnight/vim-signjump'

" The Wide World of Modern LSP Support
" A package manager for language servers
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
" Bridges the gap between Mason and LSPConfig
Plug 'williamboman/mason-lspconfig.nvim'
" Official plugin with prebuilt configurations for languages
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
Plug 'rshkarin/mason-nvim-lint'
" Allows more configuration of formatters than the default LSP. I installed
" this to configure prettier instead of ts_ls for formatting Typescript.
Plug 'stevearc/conform.nvim'

" Languages
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown', { 'for': [ 'md', 'markdown' ] }
Plug 'hashivim/vim-terraform', { 'for': 'tf' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'towolf/vim-helm'
" Javascript-ish
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'jason0x43/vim-js-indent', { 'for': 'js' }
Plug 'tpope/vim-jdaddy', { 'for': 'json' }
" Ruby-ish
Plug 'vim-ruby/vim-ruby', { 'for': 'rb' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-bundler'
Plug 'olimorris/neotest-rspec'
Plug 'suketa/nvim-dap-ruby'

call plug#end()

lua <<EOF
-- Mason
require("mason").setup()
require("mason-lspconfig").setup {
        -- List of allowed values:
        -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
        ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ruby_lsp",
                "rubocop",
                "ts_ls"
        },
}

-- LSP Config
local lspconfig = require("lspconfig")
lspconfig.gopls.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.ruby_lsp.setup {}
lspconfig.rubocop.setup {}
lspconfig.ts_ls.setup {}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})


-- DAP
require('dap-ruby').setup()

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

-- Linting
require('lint').linters_by_ft = {
  -- go = {'golangci-lint'}
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Can get this list from:
-- https://mason-registry.dev/registry/list
require('mason-nvim-lint').setup({
	-- ensure_installed = {'golangci-lint'},
	automatic_installation = true,
})

-- nvim-coverage
require("coverage").setup()

-- conform
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
EOF

" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd CursorHold * lua vim.diagnostic.open_float({scope="line"})

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

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
noremap <leader>gs :Git <CR>
noremap <leader>gc :Git commit <CR>
noremap <leader>gd :Gdiffsplit <CR>
noremap <leader>gb :Git blame <CR>

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

" Fix for UTF-8 annoyances in vagrant ubuntu
let g:NERDTreeDirArrows=0

" Let me toggle NERDTree easiy
nnoremap <leader>nt :NERDTreeToggle<cr>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

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

" Avro Schemas
au BufNewFile,BufRead *.avsc set filetype=json

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

let g:sneak#label = 1
nnoremap <leader>s <Plug>Sneak_s
nnoremap <leader>S <Plug>Sneak_S

" My custom normal/insert mode mappings {{{

" Remap jk or to be the same as Esc to leave Insert mode.
inoremap jk <Esc>
inoremap jj <Esc>
inoremap <esc> <nop>

" Quick editing and reloading of .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" C-j in insert mode escapes normal mode and writes the file.
inoremap <C-j> <Esc>:w<Enter>

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
nnoremap <leader>T :TagbarToggle<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>ft :lua require'telescope.builtin'.treesitter{}<cr>
nnoremap <Leader>fs :lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap <Leader>fS :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols{}<cr>


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

  autocmd FileType typescript,typescriptreact set autoindent shiftwidth=2 softtabstop=2 expandtab
augroup END
" }}}

" GoLang options {{{
augroup golangstyle
 autocmd!
 autocmd FileType go set tabstop=2 shiftwidth=2 noexpandtab

lua <<EOF
-- Ripped from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
EOF

"  autocmd FileType go noremap <leader>gt :GoTest <CR>
"  autocmd FileType go noremap <leader>gT :GoTestFunc <CR>
"  autocmd FileType go noremap <leader>gi :GoInfo <CR>

"  " rails.vim-inspired switch commands, stolen from vim-go docs
"  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

"if has('nvim')
"  function! GoStatusLine()
"    return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
"  endfunction

"  function! AirlineInit()
"          let g:airline_section_c = get(g:, 'airline_section_c', g:airline_section_c)
"          let g:airline_section_c .= g:airline_left_sep . ' %{GoStatusLine()}'
"  endfunction
"  autocmd User AirlineAfterInit call AirlineInit()
"endif

"" Just autoimport for me, OK?
"let g:go_fmt_command = "goimports"

" }}}

" Rust options {{{
augroup rustlangstyle
  autocmd!
  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
augroup END

" part of rust-lang/rust.vim
let g:rustfmt_autosave = 1
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

" Neotest Configuration {{{
lua <<EOF
require("neotest").setup({
  adapters = {
    require("neotest-rspec")({
      rspec_cmd = function()
        return vim.tbl_flatten({
          "bundle",
          "exec",
          "rspec"
        })
      end
    })
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "❌",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "✅",
    running = "r",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = "s",
    unknown = "u",
    watching = "w"
  },
})
EOF

nnoremap <silent> <leader>tn  <cmd>lua require("neotest").run.run()<CR>
nnoremap <silent> <leader>tN  <cmd>lua require("neotest").run.run({strategy = "dap"})<CR>
nnoremap <silent> <leader>tf  <cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>
nnoremap <silent> <leader>tt  <cmd>lua require("neotest").run.run_last()<CR>
nnoremap <silent> <leader>tT  <cmd>lua require("neotest").run.run_last({strategy = "dap"})<CR>
nnoremap <silent> <leader>ts  <cmd>lua require("neotest").summary.toggle()<CR>
nnoremap <silent> <leader>tm  <cmd>lua require("neotest").summary.run_marked()<CR>
nnoremap <silent> <leader>to  <cmd>lua require("neotest").output_panel.toggle()<CR>
nnoremap <silent> <leader>tS  <cmd>lua require("neotest").run.stop()<CR>
" }}}
