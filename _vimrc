"======================================================================
" vimrc for zhaochy
"
" Created by zhaochy on 2015/09/12
"
" Email: zhaochy_2015@hotmail.com
"======================================================================

let mapleader = ","

"=======================
" Common Settings
"=======================

  " 不使用兼容模式
  " When you :set compatible, all the enhancements and improvements of Vi
  " Improved are turned off.
  set nocompatible
  " 解决有些时候，删除键不能向左删除的问题
  set backspace=2  

  set hidden
  set encoding=utf-8
  syntax enable
  filetype plugin indent on

  " Colors
  set background=dark
  "colorscheme seoul256
  " let g:solarized_termcolors=256

  set nowrap            " Do not wrap long lines
  set number            " Show line numbers
  set relativenumber
  autocmd FocusLost * :set norelativenumber number
  autocmd FocusGained * :set relativenumber
  " 插入模式下用绝对行号, 普通模式下用相对
  autocmd InsertEnter * :set norelativenumber number
  autocmd InsertLeave * :set relativenumber

  set hlsearch          " highlight search results
  "highlight MatchParen ctermbg=blue ctermfg=white

  set autoindent
  set smartindent
  set expandtab         " Expand tabs to spaces
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2


  set ruler             " 显示当前的行号列号
  set scrolloff=10      " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
  
  set showcmd           " 在状态栏显示正在输入的命令
  set showmode          " 左下角显示当前vim模式

  set foldenable
  set foldmethod=indent
  set foldlevel=99

  set updatetime=250    " see :help 'updatetime' for details

  set showtabline=2     " always

  hi MatchParen ctermbg=Blue
  "set cursorline cursorcolumn
  hi Cursor ctermbg=Red


"=======================
" Plugins
"=======================
  
call plug#begin('~/.vim/plugged')

  " NERDTree
  Plug 'preservim/nerdtree'

  " 大佬写的vim-terminal增强插件
  " https://github.com/skywind3000/vim-terminal-help
  Plug 'skywind3000/vim-terminal-help'

  " CtrlSpace
  Plug 'vim-ctrlspace/vim-ctrlspace'

  " Colors
  Plug 'junegunn/seoul256.vim'
  Plug 'altercation/vim-colors-solarized' " solarized colors

  " Editor
  Plug 'easymotion/vim-easymotion'   " move
  Plug 'dense-analysis/ale'          " async lint
  Plug 'Chiel92/vim-autoformat'      " code format
  Plug 'preservim/nerdcommenter'
  Plug 'Raimondi/delimitMate'        "  automatic closing of quotes, parenthesis, brackets, etc.
  Plug 'terryma/vim-expand-region'

  " Tag
  Plug 'preservim/tagbar'
  " sudo apt-get install exuberant-ctags
  " Plug 'xolox/vim-easytags' 

  " IndentLine
  Plug 'Yggdroot/indentLine'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " ultisnips 和 youcompleteme 有快捷键冲突
  " supertab 帮忙解决这个问题
  Plug 'ervandew/supertab'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " Complete Engine
  Plug 'ycm-core/YouCompleteMe'
  " 树根傻逼DLP系统导致 ycm core构建不成功
  
  " Typescript
  Plug 'leafgarland/typescript-vim'  " syntax highlight
  Plug 'Quramy/tsuquyomi'

  " Golang
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " Jsonnet
  Plug 'google/vim-jsonnet'

  " fzf
  " https://github.com/junegunn/fzf.vim
  " set rtp+=/usr/local/opt/fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " 依赖ag
  Plug 'dyng/ctrlsf.vim'

  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
call plug#end()

