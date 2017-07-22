include ../test/more.proc

@no_plan()

a# = { 1, 4, 9, 16, 25 }
@is: sum (a#),  55, "sum#()"

@is:        mean (a#), 11,                  "precalculated mean()"
@is_approx: mean (a#), sum (a#) / 5, 1e-14, "programatic mean()"

@is_approx: stdev (a#), 9.669539802906858, 1e-14, "precalculated stdev#()"
@is_approx: stdev (a#),
   ... sqrt (sumOver (i to 5, (a# [i] - mean (a#)) ^ 2) / 4), 1e-14,
   ... "programatic stdev#()"

@is_approx: center (a#), 4.090909090909091, 1e-14, "precalculated center()"
@is_approx: center (a#), sumOver (i to 5, i * a# [i]) / sum (a#), 1e-14,
   ... "programatic center()"

@done_testing()
