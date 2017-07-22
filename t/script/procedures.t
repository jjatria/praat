# Since this test is testing procedure calls,
# TAP output is prepared manually, without any procedure calls
test = 0

call old 1 a 2 b
test += 1
code$ = if old.result$ = "old1a2b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Shorthand definition, shorthand call"

@old (3, "a", 4, "b")
test += 1
code$ = if old.result$ = "old3a4b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Shorthand definition, parentheses call"

@old: 5, "a", 6, "b"
test += 1
code$ = if old.result$ = "old5a6b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Shorthand definition, colon call"

call new 1 a 2 b
test += 1
code$ = if new.result$ = "new1a2b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Parentheses definition, shorthand call"

@new (3, "a", 4, "b")
test += 1
code$ = if new.result$ = "new3a4b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Parentheses definition, parentheses call"

@new: 5, "a", 6, "b"
test += 1
code$ = if new.result$ = "new5a6b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Parentheses definition, colon call"

call colon 1 a 2 b
test += 1
code$ = if colon.result$ = "colon1a2b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Colon definition, shorthand call"

@colon (3, "a", 4, "b")
test += 1
code$ = if colon.result$ = "colon3a4b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Colon definition, parentheses call"

@colon: 5, "a", 6, "b"
test += 1
code$ = if colon.result$ = "colon5a6b"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Colon definition, colon call"

@colon (33,"ho,p"",""kkk", 5, "h")
test += 1
code$ = if colon.result$ = "colon33ho,p"",""kkk5h"
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Colon definition, complex parentheses call"

noarg = 0

@noarg1()
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Blank definition, empty paren call"

@noarg1 ( )
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Blank definition, empty paren call with whitespace"

@noarg1:
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Blank definition, trailing colon call"

@noarg1
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Blank definition, blank call"

@noarg1
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Blank definition, trailing spaces call"

call noarg1
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Blank definition, blank shorthand call"

@noarg2()
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Empty paren definition, empty paren call"

@noarg2 ( )
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Empty paren definition, empty paren call with whitespace"

@noarg2:
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Empty paren definition, trailing colon call"

@noarg2
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Empty paren definition, blank call"

@noarg2
test += 1
code$ = if noarg
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Empty paren definition, trailing spaces call"

;call noarg2

;asserterror The procedure "colon" expects 4 arguments but got only 3.
;@colon (1, "a", 2)

select all
test += 1
code$ = if !numberOfSelected()
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Workspace is clean"

appendInfoLine: "1..", test

procedure old .a .b$ .c .d$
   .result$ = "old" + string$ (.a) + .b$ + string$ (old.c) + .d$
endproc

procedure new (.a, .b$, .c, .d$)
   .result$ = "new" + string$ (.a) + .b$ + string$ (new.c) + .d$
endproc

procedure colon: .a, .b$, .c, .d$
   .result$ = "colon" + string$ (.a) + .b$ + string$ (colon.c) + .d$
endproc

procedure noarg1
   noarg = 1
endproc

procedure noarg2 ( )
   noarg = 1
endproc
