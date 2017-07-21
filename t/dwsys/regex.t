include ../test/more.proc

# This file is saved in UTF16 Big Endian

@no_plan()

@is$: replace_regex$ ("hallo", ".", "&&", 0),
   ... "hhaalllloo", "replace_regex$()"

@is$: replace_regex$ ("hɑllɔ", ".", "&&", 0),
   ... "hhɑɑllllɔɔ", "replace_regex$() with unicode characters"

@is$: replace_regex$ ("g a t - i", "d - i", "- j i", 1),
   ... "g a t - i", "replace_regex$() with multicharacter patterns"

@diag: "Regression tests"
# something that went wrong when Rob compiled Praat with -O2 on mingw (20110916):
s$ = "ma0"
@is$: replace_regex$(s$, "5", "0", 0),    "ma0",
   ... "Do not replace missing characters"

@is$: replace_regex$(s$, "ma", "pa5", 0), "pa50",
   ... """ma0"" =~ s/ma/pa5/ == ""pa50"""

@done_testing()