""" => Plugin.config

  " IndentLine
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  let g:indentLine_concealcursor = 'inc'
  let g:indentLine_enabled = 1

  " NERDTree
  " close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " NERD Commenter
  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims = 1

  " CtrlSpace
  " 使用ag替代ctrlspace自带的搜索引擎
  " sudo apt-get install silversearcher-ag
  " see https://github.com/vim-ctrlspace/vim-ctrlspace/issues/190
  if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif
  " 下面这行在C-space最后面加了个空格，要不然ctrl-space不work
  " see https://github.com/vim-ctrlspace/vim-ctrlspace/issues/188
  let g:CtrlSpaceDefaultMappingKey = "<C-p> "
  " Ctrl-Space can automatically save your workspace status
  let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
  let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
  let g:CtrlSpaceSaveWorkspaceOnExit = 1

  " ALE
  let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint'],
    \ 'python': ['yapf', 'isort']
    \}
  let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'typescript': ['eslint'],
    \   'python': ['pylint', 'flake8']
    \}
  let g:ale_sign_error = 'E'
  let g:ale_sign_warning = 'W'
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_enter = 0
  highlight ALEWarning ctermbg=DarkMagenta
  highlight ALEError ctermbg=grey
  highlight ALEInfo ctermbg=grey
  let g:ale_set_highlights = 0
  nmap <silent> <F7> <Plug>(ale_next_wrap)
  nmap <silent> <leader>aj :ALENext<cr>
  nmap <silent> <leader>ak :ALEPrevious<cr>

  " YouCompleteMe
  " https://github.com/ycm-core/YouCompleteMe
  let g:ycm_autoclose_preview_window_after_completion = 0
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_key_list_select_completion = ['<Down>', '<C-j>']
  let g:ycm_key_list_previous_completion = ['<Up>', '<C-k>']
  let g:ycm_error_symbol = 'E'
  let g:ycm_warning_symbol = 'W'
  highlight YcmWarningSection ctermbg=DarkMagenta
  highlight YcmErrorSection ctermbg=DarkMagenta
  "let g:ycm_enable_diagnostic_signs = 0
  "let g:ycm_enable_diagnostic_highlighting = 0
  
  let g:SuperTabDefaultCompletionType = '<C-j>'

  " Ultisnips
  " 定义存放代码片段的文件夹，使用自定义和默认的，有冲突的会提示
  let g:UltiSnipsSnippetDirectories  = ['~/.config/vim/UltiSnips', 'UltiSnips']
  let g:UltiSnipsSnippetsDir = '~/.config/vim/UltiSnips'
  " 进入对应filetype的snippets进行编辑
  map <leader>us :UltiSnipsEdit<CR>
  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
  
  " Tagbar
  let g:tagbar_type_typescript = {
    \ 'ctagstype': 'typescript',
    \ 'kinds': [
      \ 'c:class',
      \ 'n:namespace',
      \ 'f:function',
      \ 'G:generator',
      \ 'v:variable',
      \ 'm:method',
      \ 'p:property',
      \ 'i:interface',
      \ 'g:enum',
      \ 't:type',
      \ 'a:alias',
    \ ],
    \'sro': '.',
      \ 'kind2scope' : {
      \ 'c' : 'class',
      \ 'n' : 'namespace',
      \ 'i' : 'interface',
      \ 'f' : 'function',
      \ 'G' : 'generator',
      \ 'm' : 'method',
      \ 'p' : 'property',
      \},
  \}

  " Autoformat
  let g:formatters_typescript = ['eslint_local', 'tsfmt']
  let g:run_all_formatters_typescript = 1


  " CtrlSF
  nmap \ <Plug>CtrlSFCwordPath<CR>
  nnoremap <C-f> :CtrlSF<Space>
  " use async in using Vim 8.0+
  if v:version >= 800
      let g:ctrlsf_search_mode = 'async'
  endif
  let g:ctrlsf_auto_close = 0
  let g:ctrlsf_confirm_save = 0
  let g:ctrlsf_default_root = 'project'
  let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
   " Default Key Map
   " {
   "     "open"    : ["<CR>", "o"],
   "     "openb"   : "O",
   "     "split"   : "<C-O>",
   "     "vsplit"  : "",
   "     "tab"     : "t",
   "     "tabb"    : "T",
   "     "popen"   : "p",
   "     "popenf"  : "P",
   "     "quit"    : "q",
   "     "next"    : "<C-J>",
   "     "prev"    : "<C-K>",
   "     "pquit"   : "q",
   "     "loclist" : "",
   "     "chgmode" : "M",
   "     "stop"    : "<C-C>",
   " }

  let g:ctrlsf_mapping = {
        \ "split"  : "s",
        \ "prevw" : "<C-P>",
        \ "quit"  : "q",
        \ "next"  : "n",
        \ "prev"  : "N",
        \ "popen"   : "",
        \ "open"  : "<C-O>",
        \ }
  " ignore those dirs
  let g:ctrlsf_ignore_dir = ['node_modules', 'perf']

  " Expand Region
  " https://github.com/terryma/vim-expand-region
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
"=======================
" KeyMap
"=======================

""" => KeyMap.Common

  nnoremap <leader>sv :source $VIMRC<cr>
  nnoremap <leader>ev :vsplit $VIMRC<cr>

  noremap H ^
  noremap L $

  nnoremap <leader>q :q<cr>
  nnoremap <leader>w :w<cr>

  nnoremap zc zC
  let g:FoldMethod = 0
  map <leader>zz :call ToggleFold()<cr>
  
  map <C-J> <C-W>j
	map <C-K> <C-W>k
	map <C-L> <C-W>l
	map <C-H> <C-W>h

  " 禁用F1,F2, 避免和其他乱七八糟的东西冲突
  " Turn off highlight until the next search
  nnoremap <F3> :noh<CR>
  nmap <F4> :TagbarToggle<CR>
  set pastetoggle=<F5>
  nmap <F6> :call Zoom()<CR>
  nnoremap <F8> :Autoformat<CR>

  " 复制选中区到系统剪切板中
  vnoremap <leader>y "+y         
  map <Leader>sa ggVG

  " w!! to sudo & write a file
  cmap w!! w !sudo tee >/dev/null %

""" => KeyMap.NerdTree

  nnoremap <leader>n :NERDTreeToggle<CR>

""" => KeyMap.Terminal
  tnoremap <Esc> <c-\><c-n>         " exit terminal mode
  " terminal key => 'm-='           " Alt + =  

""" => KeyMap.Tab

  nnoremap <C-t>     :tabnew<CR>
  inoremap <C-t>     <Esc>:tabnew<CR>

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

""" => KeyMap.YouCompleteMe
  nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
  "nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
  nnoremap <leader>d :YcmCompleter GetDoc<CR>

"=======================
" Functions
"=======================

function! ToggleFold()
  if g:FoldMethod == 0
    exe "normal! zM"
    let g:FoldMethod = 1
  else
    exe "normal! zR"
    let g:FoldMethod = 0
  endif
endfun

" 临时最大化当前窗口（vim 术语中的 window，tmux 中的 pane）
" 之后再还原到最大化前的分屏
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction

