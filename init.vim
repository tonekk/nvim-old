call plug#begin('~/etc/nvim/plugged')

  " Language plugins
  Plug 'tpope/vim-rails'
  Plug 'pangloss/vim-javascript'
  Plug 'vim-test/vim-test'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'rorymckinley/vim-symbols-strings'
  Plug 'amadeus/vim-mjml'

  " Cut, Delete, Replace, Yank
  Plug 'tommcdo/vim-exchange'
  Plug 'svermeulen/vim-yoink'
  Plug 'svermeulen/vim-subversive'

  " Git
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'

  " Moving between files
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'preservim/nerdtree'

  " Lua stuff
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " Completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " Lightline
  Plug 'itchyny/vim-gitbranch'
  Plug 'itchyny/lightline.vim'

  " LSP & Treesitter
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " neoterm & maximizer
  Plug 'kassio/neoterm'
  Plug 'szw/vim-maximizer'

  " mason - manage linters / lsp plugins
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'

  " ALE and neoformat (for linting and prettying)
  Plug 'dense-analysis/ale'
  Plug 'sbdchd/neoformat'

  " colorscheme
  Plug 'folke/tokyonight.nvim'
  Plug 'NLKNguyen/papercolor-theme'
call plug#end()

" default options
let mapleader = " " " space as leader key
nnoremap <leader>v :e $MYVIMRC<CR>
set completeopt=menu,menuone,noselect " better autocomplete options
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab set tabstop=2 " tab equals 2 spaces
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

" Colors
set t_Co=256
colorscheme tokyonight
if (has("termguicolors"))
  set termguicolors " better colors, but makes it very slow!
endif

" Cut, Delete, Replace, Yank
"
" m for delete w/o overwriting register
" m = munch
nnoremap m "_d
xnoremap m "_d

nnoremap mm "_dd
nnoremap M "_D

" Nobody has ever needed x to overwrite the register...
nnoremap x "_dl
xnoremap x "_dl

" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" yank history
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
let g:yoinkIncludeDeleteOperations=1
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

" NERDtree
nnoremap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinSize=60

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
" Able to move in terminal with ctrl + o
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

" fugitive
nnoremap <leader>g :G<CR>

" itchyny/lightline.vim and itchyny/vim-gitbranch
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
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
lua <<EOF
changed_on_branch = function()
  local previewers = require('telescope.previewers')                          
  local pickers = require('telescope.pickers')                                
  local sorters = require('telescope.sorters')                                
  local finders = require('telescope.finders')                                

  pickers.new {                                                               
    results_title = 'Modified on current branch',                           
    finder = finders.new_oneshot_job({'git-branch-modified', 'list'}),
    sorter = sorters.get_fuzzy_file(),                                      
    previewer = previewers.new_termopen_previewer {                         
      get_command = function(entry)                                       
      return {'git-branch-modified', 'diff', entry.value}
      end                                                                 
      },                                                                      
    }:find()                                                                    
end
EOF
nnoremap <leader><space> :Telescope git_files<CR>
nnoremap <leader>g :Telescope git_status<CR>
nnoremap <leader>b <cmd>lua changed_on_branch()<CR>
nnoremap <leader>ab :Telescope buffers<CR>
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


" nvim-cmp
lua <<EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.config.disable,
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
require'lspconfig'.tsserver.setup { capabilities = capabilities }
require'lspconfig'.solargraph.setup { capabilities = capabilities }
EOF


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

" ale
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'css': ['prettier', 'eslint'],
\   'scss': ['prettier', 'eslint'],
\   'ruby': ['rubocop']
\}
nnoremap <leader>f :ALEFix<CR>

" neoformat
let g:neoformat_try_node_exe = 1
autocmd BufWritePre *.ts Neoformat
autocmd BufWritePre *.tsx Neoformat
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.jsx Neoformat

" Shortcut to deselect search string
nnoremap nH :nohlsearch<CR>

" mason
" TODO: Set ensure_installed for mason-lspconfig
" see: https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
lua <<EOF
require("mason").setup()
require("mason-lspconfig").setup()
EOF
