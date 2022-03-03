call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Go IDE
Plug 'ray-x/go.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'ray-x/guihua.lua' " float term, codeaction and codelens gui support

" Install coq
" main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" Install TreeSitter Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter'

" Install Moonfly color scheme
Plug 'bluz71/vim-moonfly-colors'

" Install Oceanic color scheme
Plug 'mhartington/oceanic-next'

" Install Sonokai color scheme
Plug 'sainnhe/sonokai'

" Install lightline
" Plug 'itchyny/lightline.vim'
" Install airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Install devicons
Plug 'ryanoasis/vim-devicons'

" Install gitsigns
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}

" Install barbar
" Plug 'romgrk/barbar.nvim'

" Initialize plugin system
call plug#end()

lua <<EOF
require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  max_line_len = 120,
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '   ',
  lsp_cfg = true, -- false: use your own lspconfig
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  dap_debug = true,
})

local protocol = require'vim.lsp.protocol'

EOF

let g:coq_settings = { 'auto_start': v:true }

lua <<EOF

require('coq')

EOF
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

set nu
set tabstop=4
set shiftwidth=4
set nomodeline
set autoindent
set nocompatible
set showmatch
set expandtab
map <C-n> :CHADopen<CR>

" Set quick navigation between tabs
nnoremap H gT
nnoremap L gt

" Set Gnome terminal like controls for tabs
:nnoremap <C-S-t> :tabnew<CR>
:inoremap <C-S-t> <Esc>:tabnew<CR>
:inoremap <C-S-w> <Esc>:tabclose<CR>


" Kitty Terminal mappings for split pane navigation
let g:kitty_navigator_no_mappings = 1

" nnoremap <silent> <c-h> :KittyNavigateLeft<cr>
" nnoremap <silent> <c-j> :KittyNavigateDown<cr>
" nnoremap <silent> <c-k> :KittyNavigateUp<cr>
" nnoremap <silent> <c-l> :KittyNavigateRight<cr>

" Split pane navigation for [hjkl]
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-s-k> :wincmd k<CR>
nmap <silent> <c-s-j> :wincmd j<CR>
nmap <silent> <c-s-h> :wincmd h<CR>
nmap <silent> <c-s-l> :wincmd l<CR>

" nmap <silent> <c-s-k> :resize -1<CR>
" nmap <silent> <c-s-j> :resize +1<CR>
" nmap <silent> <c-s-h> :vertical resize -1<CR>
" nmap <silent> <c-s-l> :vertical resize +1<CR>
" TreeSitter Setup

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

if (has("termguicolors"))
 set termguicolors
endif

syntax enable

" let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_style = 'maia'
let g:airline_theme = 'sonokai'
colorscheme sonokai

set encoding=UTF-8
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" loading the plugin
let g:webdevicons_enable = 1

" Terraform settings
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" Setup gitsigns
lua <<EOF
require('gitsigns').setup()
EOF
