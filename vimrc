let s:dein_dir = expand('~/vimfiles/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repos_dir

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('embear/vim-localvimrc')
call dein#add('nfvs/vim-perforce')

call dein#add('Tepp91/molokaiFork')
call dein#add('Tepp91/DoxygenToolkit.vim')

call dein#end()

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

let s:snippet_dir_default = expand('~/vimfiles/snippets')
let s:snippet_dir_company = expand('~/vimfiles/snippets_com')
if isdirectory(s:snippet_dir_company)
	let g:neosnippet#snippets_directory = s:snippet_dir_company
else
	let g:neosnippet#snippets_directory = s:snippet_dir_default
endif
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" lightline
let g:lightline = {
	\'colorscheme' : 'wombat',
	\}

" vim-localvimrc
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

" ctrlp対策
set wildignore+=*.obj,*.sdf,*.smp,*.ipch,*.idb,*.pdb

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

" 行末ヤンク
nnoremap Y y$

" ノーマルモードでも改行
nnoremap <CR> :exec "normal o"<CR>
nnoremap <S-CR> :exec "normal O"<CR>

" 改行時にコメントを続けない
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" C++コメント行を書く
function! WriteCommentLine()
	let l:indent = (virtcol('.')-1)
	let l:comment = '//' . repeat('-', 80-indent-2)
	return comment
endfunction

inoremap <expr><C-l> WriteCommentLine()

" vimrcを開く
com! Openrc new $HOME/vimfiles/vimrc
" gvimrcを開く
com! Opengrc new $HOME/vimfiles/gvimrc

