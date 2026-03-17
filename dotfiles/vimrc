scriptencoding utf-8

" ==============================================================================
" 基本設定 (Basic)
" ==============================================================================
filetype plugin indent on       " ファイルタイプの検出とインデントを有効化する
set autoread                    " ファイルに更新があったら自動で読み込む
set backspace=indent,eol,start  " バックスペースの挙動を自然にする (インデント・改行・インサートモードの文字を消せる)
set hidden                      " 未保存のファイルがあっても、バッファ切り替えを許可する
set modeline                    " ファイルの先頭や末尾の設定 (`vim: ...`) を有効化する
set modelines=5                 " modeline を探しに行く行数の範囲 (先頭・末尾)
set virtualedit=block           " 文字の無いところまで矩形選択を可能にする


" ==============================================================================
" 表示設定 (Display)
" ==============================================================================
colorscheme slate      " とりあえずお好みのカラースキームを設定する
syntax on              " シンタックスハイライトを有効化する

set background=dark    " 背景が (多くの環境で) 黒っぽいことを伝えておく
set cursorline         " 現在行のハイライトを有効化する
set number             " 行数を表示する
set regexpengine=0     " シンタックスハイライトの正規表現エンジンは自動選択とする
set showmatch          " 対応するカッコを強調する

" ステータスライン
set laststatus=2       " ステータスラインに↓を常に表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 不可視文字の表示
set list               " スペースなどの不可視文字を↓で可視化する
" set listchars=tab:»-¦,trail:‹,extends:»,precedes:«,nbsp:%  " TAB / 行末スペース / はみ出し / NO-BREAK SPACE
set listchars=tab:»-¦,trail:~,extends:»,precedes:«,nbsp:%  " TAB / 行末スペース / はみ出し / NO-BREAK SPACE

" 折りたたみ設定
set foldenable         " 折りたたみを有効化する
set foldlevel=99       " デフォルトではすべて開いた状態とする
set foldmethod=indent  " インデント部分で自動的に折りたたむ

" その他
set ambiwidth=double  " 「文字幅が曖昧な文字」は2文字幅で表示する


" ==============================================================================
" インデント・タブ設定 (Indent / Tab)
" ==============================================================================
set autoindent     " 自動インデントを有効化する
set smartindent    " 賢くインデントする (`if` の後の改行でインデントするなど)
set shiftwidth=4   " インデント幅は 4

set expandtab      " <TAB> をスペースに変換する
set tabstop=4      " <TAB> の表示幅は 4
set softtabstop=4  " スペース消すときは <TAB> と同じく4つ分を一気に消す


" ==============================================================================
" 検索設定 (Search)
" ==============================================================================
set hlsearch    " 検索結果をハイライトする (<ESC><ECS> でハイライトを消す)
set ignorecase  " 大文字・小文字を区別しない
set incsearch   " インクリメンタルサーチする
set smartcase   " 検索文字列に大文字が含まれている場合は区別する


" ==============================================================================
" システム連携 (System)
" ==============================================================================
" エンコーディング
set encoding=utf-8  " デフォルトは UTF-8
set fileencodings=utf-8,utf-16le,utf-16be,eucJP-ms,cp-932,sjis,iso-2022-jp,latin1

" クリップボード
if has("clipboard")  " 可能であればシステムのクリップボードと同期する
    if has("mac") || has("win64")
        set clipboard+=unnamed
    else  " Linux (X11) の場合は `unnamedplus`
        set clipboard+=unnamedplus
    endif
endif

" マウス
if has("mouse")  " マウスが使える環境なら、マウス操作を有効化する
    set mouse+=a
endif


" ==============================================================================
" コマンドライン (Command Line)
" ==============================================================================
set wildmenu               " 補完候補一覧を表示する
set wildmode=longest,full  " 補完候補の表示方法の指定
set wildoptions=fuzzy     " 補完候補の選択にファジーマッチを利用する


" ==============================================================================
" 補完
" ==============================================================================
set complete=o,.^10,b^10,w^5,u^5     " 補完候補をどこから持ってくるかの設定
set completeopt=fuzzy,popup,preview  " 補完にファジーマッチ・ポップアップ・プレビューを利用する


" ==============================================================================
" 標準ファイラ (Netrw)
" ==============================================================================
let g:netrw_browse_split = 4                               " ファイルを previous window で開く
let g:netrw_list_hide="\.DS_Store,\.git/,\.idea/,.*\.swp"  " リストに表示しないファイルの種類を指定する
let g:netrw_liststyle=1                                    " リストスタイルで表示する
let g:netrw_sizestyle="H"                                  " ファイルサイズを K / M / G で表示する
let g:netrw_timefmt="%Y/%m/%d %H:%M:%S"                    " yyyy/mm/dd HH:MM:SS で表示する
let g:netrw_winsize=30                                     " ファイラに割くウィンドウサイズを決める
let g:netrw_preview=0                                      " プレビューウィンドウは垂直分割で表示する


" ==============================================================================
" キーマッピング (Keymap)
" ==============================================================================
" Normal / Visual モードでは論理行ではなく物理行で移動する
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Ctrl-* でウィンドウ間を移動する
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" ff で Netrw 起動
nnoremap ff :Vexplore<CR>

" ft で Terminal 起動
nnoremap ft :botright terminal ++rows=15<CR>

" <Esc> で検索結果のハイライトを消す
nnoremap <silent> <Esc> <Cmd>nohlsearch<CR>

"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"


" ==============================================================================
" 比較的新しい VIM でのみ動作可能なもの
" ==============================================================================
if exists(":packadd")
    packadd! comment       " コメントの切り替えを行う
    packadd! editorconfig  " `.editorconfig` に対応する
    packadd! hlyank        " コピーした範囲を可視化する
    packadd! matchit       " `%` キーのマッチ移動を賢くする
    packadd! nohlsearch    " 検索結果のハイライトを一定時間経過したら消す
endif

if has("patch-9.1.1590")
    set autocomplete  " 自動的に補完メニューを表示する
endif


" ==============================================================================
" Jetpack
" ==============================================================================
silent! packadd vim-jetpack

if exists("*jetpack#begin")
    runtime! rc/jetpack.vim  " Jetpack に関する設定 (`rc/jetpack.vim`) を読み込む
endif

" vim: ft=vim
