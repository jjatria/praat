﻿include ../test/more.proc

# Paul Boersma, 5 January 2009

@plan: 2

asserterror Unknown variable:'newline$'« hg
hg
@pass: "Unknown variable error"

a = 1
asserterror Expected the end of the formula, but found a numeric variable:
a = 5a
@pass: "Expected end of formula error"

@done_testing()
