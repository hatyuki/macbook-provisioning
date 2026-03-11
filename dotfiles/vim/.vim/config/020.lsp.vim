scriptencoding utf-8

if !jetpack#tap("lsp")
    finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  nmap <buffer> gd <Plug>(lsp-definition)
  nmap <buffer> <F6> <Plug>(lsp-rename)
  inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  nnoremap <buffer> <C-t> <Plug>(lsp-hover)
endfunction

augroup vim_lsp_settings
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_format_sync_timeout = 1000
let g:lsp_semantic_enabled = 0
let g:lsp_text_edit_enabled = 1
let g:lsp_use_native_client = 1

" vim-lsp-settings を遅延ロードに対応させる
let g:lsp_settings_lazyload = 1
