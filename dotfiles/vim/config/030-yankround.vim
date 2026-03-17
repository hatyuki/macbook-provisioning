scriptencoding utf-8

if !jetpack#tap("yankround")
    finish
endif

let g:yankround_dir = $HOME . "/.vim"

nnoremap p <Plug>(yankround-p)
nnoremap P <Plug>(yankround-P)
nnoremap <C-p> <Plug>(yankround-prev)
nnoremap <C-n> <Plug>(yankround-next)
