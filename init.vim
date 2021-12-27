call plug#begin('~/etc/nvim/plugged')

  " Language plugins
  Plug 'tpope/vim-rails'
  Plug 'pangloss/vim-javascript'
  Plug 'vim-test/vim-test'
  Plug 'tpope/vim-commentary'

  " Git
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'nvim-telescope/telescope.nvim'

  " Lua stuff
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

  Plug 'folke/tokyonight.nvim'
  Plug 'preservim/nerdtree'

  " Completion
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  autocmd VimEnter * COQnow --shut-up


  " Lightline
  Plug 'itchyny/vim-gitbranch'
  Plug 'itchyny/lightline.vim'

  " LSP & Treesitter
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " neoterm & maximizer
  Plug 'kassio/neoterm'
  Plug 'szw/vim-maximizer'
call plug#end()

" default options
let mapleader = " " " space as leader key
nnoremap <leader>v :e $MYVIMRC<CR>
set completeopt=menu,menuone,noselect " better autocomplete options
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab
set tabstop=2 " tab equals 2 spaces
set shiftwidth=2 " indentation
set number " show absolute line numbers
set ignorecase " search case insensitive
set smartcase " search via smartcase
set incsearch " search incremental
set diffopt+=vertical " starts diff mode in vertical split
set hidden " allow hidden buffers
set nobackup " don't create backup files
set noswapfile
set nowritebackup " don't create backup files
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
set signcolumn=yes " add a column for sings (e.g. GitGutter, LSP, ...)
set updatetime=300 " time until update
set undofile " persists undo tree
filetype plugin indent on " enable detection, plugins and indents

" Color
colorscheme tokyonight

if (has("termguicolors"))
  set termguicolors " better colors, but makes it very slow!
endif

let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown

let g:coq_settings = { "keymap.pre_select" : v:true }

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" lewis6991/gitsigns.nvim
lua << EOF
  require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    keymaps = {
      noremap = true,
      buffer = true,

      ['n <leader>sh'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['n <leader>uh'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>'
    }
  }
EOF

" itchyny/lightline.vim and itchyny/vim-gitbranch
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" kassio/neoterm
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_term_per_tab = 1
nnoremap <c-y> :Ttoggle<CR>
inoremap <c-y> <Esc>:Ttoggle<CR>
tnoremap <c-y> <c-\><c-n>:Ttoggle<CR>

" szw/vim-maximizer
" Maximize the terminal or any other vim window with ctrl + m
nnoremap <silent> <C-w>m :MaximizerToggle!<CR>
tnoremap <C-w>m <c-\><c-n>:MaximizerToggle!<CR>i

" nvim-telescope/telescope.nvim
nnoremap <leader><space> :Telescope git_files<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>ff :Telescope find_files<CR>

" neovim/nvim-lspconfig
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.solargraph.setup{}

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH    <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true }
}
EOF

set foldmethod=expr
setlocal foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()
