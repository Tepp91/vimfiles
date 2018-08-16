let g:setting_company = filereadable(expand('~/vimfiles/.company'))

let mapleader = ' '

" プラグイン {{{

let s:dein_dir = expand('~/vimfiles/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repos_dir

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/neocomplete.vim')
	call dein#add('Shougo/vimproc.vim')
	call dein#add('Shougo/vimfiler.vim')
	call dein#add('itchyny/lightline.vim')
	call dein#add('ctrlpvim/ctrlp.vim')
	call dein#add('embear/vim-localvimrc')
	call dein#add('junegunn/vim-easy-align')
	call dein#add('ntpeters/vim-better-whitespace')
	call dein#add('wesQ3/vim-windowswap')
	call dein#add('rking/ag.vim')
	call dein#add('thinca/vim-quickrun')
	call dein#add('osyo-manga/shabadou.vim')
	call dein#add('osyo-manga/vim-watchdogs')
	call dein#add('tyru/restart.vim')
	call dein#add('davidhalter/jedi-vim')
	call dein#add('simeji/winresizer')
	call dein#add('SirVer/ultisnips')
	call dein#add('easymotion/vim-easymotion')
	call dein#add('thinca/vim-qfreplace')
	call dein#add('tyru/caw.vim')
	call dein#add('gcmt/taboo.vim')
	call dein#add('dhruvasagar/vim-table-mode')
	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/unite-outline')
	call dein#add('osyo-manga/unite-quickfix')
	call dein#add('tepp91/molokaifork')
	call dein#add('tepp91/DoxygenToolkit.vim')

	if g:setting_company
		call dein#add('tepp91/p4.vim')
	endif

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
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif

" vimproc
let g:vimproc#download_windows_dll = 1

" Vimfiler
let g:vimfiler_as_default_explorer = 1
nnoremap <C-e>b :VimFilerBufferDir -simple<CR>
nnoremap <C-e>d :VimFilerCurrentDir -simple<CR>

augroup vimfiler
	autocmd!
	autocmd FileType vimfiler nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
	autocmd FileType vimfiler nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
augroup END

" unite
nnoremap <Leader>o :Unite -no-split outline<CR>

" lightline
let g:lightline = {
	\ 'colorscheme' : 'wombat',
	\ }

let g:lightline.inactive = {
	\ 'left' : [
	\	['readonly', 'filename', 'modified'],
	\ ],
	\ 'right' : [
	\	['lineinfo'],
	\	['percent'],
	\	['fileformat', 'fileencoding', 'filetype'],
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
let g:easy_align_delimiters = {
\ ']': {
\     'pattern':       '[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0,
\   },
\ ')': {
\     'pattern':       '[)]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0,
\   },
\ }

" ctrlp対策
set wildignore+=*.obj,*.sdf,*.smp,*.ipch,*.idb,*.pdb
let g:ctrlp_switch_buffer = 'et'

" quick-run
let g:quickrun_config = {
	\	'python/watchdogs_checker' : {
	\		'type' : 'watchdogs_checker/flake8',
	\	},
	\
	\ 	'cpp/watchdogs_checker' : {
	\		'type' : 'watchdogs_checker/msvc',
	\ 	},
	\
	\	'watchdogs_checker/msvc' : {
	\		'command' : 'C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/cl.exe',
	\		'hook/output_encode/encoding' : 'sjis',
	\		'cmdopt' : '/Zs ',
	\	},
	\ }


" watchdog
if g:setting_company
	let g:watchdogs_check_BufWritePost_enables = {
		\ 'cpp' : 0,
		\ 'python' : 1,
		\ }
else
	let g:watchdogs_check_BufWritePost_enables = {
		\ 'cpp' : 0,
		\ 'python' : 1,
		\ }
endif

call watchdogs#setup(g:quickrun_config)

" restart
let g:restart_sessionoptions = 'blank,curdir,folds,help,localoptions,tabpages'

" jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" winresizer
let g:winresizer_start_key = '<C-w><C-e>'

" UltiSnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger='<C-k>'
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

if g:setting_company
	let g:UltiSnipsSnippetDirectories = ['ultisnippets_com']
else
	let g:UltiSnipsSnippetDirectories = ['ultisnippets']
endif

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
nmap f <Plug>(easymotion-bd-f)
nmap <Leader>l <Plug>(easymotion-bd-jk)

" caw.vim
let g:caw_operator_keymappings = 1
let g:caw_wrap_sp_left = ''
let g:caw_wrap_sp_right = ''

"taboo.vim
let g:taboo_tab_format = '%N. %f%m '
let g:taboo_renamed_tab_format = '%N. %l%m '

com! TabRename execute 'TabooRename ' . expand('%:t:r')

" }}} プラグインここまで

" ファイルタイプ
au BufNewFile,BufRead *.xaml setf xaml

" タブ
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

autocmd FileType python setlocal expandtab
autocmd FileType python setlocal softtabstop=4

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
set iminsert=0
set imsearch=-1

" 行末ヤンク
nnoremap Y y$

" ノーマルモードでも改行
nnoremap <CR> :execute "normal o"<CR>
nnoremap <S-CR> :execute "normal O"<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>

" Esc代行
imap <C-j> <Esc>
vmap <C-j> <Esc>
inoremap <Esc> <Esc>:set iminsert=0<CR>


" 強調表示解除
nnoremap <C-n> :noh<CR>

" Include展開
nnoremap gh :wincmd f<CR>
nnoremap gv :vertical wincmd f<CR>

" 今開いているファイルのディレクトリに移動
com! Cdpwd cd %:h

" 改行時にコメントを続けない
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" 現在のファイパスをクリップボードにコピー
command! Copyfilepath let @* = expand('%:p') | echo @*
command! Copyfilename let @* = expand('%:t') | echo @*

" QuickFixを下に表示する
au FileType qf wincmd J

" xml、htmlなどのタグジャンプ
source $VIMRUNTIME/macros/matchit.vim

" タグジャンプ
nnoremap <C-]> g<C-]>

" C++インデント
au BufNewFile,BufRead *.cpp,*.h,*.inl set cindent
au BufNewFile,BufRead *.cpp,*.h,*.inl set cino=g0:0

" コメント行を書く
let s:comment_prefix = {
\	'cpp' : '//',
\	'python' : '# ',
\	'vim' : '"',
\	}

let s:comment_line_default_length = 79

let s:comment_line_length = {
\	'python' : 72,
\	}

function! WriteCommentLine()
	let prefix = get(s:comment_prefix, &filetype, '')
	if prefix == ''
		return ''
	endif

	let indent = (virtcol('.')-1)
	let length = get(s:comment_line_length, &filetype, s:comment_line_default_length)
	let comment = prefix . repeat('-', length-indent-strdisplaywidth(prefix))
	return comment
endfunction

inoremap <expr><C-l> WriteCommentLine()

function! OpenSrc()
	let filename = expand('%:p:r').'.cpp'
	if filereadable(filename)
		execute 'vnew '.filename
	else
		echomsg 'Not found '.filename
	endif
endfunction

com! Src call OpenSrc()

function! OpenInc()
	let filename = expand('%:p:r').'.h'
	if filereadable(filename)
		execute 'vnew '.filename
	else
		echomsg 'Not found '.filename
	endif
endfunction

com! Inc call OpenInc()

function! OpenInl()
	let filename = expand('%:p:r').'.inl'
	if filereadable(filename)
		execute 'vnew '.filename
	else
		echomsg 'Not found '.filename
	endif
endfunction

com! Inl call OpenInl()

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

" vim:set foldmethod=marker:
