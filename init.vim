set nocompatible
let mapleader=" "

call plug#begin('~/.vim')
Plug 'sheerun/vim-polyglot' " language packs
Plug 'morhetz/gruvbox' " gruvbox theme
Plug 'neoclide/coc.nvim',{'branch':'release'} " code completion (requires nodejs)
Plug 'itchyny/lightline.vim' " status bar
Plug 'ap/vim-css-color' " add color to hex values #96bf33 #ff8008
Plug 'mbbill/undotree' " show a history of the file's modifications
Plug 'liuchengxu/vim-which-key' " menu popup after leader
Plug 'jiangmiao/auto-pairs' " automatic ([{}]) close
Plug 'skamsie/vim-lineletters' " use letters to jump on page

" Fuzzy search
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

syntax on
filetype plugin on " required for nerdcommenter
set filetype=on " file detection
set noerrorbells " no sounds
set hidden " keeps files in buffer
set timeoutlen=500 " time before <leader> original function is executed

" Colors
colorscheme gruvbox
set background=dark
set colorcolumn=100

" Display settings
set encoding=utf-8 " encoding used for displaying file
set nu rnu " relative numbers on side
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert / replace / visual mode
set cursorline " highlight current line
set wrap! " no line wrapping
set scrolloff=25 " starts scrolling file when 20 away from end
set splitbelow splitright " aligns new splits

" Write settings
set confirm " confirm :q in case of unsaved changes
set fileencoding=utf-8 " encoding used when saving file
set nobackup " do not keep the backup~ file
set noswapfile " no swap file saved
set smartindent " automatic indentation
set cino=(s,m1 " indent correctly after paragraph
set undofile
set undodir=~/.vim/undodir

" Edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode
set expandtab " fill tabs with spaces
set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=4 " set indentation depth to 4 columns
set softtabstop=4 " back spacing over 4 spaces like over tabs
set tabstop=4 " set tabulator length to 4 columns
set mouse=a " allow mouse to change cursor position

" Search settings
set nohlsearch " remove highlight while searching
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ... unless capital letters are used

" ======================================================================
" Remaps
" ======================================================================

" Quality of life
nnoremap Y y$
nnoremap gg gg0
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap gn gt
nnoremap gN gT
vnoremap <C-y> :w !xclip -i -sel c<CR><CR>
nnoremap <C-a> ggVG
nnoremap <leader><leader> <Plug>LineLetters
vnoremap <leader><leader> <Plug>LineLetters

" Center cursor while navigating
nnoremap { {zz
nnoremap } }zz
nnoremap n nzz
nnoremap N Nzz

" Tab to indent
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" Dont save these changes to register
nnoremap c "_c
nnoremap C "_C

" Toggle
nnoremap <Leader>tp :set paste!<CR>
nnoremap <Leader>ts :set spell!<CR>
nnoremap <Leader>tw :set wrap!<CR>:set linebreak!<CR>

" Insert
nnoremap <leader>id a<C-R>=strftime("%a %b %d %Y")<CR><ESC>
nnoremap <leader>it a<C-R>=strftime("%A %H:%M")<CR><ESC>
nnoremap <leader>ill aLorem ipsum dolor sit amet, consectetur adipiscing elit. <ESC>
nnoremap <leader>ilp aLorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non mi volutpat, tincidunt erat eget, scelerisque massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis massa tincidunt, efficitur metus sit amet, dignissim est. Maecenas sollicitudin, magna ac hendrerit rhoncus, mi turpis gravida lacus, eu iaculis enim lectus vel mauris. Aliquam et metus tincidunt, mollis erat id, venenatis risus. Sed elit ipsum, lobortis quis porttitor in, euismod in turpis. Vivamus sodales sagittis mi imperdiet dignissim. Etiam varius feugiat accumsan. Aliquam nulla ex, vulputate eget ullamcorper et, tincidunt quis justo. Maecenas pellentesque tincidunt porttitor. Aenean eget felis posuere ex sodales rhoncus. Curabitur finibus in massa eget laoreet. Nullam in tincidunt augue.<ESC>

" Quick line jumps
nnoremap H 0^
nnoremap L $
vnoremap H 0^
vnoremap L $
nnoremap J }
nnoremap K {
vnoremap J }
vnoremap K {

" Turn off ex mode
nnoremap Q <nop>

" Increment and decrement numbers
nnoremap <leader>+ <C-a>
nnoremap <leader>- <C-x>

" Save and close files
nnoremap <leader>fs :w<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>qa :qa<CR>

" Switch between two buffers
nnoremap <leader>a <c-^>

" Open terminal
nnoremap <leader>c :split term://zsh<CR>i

" Indent whole file while preserving cursor location with <Leader>=
nnoremap <Leader>= m'gg=G`'zz

" Spell checking
nnoremap <leader>sn ]S
nnoremap <leader>sN [S
nnoremap <leader>ss z=
nnoremap <leader>sle :set spelllang=en<CR>
nnoremap <leader>sls :set spelllang=es<CR>

" Notes and todo
nnoremap <leader>gn :e ~/documents/note<CR>
nnoremap <leader>gt :e ~/documents/todo<CR>

" Keep cursor centered while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Move text
vnoremap <C-j> :m'>+1<CR>gv=gv
vnoremap <C-k> :m'<-2<CR>gv=gv
nnoremap <C-j> :m.+1<CR>==
nnoremap <C-k> :m.-2<CR>==

" Manage splits
nnoremap <leader>w :vsp<CR>
nnoremap <leader>W :sp<CR>

" Move between splits
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Fuzzy search
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fo :tabnew<CR><cmd>Telescope find_files<CR>

" GoTo code navigation
nnoremap <leader>gd <Plug>(coc-definition)
nnoremap <leader>gr <Plug>(coc-references)

" ======================================================================
" Plugin configurations
" ======================================================================

" Light line color scheme
let g:lightline={'colorscheme':'gruvbox',}

" Undo tree settings
nnoremap <leader>u :UndotreeToggle<cr><C-w>l
let g:undotree_WindowLayout = 4
let g:undotree_SplitWidth = 45

" LineLetters config
let g:lineletters_settings = {
      \ 'main_chars': ['a','s','d','f','j','k','l','m'],
      \ 'prefix_chars': ['a','s','d','f','j','k','l','m'],
      \ 'highlight_group': 'MoreMsg',
      \ 'after_jump_do': '^zz'
      \ }

" whichkey map list
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}

