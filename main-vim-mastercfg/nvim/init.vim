" Vim-Plug
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mattn/emmet-vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'plasticboy/vim-markdown'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'rust-lang/rust.vim'
Plug 'zig-lang/zig.vim'
Plug 'tpope/vim-fireplace'
Plug 'ekalinin/dockerfile.vim'
Plug 'moll/vim-node'
Plug 'stephpy/vim-yaml'
Plug 'towolf/vim-helm'
call plug#end()

" Main config

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Syntax highlighting
syntax on

" Line numbers
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Set shift width to n spaces.
set shiftwidth=2

" Set tab width to n columns.
set tabstop=2

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Remap leader key
let mapleader = "\<M-,>"

" Colorscheme
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
let g:gruvbox_termcolors=16
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Set encoding
set encoding=UTF-8

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" Plugins Config

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" emmet config
let g:user_emmet_leader_key='<C-E>'

" nerdtree
map <leader>t :NERDTreeToggle<CR>

" airline
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_theme='random'

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-F>"
let g:UltiSnipsJumpBackwardTrigger="<C-B>"


" Mapping of commands
" This will delete the row where you are standing without copying it to the register
nmap <leader>bh "_dw <Esc>
