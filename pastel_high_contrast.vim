hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "pastel_high_contrast"

" Enable truecolor support for Tmux
if &term =~ 'tmux'
    set termguicolors
endif

" Background & slightly gray foreground
hi Normal       ctermbg=235 ctermfg=250 guibg=#2E2E2E guifg=#D3D3D3

" Comments
hi Comment      ctermfg=244 guifg=#7D7D7D gui=italic

" Strings
hi String       ctermfg=114 guifg=#A8E6CF

" Keywords
hi Keyword      ctermfg=141 guifg=#D4A5A5 gui=bold

" Functions
hi Function     ctermfg=75 guifg=#80B3FF

" Constants
hi Constant     ctermfg=221 guifg=#FFD97D

" Variables
hi Identifier   ctermfg=216 guifg=#FF8787

" Types
hi Type         ctermfg=81 guifg=#7EE8FA gui=bold

" Operators
hi Operator     ctermfg=208 guifg=#FF6B6B

" Preprocessor (includes, macros, etc.)
hi PreProc      ctermfg=186 guifg=#FFEB99 gui=italic

" Line numbers
hi LineNr       ctermfg=244 guifg=#555555

" Cursor line
hi CursorLine   ctermbg=237 guibg=#3A3A3A

" Visual selection
hi Visual       ctermbg=238 guibg=#4A4A4A

" Status line (Tmux compatibility)
hi StatusLine   ctermbg=238 ctermfg=250 guibg=#444444 guifg=#D3D3D3
hi StatusLineNC ctermbg=236 ctermfg=244 guibg=#333333 guifg=#BBBBBB

" Search highlight
hi Search       ctermbg=220 ctermfg=16 guibg=#FFD97D guifg=#000000
hi IncSearch    ctermbg=208 ctermfg=16 guibg=#FF6B6B guifg=#000000

" Errors
hi Error        ctermbg=196 ctermfg=250 guibg=#FF6B6B guifg=#D3D3D3

" Matching parentheses
hi MatchParen   ctermbg=240 ctermfg=250 guibg=#5A5A5A guifg=#D3D3D3

" Diff colors (Tmux-friendly contrast)"
hi DiffAdd      ctermbg=22  ctermfg=250 guibg=#2A4B2A guifg=#D3D3D3   " Dark green for added lines
hi DiffDelete   ctermbg=52  ctermfg=250 guibg=#5A2020 guifg=#D3D3D3   " Dark red for deleted lines
hi DiffChange   ctermbg=94  ctermfg=250 guibg=#7A4A2A guifg=#D3D3D3   " Brown for modified lines
hi DiffText     ctermbg=214 ctermfg=16  guibg=#D4883E guifg=#000000   " Bright orange for highlighted diff changes
