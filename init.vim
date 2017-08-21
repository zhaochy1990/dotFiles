" show line number
set number numberwidth=2
let mapleader = ","


" Automatically detect file types.
filetype plugin indent on
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
"set splitright                  " Puts new vsplit windows to the right of the current
"set splitbelow                  " Puts new split windows to the bottom of the current
set hlsearch                    " 高亮搜索结果

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber



" 代码折叠 {{{
set foldenable
" 使用{{{}}}来进行代码折叠
set foldmethod=marker
" foldlevel设为0，就是折叠所有的代码
set foldlevel=0
" }}}

" 插件 {{{
call plug#begin('~/.vim/plugged')

" UI: {{{
" nerdtree
Plug 'scrooloose/nerdtree'
" nerdtree的git插件
Plug 'Xuyuanp/nerdtree-git-plugin'
" tagbar
Plug 'majutsushi/tagbar'
" tagbar的javascript插件
Plug 'hushicai/tagbar-javascript.vim'
" solarized主题
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ctrlspace/vim-ctrlspace'
"Plug 'christoomey/vim-tmux-navigator'
" }}}

" Coding {{{
Plug 'valloric/youcompleteme'
Plug 'chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'Lokaltog/vim-easymotion'
Plug 'kshenoy/vim-signature'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"}}}

" Language {{{

" Javascript {{{
Plug 'pangloss/vim-javascript'
Plug 'isruslan/vim-es6'
" }}}

" Typescript {{{
Plug 'HerringtonDarkholme/yats.vim'
" Navigate to the location where a symbol is defined.
" Show location(s) where a symbol is referenced.
" Display a list of syntax and semantics errors o Vim quickfix window.
"Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
" }}}

"Go {{{
Plug 'fatih/vim-go', {'for': 'go'}
"}}}

" }}}

" Initialize plugin system
call plug#end()
" }}}

" UI Config {{{

" NERDTree Config {{{
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('ts', 'Red', 'none', '#d30102', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('go', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" }}}

" 设置主题为Solarized {{{
syntax enable
set background=dark
"set background=light
colorscheme solarized
" 默认是16色的
"let g:solarized_termcolors=16
"let g:solarized_termcolors=256
" }}}

" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, INFO, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif

"设置 Ctrl-Space {{{
set nocompatible
set hidden
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
"let g:CtrlSpaceSearchTiming = 500
" }}}

" }}}

" Key Map {{{

set pastetoggle=<F5>
noremap <F8> :Autoformat<CR>
nmap <F9> :TagbarToggle<CR>
" have code be formatted upon saving the file
" au BufWrite * :Autoformat

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

noremap H ^
noremap L $

map <leader>n :NERDTreeToggle<CR>

" Tab 相关 {{{

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
" }}}

" 快速修改和重载VIMRC文件 {{{
" open my vimrc file in a split for quickly edit it and get back to coding
nnoremap <leader>ev :vsplit $VIMRC<cr>
" source my vimrc file
nnoremap <leader>sv :source $VIMRC<cr>
" }}}

" 快速保存和退出 {{{
nnoremap <leader>q :q<cr>
" save
nnoremap <leader>w :w<cr>
" }}}

" quickly select one word
nnoremap <space> viw

" 分屏快速移动 {{{
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
"}}}

" }}}

" Language {{{

" JavaScript {{{
let g:javascript_plugin_jsdoc = 1
set conceallevel=1
" }}}

" Go {{{
Plug 'fatih/vim-go', {'for': 'go'}
" }}}

" Typescript {{{
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
" }}}

" }}}

" Coding {{{

" YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_key_list_select_completion=['<c-j>']
"let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion=['<c-k>']
"let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
"let g:ycm_collect_identifiers_from_comments_and_strings=1   "注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_tags_files = 1
" 开启语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 回车作为选中
let g:ycm_key_list_stop_completion = ['<CR>']

"let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开

" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_register_as_syntastic_checker = 0
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
" }}}

" ultisnips {{{
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" 定义存放代码片段的文件夹 .vim/UltiSnips下，使用自定义和默认的，将会的到全局，有冲突的会提示
" 进入对应filetype的snippets进行编辑
map <leader>us :UltiSnipsEdit<CR>

" ctrl+j/k 进行选择
func! g:JInYCM()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<c-j>"
    endif
endfunction

func! g:KInYCM()
    if pumvisible()
        return "\<C-p>"
    else
        return "\<c-k>"
    endif
endfunction
inoremap <c-j> <c-r>=g:JInYCM()<cr>
au BufEnter,BufRead * exec "inoremap <silent> " . g:UltiSnipsJumpBackwordTrigger . " <C-R>=g:KInYCM()<cr>"
let g:UltiSnipsJumpBackwordTrigger = "<c-k>"
" }}}


" }}}


