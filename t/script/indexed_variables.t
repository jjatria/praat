include ../test/more.proc

@no_plan()

a [1] = 3
@is: a [1], 3, "Indexed query on indexed variable"

a = 7
asserterror Missing expression after variable a[9].
a [a+2] =
@pass: "Missing expression after variable error"

a [3], 5 = 7
@is$: "'a[3,5]'", "'" + "a[3,5]" + "'", "Parsed faulty placement of closing bracket"
@is$: "'a[3]'", "0", ""

a [1] = 2
b [a [1]] = 3
@is: b [a [1]], 3, "Nested indices"
@is$: "'b[2]'", "3", "Interpolation of indexed variables"

speaker$[1]="paul"
@is$: speaker$[1], "paul", "Assignment to string indexed varibale (no whitespace)"

speaker$ [2] = "silke"
@is$: speaker$[2], "silke", "Assignment to string indexed varibale (whitespace)"

a$ = speaker$ [1] + " " + speaker$ [2]
@is$: a$, "paul silke", "Concatenation of indexed strings"

a[2 + length("h]""k")] = 6
@is: a[6], 6, "Complex indexing"

a[6] += 3
@is: a[6], 9, "Incrementing in indexed variables"

@done_testing()
