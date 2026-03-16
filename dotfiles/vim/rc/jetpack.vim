scriptencoding utf-8

" =================================== Jetpack ==================================
call jetpack#begin()

" ==// Jetpack
call jetpack#add("tani/vim-jetpack", #{ opt: 1 })

" ==// Syntax highlighting
call jetpack#add("sheerun/vim-polyglot")
call jetpack#add("chrisbra/colorizer")

" ==// Nord colorscheme
call jetpack#add("nordtheme/vim", #{ name: "nordtheme" })

" ==// LSP
call jetpack#add("prabirshrestha/vim-lsp", #{ name: "lsp" })
call jetpack#add("mattn/vim-lsp-settings", #{ name: "lsp-settings" })

" ==// yankround
call jetpack#add("LeafCage/yankround.vim", #{ name: "yankround" })

" ==// Lexima (カッコの入力を賢くする)
call jetpack#add("cohama/lexima.vim", #{ name: "lexima" })

" ==// Lightline
call jetpack#add("itchyny/lightline.vim", #{ name: "lightline" })
call jetpack#add("rbtnn/vim-ambiwidth", #{ name: "ambiwidth" })
call jetpack#add("tpope/vim-fugitive")
call jetpack#add("airblade/vim-gitgutter")

" ==// Explorer (File / Buffer / ...)
if v:version >= 900
    call jetpack#add("vim-fuzzbox/fuzzbox.vim", #{ name: "fuzzbox" })  " Too much だけど、他にいいのがない
endif

call jetpack#end()

" ==============================================================================
" Plugin 個別の設定 (~/.vim/config) をまとめてロードする
" ==============================================================================
runtime! config/*.vim
