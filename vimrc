set shell=/bin/bash
set clipboard=unnamed
set number
set rnu
set listchars=eol:$,tab:>\ ,trail:~,extends:>,precedes:<
"set list
imap jj <Esc>
set path=.,/usr/include,/Library/Developer/CommandLineTools/usr/include/c++/v1/,,

"Autocomplete
inoremap <expr> ` TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun

" Minimalist-AutoCompletePop-Plugin
set completeopt=menu,menuone,noinsert
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 3] =~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'

        call feedkeys("\<C-P>", 'n')
    end
endfun

" Vim plug
call plug#begin()
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug '42Paris/42header'
Plug 'honza/vim-snippets'
Plug 'NLKNguyen/papercolor-theme'
Plug 'NLKNguyen/c-syntax.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'blueyed/vim-diminactive'
Plug 'airblade/vim-gitgutter'
Plug 'frazrepo/vim-rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'Valloric/ListToggle'
call plug#end()

map <Leader> <Plug>(easymotion-prefix)

let g:rainbow_active = 1
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"gitgutter option
set updatetime=100

"NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeIgnore=['\.o$', '\~$']
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

let g:syntastic_always_populate_loc_list = 1
" Enable norminette-vim (and gcc)
let g:syntastic_c_checkers = ['gcc'] "add norminette back
let g:syntastic_aggregate_errors = 1

" Set the path to norminette (do no set if using norminette of 42 mac)
let g:syntastic_c_norminette_exec = 'norminette'

" Support headers (.h)
let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']

" Pass custom arguments to norminette (this one ignores 42header)
let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'

" Check errors when opening a file (disable to speed up startup time)
let g:syntastic_check_on_open = 1

"header settings
let g:user42 = 'graux'
let g:mail42 = 'graux@student.42lausanne.ch'

let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
set foldmethod=indent
set foldcolumn=2
nnoremap <Space> za
nnoremap <F8> zR
nnoremap <F9> zM

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

colorscheme PaperColor
