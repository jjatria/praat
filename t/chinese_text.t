include test/more.proc

@no_plan()

# String function works with Chinese characters in Linux (Ubuntu)
string$="02 你好大家好"

@is$: right$(string$, 2), "家好", "Extract substring from Chinese string"

# Regular Expression doesn't work with Chinese characters,
# but works with English in Linux (Ubuntu)
@is: length(string$), 8, "Length of Chinese string"
@is: rindex_regex(string$, "\d"), 2, "Regular expression match with Chinese string"

string$ = "02 Next time"
@is: rindex_regex(string$, "\d"), 2, "Regular expression match with English string"

@done_testing()
