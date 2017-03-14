let s:dein_dir = expand('~/vimfiles/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repos_dir

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('ctrlpvim/ctrlp.vim')

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

" lightline
let g:lightline = {
	\'colorscheme' : 'wombat',
	\}

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

" vimrcを開く
com! Openrc new $HOME/vimfiles/vimrc
" gvimrcを開く
com! Opengrc new $HOME/vimfiles/gvimrc
