# Since this test is testing local variables,
# TAP output is itself prepared without any procedure calls.
test = 0

call old_hypotenuse 3 4
test += 1
code$ = if old_hypotenuse.result == 5
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Main procedure (shorthand), final variable"

test += 1
code$ = if old_add.result == 25
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Add procedure (shorthand), final variable"

test += 1
code$ = if old_square.result == 16
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Square procedure (shorthand), final variable"

@new_hypotenuse: 3, 4
test += 1
code$ = if new_hypotenuse.result == 5
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Main procedure, final variable"

test += 1
code$ = if new_add.result == 25
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Add procedure, final variable"

test += 1
code$ = if new_square.result == 16
   ... then "" else "not " fi + "ok"
appendInfoLine: code$, " ", test, " - Square procedure, final variable"

select all
test += 1
code$ = if !numberOfSelected()
   ... then "" else "not " fi + "ok"
noarg = 0
appendInfoLine: code$, " ", test, " - Workspace is clean"

appendInfoLine: "1..", test

procedure old_add .x .y
   .result = .x + .y
endproc

procedure old_square .x
   .result = .x ^ 2
endproc

procedure old_hypotenuse .x .y
   call old_square .x
   .x2 = old_square.result

   call old_square .y
   .y2 = old_square.result

   call old_add .x2 .y2
   .result = sqrt (old_add.result)
endproc

procedure new_add: .x .y
   .result = .x + .y
endproc

procedure new_square: .x
   .result = .x ^ 2
endproc

procedure new_hypotenuse: .x, .y
   @new_square: .x
   .x2 = new_square.result

   @new_square: .y
   .y2 = new_square.result

   @new_add: .x2, .y2
   .result = sqrt (new_add.result)
endproc
