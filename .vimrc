"set "{{{
syntax on
set t_ut=
set backspace=indent,eol,start
set ttyfast
set encoding=utf-8
set smartindent
set title
set showmatch
set wrapscan
set noerrorbells
set noswapfile
set hidden
set autoread
set hlsearch
set incsearch
set wildmenu
set ignorecase
set scrolloff=3
set virtualedit=onemore
set t_Co=256
set expandtab
set tabstop=4
set shiftwidth=4
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
set mouse=a
set autoindent
let fortran_free_source=1
set tw=0

autocmd BufWritePre * :%s/\s\+$//ge
au FileType vim setlocal foldmethod=marker
au FileType fortran setlocal foldmethod=marker
"}}}

"color scheme"{{{
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight Visual ctermbg=102
autocmd ColorScheme * highlight LineNr ctermbg=none
autocmd ColorScheme * highlight Folded ctermbg=none

"colorscheme hybrid
colorscheme molokai
hi Comment ctermfg = 102
hi Visual  ctermbg = 244
"colorscheme atom-dark-256
set background=dark
"}}}

"Keybind"{{{
"inoremap , ,<Space>
noremap  <S-h> ^
noremap  <S-j> }
noremap  <S-k> {
noremap  <S-l> $
nnoremap <S-s> `
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sm <C-w>-
nnoremap s, <C-w>+
nnoremap s. <C-w>>
nnoremap sn <C-w><
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sp :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb <C-b>
nnoremap sf <C-f>
nnoremap su <C-u>
nnoremap sd <C-d>
nnoremap い i
"nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
"nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap gj j
nnoremap gk k
nnoremap <Space>w :<C-u>update<CR>
"nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nnoremap x "_x
nnoremap s "_s
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nmap <silent> <Space><Space> :nohlsearch<CR><Esc>
inoremap jk <esc>
inoremap ｊｋ <esc>
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>^
inoremap <C-j> <C-o>o
"}}}

"appearance"{{{
let &t_ti.="\e[1 q"
let &t_SI.="\e[1 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[1 q"
"}}}

"set tabline"{{{
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
"}}}

" Plugin   Vundle"{{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Plugin '[Github Author]/[Github repo]'
"}}}

" gx = open url
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" NERDTree"{{{
" filer :NERDTree
Plugin 'scrooloose/nerdtree'
nnoremap <silent><Space>e :NERDTreeToggle<CR>
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
"call NERDTreeHighlightFile('f90', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('f90', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('dat', 'cyan', 'none', 'cyan', '#151515')

"}}}

"unit.vim"{{{
"Filer
Plugin 'Shougo/unite.vim'
"let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
"nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
"nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"}}}

" serch in visual mode"{{{
Plugin 'thinca/vim-visualstar'
"}}}

" move text in visual mode"{{{
Plugin 't9md/vim-textmanip'
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)

xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

" toggle insert/replace with <F10>
nmap <F10> <Plug>(textmanip-toggle-mode)
xmap <F10> <Plug>(textmanip-toggle-mode)
"}}}

Plugin 'Yggdroot/indentLine'

"all plug#begin('~/.vim/plugged')
Plugin   'prabirshrestha/asyncomplete.vim'
"Plugin   'prabirshrestha/asyncomplete-lsp.vim'
"Plugin   'prabirshrestha/vim-lsp'
"Plugin   'mattn/vim-lsp-settings'
"Plugin   'mattn/vim-lsp-icons'
""call plug#end()et !
"let g:lsp_diagnostics_enabled=1
"""下記は好みによって設定変更すること
"let g:lsp_diagnostics_echo_cursor=1
"let g:lsp_text_edit_enabled=1
"let g:asyncomplete_auto_popup=1
"let g:asyncomplete_popup_delay=200

"snippet"{{{
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'lervag/vimtex'
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }
let g:vimtex_quickfix_open_on_warning = 0
"conceal をオフ
let g:vimtex_syntax_conceal_default = 0


let g:vimtex_view_general_viewer
      \ = '/usr/bin/okular'




"Setting snippet :NeoSnippetEdit
let g:neosnippet#disable_runtime_snippets = { 'tex' : 1 }
let s:my_snippet='~/.vim/snippets/'
let g:neosnippet#snippets_directory = s:my_snippet

" SuperTab like snippets behavior.
imap  <expr><TAB>
    \ pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"}}}
"
"
"
Plugin 'thinca/vim-quickrun'

call vundle#end()

filetype plugin indent on



nnoremap s  <Nop>

"log for vim"{{{
function! ProfileCursorMove() abort
  let profile_file = expand('~/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
  autocmd!
  autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction
"}}}


" for paste"{{{
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
"}}}


let g:latex_latexmk_options = '-pdfdvi'
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex = g:vimtex#re#neocomplete


" replace mode 無効にしてInsertモードに
function s:ForbidReplace()
    if v:insertmode isnot# 'i'
        call feedkeys("\<Insert>", "n")
    endif
endfunction
augroup ForbidReplaceMode
    autocmd!
    autocmd InsertEnter  * call s:ForbidReplace()
    autocmd InsertChange * call s:ForbidReplace()
augroup END




set belloff=all
"nnoremap <S-Left> <Nop>
"nnoremap <S-Right> <Nop>
"nnoremap <S-Up> <Nop>
"nnoremap <S-Down> <Nop>



