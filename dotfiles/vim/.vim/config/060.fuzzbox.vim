scriptencoding utf-8

if !jetpack#tap("fuzzbox")
    finish
endif

nnoremap fb :FuzzyBuffers<CR>
nnoremap ff :FuzzyFiles<CR>