let g:which_key_map.a = 'Swap file'
let g:which_key_map.c = 'Open terminal'
let g:which_key_map.u = 'Undro Tree'

let g:which_key_map.f = { 'name' : '+File-Fuzzy' }
let g:which_key_map.f.b = 'Find Buffer'
let g:which_key_map.f.f = 'Find File'
let g:which_key_map.f.g = 'Fuzzy Grep'
let g:which_key_map.f.h = 'Fuzzy Help'
let g:which_key_map.f.o = 'File Open'
let g:which_key_map.f.s = 'File Save'
let g:which_key_map.f.t = 'File Tree'

let g:which_key_map.g = { 'name' : '+Goto' }
let g:which_key_map.g.n = 'Notes'
let g:which_key_map.g.t = 'TODO'

let g:which_key_map.i = { 'name' : '+Insert' }
let g:which_key_map.i.d = 'Date'
let g:which_key_map.i.t = 'Time'

let g:which_key_map.i.l = { 'name' : '+Lorem' }
let g:which_key_map.i.l.l = 'Line'
let g:which_key_map.i.l.p = 'Paragraph'

let g:which_key_map.q = { 'name' : '+Quit' }
let g:which_key_map.q.q = 'Quit Buffer'
let g:which_key_map.q.a = 'Quit All'

let g:which_key_map.r = { 'name' : "+Refactor" }
let g:which_key_map.r.e = 'Refactor Variable'

let g:which_key_map.s = { 'name' : '+Spell' }
let g:which_key_map.s.s = 'Spell Check'
let g:which_key_map.s.n = 'Next Word'
let g:which_key_map.s.N = 'Prev Word'

let g:which_key_map.s.l = { 'name' : '+Language' }
let g:which_key_map.s.l.e = 'English'
let g:which_key_map.s.l.s = 'Spanish'

let g:which_key_map.t = { 'name' : "+Toggle" }
let g:which_key_map.t.p = 'Paste'
let g:which_key_map.t.s = 'Spell'
let g:which_key_map.t.w = 'Wrap'

let g:which_key_map.w = "Split Right"
let g:which_key_map.W = "Split Down"

let g:which_key_map.h = 'Window ←'
let g:which_key_map.j = 'Window ↓'
let g:which_key_map.k = 'Window ↑'
let g:which_key_map.l = 'Window →'

" ======================================================================
" Auto commands
" ======================================================================

" Remove trailing white space when saving
autocmd BufWritePre * %s/\s\+$//e

" Format dart code on save
autocmd Filetype dart nnoremap <leader>fs :DartFmt<CR>:w<CR>

" Equalize splits when vim is resized
autocmd VimResized * wincmd =

" Disable auto comments on a new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ======================================================================
" Functions
" ======================================================================

" coc tab to auto complete
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

" coc tab to select next autocomplete
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" coc use CTRL+Space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Return to last edit position when opening files
autocmd BufreadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   execute "normal! g'\"" |
            \ endif
