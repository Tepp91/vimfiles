let g:setting_company = filereadable(expand('~/vimfiles/.company'))

let s:dein_dir = expand('~/vimfiles/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repos_dir

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/neocomplete.vim')
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/vimproc.vim')
	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/vimfiler.vim')
	call dein#add('itchyny/lightline.vim')
	call dein#add('ctrlpvim/ctrlp.vim')
	call dein#add('embear/vim-localvimrc')
	call dein#add('nfvs/vim-perforce')
	call dein#add('junegunn/vim-easy-align')
	call dein#add('ntpeters/vim-better-whitespace')
	call dein#add('wesQ3/vim-windowswap')
	call dein#add('rking/ag.vim')
	call dein#add('thinca/vim-quickrun')
	call dein#add('osyo-manga/shabadou.vim')
	call dein#add('osyo-manga/vim-watchdogs')

	call dein#add('tepp91/molokaifork')
	call dein#add('tepp91/DoxygenToolkit.vim')

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" neosnipopet
let g:neosnippet#disable_runtime_snippets = {
	\ '_' : 1,
	\ }

if g:setting_company
	let g:neosnippet#snippets_directory = expand('~/vimfiles/snippets_com')
else
	let g:neosnippet#snippets_directory = expand('~/vimfiles/snippets')
endif
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

autocmd BufWritePost *.snip,*.snippets
	\ call neosnippet#variables#set_snippets({})

command ReloadSnip :call neosnippet#variables#set_snippets({})

" vimproc
let g:vimproc#download_windows_dll = 1

" lightline
let g:lightline = {
	\ 'colorscheme' : 'wombat',
	\ }

let g:lightline.inactive = {
	\ 'left' : [
	\	['filename', 'modified'],
	\ ],
	\ 'right' : [
	\	['lineinfo'],
	\	['percent'],
	\ ],
	\ }

" vim-localvimrc
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

" DoxygenToolKit
let g:DoxygenToolkit_briefTag_pre = ''
let g:DoxygenToolkit_returnTag = '@return	'
let g:DoxygenToolkit_paramTag_pre = '@param	'
let g:DoxygenToolkit_compactDoc = 'yes'

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ctrlp対策
set wildignore+=*.obj,*.sdf,*.smp,*.ipch,*.idb,*.pdb

" watchdog
if g:setting_company
	let g:watchdogs_check_BufWritePost_enables = {
		\ "cpp" : 0,
		\ }
else
	let g:watchdogs_check_BufWritePost_enables = {
		\ "cpp" : 1,
		\ }
endif

let g:quickrun_config = {
	\ 	"cpp/watchdogs_checker" : {
	\		"type" : "watchdogs_checker/msvc",
	\ 	},
	\
	\	"watchdogs_checker/msvc" : {
	\		"command" : "C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/cl.exe",
	\		"hook/output_encode/encoding" : "sjis",
	\		"cmdopt" : "/Zs ",
	\	},
	\ }

call watchdogs#setup(g:quickrun_config)

" タブ
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

" 検索
set ignorecase
set smartcase

" その他
set nobackup
set noswapfile
set noundofile
set clipboard=unnamed
set shortmess+=I
set whichwrap=b,s,h,l,<,>,[,],~
set completeopt=preview
set autoread

let mapleader = ' '

" 行末ヤンク
nnoremap Y y$

" ノーマルモードでも改行
nnoremap <CR> :exec "normal o"<CR>
nnoremap <S-CR> :exec "normal O"<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>

" 改行時にコメントを続けない
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" C++インデント
au BufNewFile,BufRead *.cpp,*.h,*.inl set cindent
au BufNewFile,BufRead *.cpp,*.h,*.inl set cino=g0:0

" C++コメント行を書く
function! WriteCommentLine()
	let l:indent = (virtcol('.')-1)
	let l:comment = '//' . repeat('-', 80-indent-2)
	return comment
endfunction

inoremap <expr><C-l> WriteCommentLine()

" vimrcを開く
com! Openrc tabnew $HOME/vimfiles/vimrc
" gvimrcを開く
com! Opengrc tabnew $HOME/vimfiles/gvimrc


"pythonで書かれたvim script
python3 import vim
py3file <sfile>:h/vimrc.py

" C++名前空間を出力
function! WriteCppNamespace(...)
	python3 write_cpp_namespace(vim.eval('a:000'))
endfunction

com! -nargs=+ NS call WriteCppNamespace(<f-args>)
