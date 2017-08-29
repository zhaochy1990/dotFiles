" neovim config for zhaochy


let mapleader = ","


" Automatically detect file types.
filetype plugin indent on
"syntax on
set nowrap                      " Do not wrap long lines set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
"set splitright                  " Puts new vsplit windows to the right of the current
"set splitbelow                  " Puts new split windows to the bottom of the current
set hlsearch                    " 高亮搜索结果

set updatetime=250

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd " 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 代码折叠 {{{
set foldenable
" 使用{{{}}}来进行代码折叠
set foldmethod=marker
" foldlevel设为0，就是折叠所有的代码
set foldlevel=0
" }}}

" 插件 {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'hyiltiz/vim-plugins-profile'

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
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
" }}}

" Coding {{{
"Plug 'valloric/youcompleteme'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/neoinclude.vim'

"This extension allows you to use [jsbeautifier] (http://jsbeautifier.org/) 
"inside vim to quickly format javascript, html and css files.
"Version 1.0 also supports the [editorconfig] (http://editorconfig.org/) file.
"Plug 'maksimr/vim-jsbeautify'

Plug 'chiel92/vim-autoformat'
" 快速注释
Plug 'scrooloose/nerdcommenter'
" 快速移动
Plug 'Lokaltog/vim-easymotion'
" 标记和跳转
Plug 'kshenoy/vim-signature'
" snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" easy align
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-expand-region'
Plug 'jiangmiao/auto-pairs'
"}}}

" Language {{{

" Javascript {{{
" 语法高亮
Plug 'pangloss/vim-javascript'
"Plug 'isruslan/vim-es6'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" }}}

" Typescript {{{
Plug 'HerringtonDarkholme/yats.vim'
" Navigate to the location where a symbol is defined.
" Show location(s) where a symbol is referenced.
" Display a list of syntax and semantics errors o Vim quickfix window.
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
Plug 'mhartington/nvim-typescript'
" }}}

"Go {{{
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'zchee/deoplete-go'
"}}}

" }}}

" Initialize plugin system
call plug#end()
" }}}

" UI Config {{{

" 行号 {{{
" show line number
set number numberwidth=2
" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
"}}}

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

" 设置可以高亮的关键字 {{{
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, INFO, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif
" }}}

"设置 Ctrl-Space {{{
set nocompatible
set hidden
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
" 下面这行在C-space最后面加了个空格，要不然ctrl-space不work
" see https://github.com/vim-ctrlspace/vim-ctrlspace/issues/188
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
"let g:CtrlSpaceSearchTiming = 500
" }}}

" }}}

" Key Map {{{

set pastetoggle=<F5>
noremap <F8> :Autoformat<CR>
nmap <F9> :TagbarToggle<CR>
" have code be formatted upon saving the file
" au BufWrite * :Autoformat

" 从terminal模式下退出
tnoremap <Esc> <C-\><C-n>

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
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"map <C-L> <C-W>l<C-W>_
"map <C-H> <C-W>h<C-W>_
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
"}}}

" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" }}}

" Language {{{

" JavaScript {{{

autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab

let g:javascript_plugin_jsdoc = 1
"set conceallevel=1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
            \ 'tern#Complete',
            \ 'jspc#omni'
            \]
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
" Whether to include the types of the completions in the result data.
" Default: 0
let g:deoplete#sources#ternjs#types = 1

" When completing a property and no completions are found, Tern will use some
" heuristics to try and return some properties anyway. Set this to 0 to
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

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

" Use deoplete. {{{
let g:deoplete#enable_at_startup = 1
" 使用相对路径，"./"会从当前文件的目录开始，而不是vim的working-directory
let g:deoplete#file#enable_buffer_path=1
" 补全结束之后关闭预览窗口
autocmd CompleteDone * silent! pclose!
" }}}

" ultisnips {{{
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" 定义存放代码片段的文件夹，使用自定义和默认的，有冲突的会提示
let g:UltiSnipsSnippetDirectories  = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'

" 进入对应filetype的snippets进行编辑
map <leader>us :UltiSnipsEdit<CR>
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

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

" expandregion {{{
    " map + <Plug>(expand_region_expand)
    " map _ <Plug>(expand_region_shrink)
    vmap v <Plug>(expand_region_expand)
    vmap V <Plug>(expand_region_shrink)
    " Extend the global default
    if exists("*expand_region#custom_text_objects")
        call expand_region#custom_text_objects({
        \ 'a]' :1,
        \ 'ab' :1,
        \ 'aB' :1,
        \ 'ii' :0,
        \ 'ai' :0,
        \ })
    endif

" }}}

" }}}

