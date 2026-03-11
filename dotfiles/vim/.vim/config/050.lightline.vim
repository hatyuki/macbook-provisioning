scriptencoding utf-8

if !jetpack#tap("lightline")
    finish
endif

if jetpack#tap("ambiwidth")  " Nerd Fonts は半角幅で表示する
    let g:ambiwidth_cica_enabled = v:false
    let g:ambiwidth_add_list = [
\       [0xE0A1, 0xE0A3, 1],
\       [0xE0B0, 0xE0C8, 1],
\       [0xE0CA, 0xE0CA, 1],
\       [0xE0CC, 0xE0D2, 1],
\       [0xE0D4, 0xE0D4, 1],
\       [0x2026, 0x2026, 2],
\   ]
endif

set noshowmode  " 標準のモード表示は切る

" ちょっとカラースキームを修正する
let s:p = g:lightline#colorscheme#nord#palette
let s:p.normal.right = [
\   ["#3B4252", "#81A1C1", 0, 4],
\   ["#E5E9F0", "#3B4252", 7, 0],
\ ]
let s:p.inactive.left = [
\   ["#E5E9F0", "#4C566A", 7, 8],
\ ]
let s:p.inactive.right = [
\   ["#E5E9F0", "#4C566A", 7, 8],
\ ]
let g:lightline#colorscheme#nord#palette = s:p


let g:lightline = #{
\   colorscheme: "nord",
\   active: #{
\       left:  [["mode", "paste", "modified"], ["filetypeicon"], ["relativepath"]],
\       right: [["readonly", "lineinfo", "percent"], ["gitbranch"], ["fileformat", "fileencoding"]],
\   },
\   inactive: #{
\       left:  [["modified"], ["relativepath"]],
\       right: [["gitbranch"]],
\   },
\   component_function: #{
\       filetypeicon: "LL_filetypeicon",
\       modified: "LL_modified",
\       gitbranch: "LL_gitbranch",
\       gitstatus: "LL_gitstatus",
\       readonly: "LL_readonly",
\   },
\   separator:    #{ left: "", right: "" },
\   subseparator: #{ left: "|", right: "|" },
\ }

" Ghostty を使っているかどうか
let s:is_ghostty = $TERM =~ "-ghostty$"

" Ghostty なら Separator をちょっとリッチに
if s:is_ghostty
    let g:lightline.separator = #{ left: "\uE0B8", right: "\uE0BA" }
    let g:lightline.subseparator = #{ left: "\uE0BF", right: "\uE0BD" }
endif

" Filetype 別にアイコンを定義する
let s:fticons = #{
\   css: 0xE749,
\   go: 0xE627,
\   html: 0xE736,
\   javascript: 0xE60C,
\   json: 0xE60B,
\   kdl: 0xE615,
\   make: 0xE673,
\   markdown: 0xF48A,
\   nix: 0xE843,
\   python: 0xE606,
\   ruby: 0xE605,
\   scss: 0xE603,
\   sh: 0xF489,
\   typescript: 0xE628,
\   vim: 0xE62B,
\   vue: 0xE6A0,
\   yaml: 0xE8EB,
\   zsh: 0xF489,
\ }

function! LL_filetypeicon() abort
    return s:is_ghostty ? " ".nr2char(get(s:fticons, &filetype, 0xF4A5))." " : &filetype
endfunction

function! LL_modified() abort
    if &modifiable && &modified
        " 0xF090C: nf-md-square_edit_outline
        return s:is_ghostty ? nr2char(0xF090C) : "*"
    endif

    " 0xF14FC: nf-md-square_rounded_outline
    return s:is_ghostty ? nr2char(0xF14FC) : "-"
endfunction

function! LL_readonly() abort
    if &readonly
        " 0xF456: nf-oct-lock
        return s:is_ghostty ? " ".nr2char(0xF456)." " : "[RO]"
    endif

    " 0xF52A: nf-oct-unlock
    return s:is_ghostty ? " ".nr2char(0xF52A)." " : ""
endfunction

function LL_gitbranch() abort
    if !FugitiveIsGitDir()
        return s:is_ghostty ? " ".nr2char(0xEB05)." " : "-"
    endif

    let l:worktree = fnamemodify(FugitiveWorkTree(), ":t")

    " 0xF418: nf-oct-git_branch
    return l:worktree." on ".(s:is_ghostty ? nr2char(0xF418)." " : "").FugitiveHead()
endfunction
