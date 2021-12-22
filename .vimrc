" Don't try to be vi compatible
set nocompatible

" System specific configuration
let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
    " Install Vim Plug, if it is not already installed
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    let lines = readfile('/proc/version')
    " We are in Windows Subsystem for Linux (WSL)
    " WARNING: This has only been tested for WLS version 1
	if lines[0] =~ 'Microsoft'
        " Fixes bug in Windows terminal
        " https://github.com/microsoft/terminal/issues/832
        " redraw! also temporarily fixes this bug
        set t_ut=
        " copy highlighted text to system clipboard
        " Yanks the selected text, overwrites .vimbuffer with the text, and
        " pipes the data to clip.exe
        vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
    endif
endif


call plug#begin('~/.vim/plugged')
" makes f F t T easier by highlighting chars
Plug 'unblevable/quick-scope'

" rainbow parenthesis
" TODO: Prevent rainbow parenthesis from vanishing when vimrc is reloaded
Plug 'luochen1990/rainbow'

" Highlight on yank
Plug 'machakann/vim-highlightedyank'

" Highlight trailing whitespace
" Leads to cleaner commits and helps debug errors in Vim key-bindings
Plug 'ntpeters/vim-better-whitespace'

" Save current file with sudo: ":w suda://%"
Plug 'lambdalisue/suda.vim'

" Preview of vim search and replace command
" Plug 'osyo-manga/vim-over'

" gruvbox colorscheme
Plug 'gruvbox-community/gruvbox'

" Rename pattern with "Rename" command
" Alternative: eunuch.vim
Plug 'vim-scripts/Rename2'

" Auto reload files when re-entering a buffer/some other actions if the buffer was not modified
" since a change occurred in the background (outside of vim).
Plug 'djoshea/vim-autoread'

" Insert or delete brackets in pairs w/ automatic indentation when pressing
" enter
" For this issue: https://github.com/jiangmiao/auto-pairs/issues/215
" replace "=ko" with just "ko"
" TODO: Untested if this plugin breaks with JS
Plug 'jiangmiao/auto-pairs'

" Auto detect indentation
" Plug 'tpope/vim-sleuth'
Plug 'ciaranm/detectindent'

" Edit the quickfix list
" Not used super often, but when it you need it,
" it is super useful.
" Allows mass refactoring across files
Plug 'stefandtw/quickfix-reflector.vim'

" Removed because it was causing errors.
" Commands to cycle buffers/close buffer without closing window
" Plug 'qpkorr/vim-bufkill'

" Visualize vim's undotree
" TODO: Remove, I don't use this much?
" Plug 'mbbill/undotree'

" Install fzf executable
Plug 'junegunn/fzf' ", {'do':'./install --bin'}

" Install fzf plugin
Plug 'junegunn/fzf.vim'

" LSP support, intellisense, and more
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Typescript syntax highlighting
 Plug 'leafgarland/typescript-vim'

" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
" Javascript indentation + syntax support
Plug 'pangloss/vim-javascript'
" JSX highlighting
Plug 'maxmellon/vim-jsx-pretty'

" Markdown syntax highlighting
Plug 'gabrielelana/vim-markdown'

" use coc's go extension
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Better vim Git integration
Plug 'tpope/vim-fugitive'

" Change quote pairs easily
Plug 'tpope/vim-surround'

call plug#end()

" https://vi.stackexchange.com/questions/10124/what-is-the-difference-between-filetype-plugin-indent-on-and-filetype-indent
filetype plugin on

" activate rainbow parenthesis
let g:rainbow_active = 1

" improvements to quickscope https://github.com/unblevable/quick-scope#customize-colors
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" use true colors
" WARNING: This breaks vim inside of temx
" TODO: Make vim work inside of tmux
set termguicolors

"if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )
"    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"    set termguicolors
"endif

" colorscheme stuff
set background=dark
let g:gruvbox_italic = '1'

colorscheme gruvbox

" Syntax highlighting
syntax on

" Line numbers
set number relativenumber

" Enable mouse (disables copy-paste to system clipboard): https://stackoverflow.com/questions/4608161/copying-text-outside-of-vim-with-set-mouse-a-enabled
set mouse=a

" show tabs as 4 spaces
set tabstop=4

" set default indent to 2
set shiftwidth=2

" convert tabs to spaces
set expandtab

" don't wrap lines when displaying them
set nowrap

