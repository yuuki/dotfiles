syntax match label "[\^\|\s]\([[:alnum:]_.-]\+\):"
syntax match field_value ":\(.+\)\s"

highlight link label Type
highlight link filed_value String

let b:current_syntax = "ltsv"
