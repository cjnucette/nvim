" syntax match todoCheckbox "- \[\ \]" conceal cchar=
" syntax match todoCheckbox "- \[[xX]\]" conceal cchar=
" call matchadd('Conceal', "\[\ \]", 0, 11, { 'conceal': ''})
" call matchadd('Conceal', "\[x\]", 0, 12, { 'conceal': ''})