" prevent vim from auto-inserting line wraps for normal text and comments
set formatoptions-=tc

" highlight search matches incrementally
set incsearch

" highlight all search matches
set hlsearch

" ignore case when searching
set ignorecase
" don't ignore case if there is a capital letter in the search
" only works if ignorecase is turned on
set smartcase

" indentation settings
set autoindent
set smartindent
set shiftwidth=4

" make side scrolling smoother?
set sidescroll=1

" allow exiting unsaved buffers
set hidden

" Open split panes to the bottom and right
set splitbelow
set splitright

" Prevent space from moving cursor forward in normal mode
nnoremap <SPACE> <Nop>

" Set the leader key to space
let mapleader=" "

" Easier switching between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Prevent Bufkill plugin from creating its own leader mappings
let g:BufKillCreateMappings = 0

" Disabled because I removed the Buffkill plugin
" Wipe current buffer without closing split (wipe = remove from memory/buffer list)
" nnoremap <leader>w :BW<CR>

" display buffer list and prompt for buffer number
" nnoremap <leader>b :buffers<CR>:b<SPACE>

let g:vcsPatterns = ['.git', ".hg/"]

function! s:project_root()
    for pattern in ['.git', 'package.json']
        let dir = finddir(pattern.'/..', expand('%:p:h').';')
        if !empty(dir)
            return dir
        endif
    endfor
    return expand('%:p:h')
endfunction

" Fuzzy search keymaps
" buffer names
nnoremap <silent><leader>b :Buffers<CR>
" text inside current buffer
nnoremap <silent><leader>t :BLines<CR>
" files from project root dir
nnoremap <silent><leader>f :execute 'Files '.<SID>project_root()<CR>

" Easy escape from terminal
:tnoremap <Esc> <C-\><C-n>


" Don't tab complete binary files
set wildignore+=*.a,*.o

" Show statusline
set laststatus=2
set statusline=          " Wipe out any existing value
set statusline+=%F       " Path of pattern
set statusline+=\ %m     " File modified flag
set statusline+=\ %r     " Readonly flag
set statusline+=col:\ %c " Column number


" Disable swap files (swap files allow for recovery if there is a crash
" they also prevent multiple instances of Vim from editing the same pattern).
set noswapfile

" Customize fzf colors to match my color scheme
" Copied from https://github.com/junegunn/fzf.vim
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" TODO?: Make color scheme work for Rg command (Might not be necessary)
" Custom Rg command that searches from root dir (if it exists), otherwise uses current dir
command!      -bang -nargs=* Rg                        call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {"dir": s:project_root()})

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" https://github.com/junegunn/fzf.vim/issues/185
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" https://github.com/junegunn/fzf.vim/issues/185
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" TODO: Figure out a good terminal emulator that supports bold for cterm
" TODO: Write a better foldtext function
highlight Folded cterm=italic ctermfg=white ctermbg=None

" coc.nvim configuration
" Some servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" The default of 4000 results in a bad experience for diagnostic messages?
set updatetime=300

" don't give |ins-completion-menu| messages?
set shortmess+=c

" always show the sign column
set signcolumn=yes

" Useful coc-extensions
" TODO: Test if this works, can also use "call coc#add_extension(name)"
let g:coc_global_extensions = ['coc-json', 'coc-python', "coc-tsserver", 'coc-solargraph']

" insert quotes
"python.jediEnabled: false,
" Remap keys for gotos
nmap     <silent><leader>gd   <Plug>(coc-definition)
nnoremap <silent><leader>vgd  :<C-u>call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent><leader>xgd  :<C-u>call CocAction('jumpDefinition', 'split')<CR>
nmap     <silent><leader>gr   <Plug>(coc-references)

" Rename current symbol
nmap     <silent><leader>r    <Plug>(coc-rename)

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" TODO: make autocomplete menu disappear when there is only one entry that
" matches the current word
" In insert mode, if the autocomplete menu is visible, then tab cycles through it
" otherwise a tab is inserted
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>": "\<TAB>"

" If autocomplete menu is visible, cycle in the opposite direction
" Otherwise delete a character
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" TODO: Implement the code dimming/greying-out for unused (excluded by macros) code
" ccls can def. support this because it doesn't work on code that is excluded by macros

" Completion of Vim commandline
set wildmenu

" Make Markdown editing better
augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
  autocmd FileType markdown set linebreak
augroup END

" https://github.com/neoclide/coc.nvim/issues/869
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
