" neovim config for zhaochy


let mapleader = ","

" Automatically detect file types.
filetype plugin indent on
"syntax on
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set expandtab                   " Tabs are spaces, not tabs
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
"set splitright                 " Puts new vsplit windows to the right of the current
"set splitbelow                 " Puts new split windows to the bottom of the current
set hlsearch                    " 高亮搜索结果
" set cursorline                " 高亮当前行

"Indent {{{
" By default, use indents of 2 spaces
set shiftwidth=2                " Use indents of 2 spaces
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
"}}}

" 代码折叠 {{{
set foldenable
" 使用{{{}}}来进行代码折叠
set foldmethod=marker
"set foldmethod=indent
" foldlevel设为0，就是折叠所有的代码
"set foldlevel=999
set foldlevel=0
" }}}

highlight MatchParen ctermbg=blue ctermfg=white

set updatetime=250

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=14


" 插件 {{{
call plug#begin('~/.config/nvim/plugged')

" UI: {{{
" nerdtree
Plug 'scrooloose/nerdtree'
" nerdtree的git插件
Plug 'Xuyuanp/nerdtree-git-plugin'
" tagbar
Plug 'majutsushi/tagbar'
" solarized主题
Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kien/rainbow_parentheses.vim'
" use fzf instead of CtrlP for fuzzy finding
" fzf supports asynchronous finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" }}}

" Editor {{{
" Asynchronous Lint Engine
Plug 'w0rp/ale'
Plug 'valloric/youcompleteme'
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

" Global Search
Plug 'dyng/ctrlsf.vim'

" Dash Document
Plug 'rizzatti/dash.vim'

Plug 'craigemery/vim-autotag'

"}}}

"Run {{{

" Mocha {{{
Plug 'janko-m/vim-test'
" }}}

" Quick Run
Plug 'thinca/vim-quickrun'

"}}}

" Language {{{

" Javascript {{{
" 语法高亮
Plug 'pangloss/vim-javascript'
Plug 'isruslan/vim-es6'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" }}}

" Python {{{
"Plug 'zchee/deoplete-jedi'
" }}}

" Typescript {{{
Plug 'HerringtonDarkholme/yats.vim'
" Navigate to the location where a symbol is defined.
" Show location(s) where a symbol is referenced.
" Display a list of syntax and semantics errors o Vim quickfix window.
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
"Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
" }}}

"Go {{{
Plug 'fatih/vim-go', {'for': 'go'}
"}}}

" ProtoBuf {{{
Plug 'uarun/vim-protobuf'
" }}}

" }}}

" Initialize plugin system
call plug#end()
" }}}

" UI 相关配置 {{{

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

let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let NERDTreeShowBookmarks=1

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

" 设置主题 {{{
syntax enable
"set background=dark
"set background=light
"colorscheme solarized
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

" 括号显示增强 rainbow_parentheses {{{
" 不加入这行, 防止黑色括号出现, 很难识别
" \ ['black',       'SeaGreen3'],
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}

" Tagbar {{{

" Typescript support {{{
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }
" }}}

" }}}

" }}}

" Key Map {{{
" Turn off highlight until the next search
nnoremap <F3> :noh<CR>
set pastetoggle=<F5>
noremap <F8> :Autoformat<CR>
nmap <F9> :TagbarToggle<CR>
" have code be formatted upon saving the file
" au BufWrite * :Autoformat

" 从terminal模式下退出
tnoremap <Esc> <C-\><C-n>

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y
" select all
map <Leader>sa ggVG

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

" use ctrl-p for fuzzy finding
map <C-p> :call ContextualFZF()<CR>
" }}}

" Language {{{

" JavaScript {{{

autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab

let g:javascript_plugin_jsdoc = 1

" }}}

" Go {{{
" }}}

" Typescript {{{
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab

if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" }}}

" }}}

" Coding {{{

" ale {{{
" pip install flake8
" npm install -g eslint eslint-plugin-standard eslint-plugin-promise eslint-config-standard
" npm install -g eslint-plugin-import eslint-plugin-node eslint-plugin-html babel-eslint
let g:ale_linters = {
            \   'python': ['flake8'],
            \   'javascript': ['eslint'],
            \   'typescript': ['tslint'],
            \}
" E501 -> 120 chars
let g:ale_python_flake8_args="--ignore=E114,E116,E131 --max-line-length=120"
" --ignore=E225,E124,E712,E116

"let g:ale_sign_error = '>>'
let g:ale_sign_error = 'E'
"let g:ale_sign_warning = '>'
let g:ale_sign_warning = 'W'

" vim-airline integrates with ALE for displaying error information in the status bar.
" If you want to see the status for ALE in a nice format, it is recommended to use
" vim-airline with ALE. The airline extension can be enabled by adding the following
" to your vimrc:
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%code%] %s [%severity%]'

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0

" fix errors
nmap <silent> <Leader>f :ALEFix<CR>

nnoremap <silent> <Leader>ec :ALEToggle<CR>

" troggle quickfix list
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic_error location panel
        lopen
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>

let g:ale_set_highlights = 1
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign

let g:ale_fixers = {
            \   'javascript': [
            \       'eslint',
            \   ],
            \   'typescript': [
            \       'tslint',
            \    ]
            \}
"let g:ale_fix_on_save = 1

" }}}

" Use YCM {{{
" auto close the preview window
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
"在注释输入中也能补全
let g:ycm_complete_in_comments = 0
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 0
"提示UltiSnips
let g:ycm_use_ultisnips_completer = 1
" 开启语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 回车作为选中
let g:ycm_key_list_stop_completion = ['<CR>']

"语言关键字补全, 不过关键字都很短，所以，需要的自己打开
let g:ycm_seed_identifiers_with_syntax=1

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

" Quick Run {{{
let g:quickrun_config = {
            \   "_" : {
            \       "outputter" : "message",
            \   },
            \}

let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
map <F10> :QuickRun<CR>
" }}}

" CtrlSF {{{
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackprg = 'ag --vimgrep'
" }}}

" }}}

"RUN {{{

"TEST {{{
let test#strategy = "neovim"
nmap <silent> t<C-n> :TestNearest<CR> " t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>    " t Ctrl+f
nmap <silent> t<C-s> :TestSuite<CR>   " t Ctrl+s
nmap <silent> t<C-l> :TestLast<CR>    " t Ctrl+l
nmap <silent> t<C-g> :TestVisit<CR>   " t Ctrl+g
"}}}

"}}}

" Use the correct file source, based on context
function! ContextualFZF()
    " Determine if inside a git repo
    silent exec "!git rev-parse --show-toplevel"
    redraw!

    if v:shell_error
        " Search in current directory
        call fzf#run({
          \'sink': 'e',
          \'down': '40%',
        \})
    else
        " Search in entire git repo
        call fzf#run({
          \'sink': 'e',
          \'down': '40%',
          \'source': 'git ls-tree --full-tree --name-only -r HEAD',
        \})
    endif
endfunction

" Configure FZF to find ctags
" https://github.com/junegunn/fzf/wiki/Examples-(vim)#jump-to-tags
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction
function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R --exclude=.git --exclude=node_modules --html-kinds=-ij')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction
command! Tags call s:tags()
nnoremap tt :Tags<CR>
nmap tt :Tags<CR>
