scriptencoding utf-8

if !jetpack#tap("nordtheme")
    finish
endif

let g:colorizer_auto_color = 1

augroup adjust_color
    autocmd!
    autocmd ColorScheme * set termguicolors " 24bit カラー有効化
    autocmd ColorScheme * highlight Normal     guibg=NONE
    autocmd ColorScheme * highlight Comment    guifg=#8A8A8A ctermfg=245                        " コメントが見にくい
    autocmd ColorScheme * highlight CursorLine guibg=#303030 ctermbg=236                        " 現在行表示が見にくい
    autocmd ColorScheme * highlight Visual     guibg=#7F7F7F guifg=#E5E5E5 ctermbg=8 ctermfg=7  " 範囲選択が見にくい
    autocmd BufRead,BufNewFile * ColorHighlight
    " ファイルタイプを限定してカラー表示する場合
    " autocmd FileType css,html ColorHighlight
augroup END

colorscheme nord
