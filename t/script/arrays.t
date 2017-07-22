include ../test/more.proc

@no_plan()

@diag: "vectors and matrices..."

a# = zero#(16)
a#[3] = 4
@is: a#[3], 4, "Vector index query"

asserterror Vector b# does not exist.
b# [5] = 3
@pass: "Vector does not exist error"

asserterror A vector index cannot be less than 1 (the index you supplied is 0).
a# [0] = 932875289
@pass: "Vector index cannot be less than 1 error"

asserterror A vector index cannot be greater than the number of elements (here 16). The index you supplied is 20.
a# [20] = 45786457
@pass: "Vector index out of bounds error"

a## = zero##(5, 6)
@is: numberOfRows(a##), 5,
   ... "numberOfRows() on 2D matrix"

@is: numberOfColumns(a##), 6,
   ... "numberOfColumns() on 2D matrix"

# Must use a temporary variable because of faulty parsing of
# nested commas in arguments to procedure
x = a## [3, 4]
@is: x, 0, "Indexed query on 2D matrix of zeros"

a## [5, 6] = 567
x = a## [5, 6]
@is: x, 567, "Indexed query on 2D matrix"

c# = linear# (0, 100, 101)
@is: c# [98], 97,
   ... "Linear array with 101 elements"

c# = linear# (0, 100, 101, 0)
@is: c# [98], 97,
   ... "Linear array with 101 elements"

c# = linear# (0, 100, 100, 1)
@is: c# [98], 97.5,
   ... "Linear array with 100 elements excluding edges"

@test_randomGauss: 20, 1
@test_randomUniform: 7, 10
@test_randomInteger: 7, 10

procedure test_randomGauss: .mean, .sd
   mean = 20
   sd = 1
   .d# = randomGauss# (c#, mean, sd)
   check.a# = .d#
   @check()

   @is_approx: check.mean, mean, 1,
     ... "randomGauss#() respects mean"

   @is_approx: check.sd, sd, 1,
     ... "randomGauss#() respects sd"

endproc

procedure test_randomUniform: .min, .max
   .min = 7
   .max = 10
   .d# = randomUniform# (c#, .min, .max)
   check.a# = .d#
   @check()

   @cmp_ok: .min, "<=", check.min,
     ... "randomUniform#() respects min"

   # Max is exclusive
   @cmp_ok: .max, ">", check.max,
     ... "randomUniform#() respects max"

endproc

procedure test_randomInteger: .min, .max
   .min = 7
   .max = 10
   .d# = randomInteger# (c#, .min, .max)
   check.a# = .d#
   @check()

   @cmp_ok: .min, "<=", check.min,
     ... "randomInteger#() respects min"

   # Max is inclusive
   @cmp_ok: .max, ">=", check.max,
     ... "randomInteger#() respects max"

endproc

e# = a# + a#
@is: e#[3], 8, "Vectorised sum"

asserterror numbers of elements should be equal
e# = a# + c#
@pass: "Numbers of elements should be equal error"

@done_testing()

procedure length()
   .a = 0
   .i = 0
   # We must have an object selected to be able to
   # use nocheck, which we need to query without knowing bounds
   .hack = Create TextGrid: 0, 1, "blank", ""
   repeat
      .i += 1
      .a = nocheck length.a#[.i]
   until .a == undefined
   removeObject: .hack
   .n = .i - 1
endproc

procedure variance: .mean, .length
   .return = 0
   for .i to .length
      .return += (.a#[.i] - .mean) ^ 2
   endfor
   .return /= .length
endproc

procedure check ()
   .sum = 0
   .min = 99999
   .max = 0
   length.a# = .a#
   @length()
   .length = length.n

   for .i to .length
      .sum += .a#[.i]
      .max = if .a#[.i] > .max then .a#[.i] else .max fi
      .min = if .a#[.i] < .min then .a#[.i] else .min fi
   endfor

   .mean = .sum / .length

   variance.a# = .a#
   @variance: .mean, .length
   .variance = variance.return
   .sd = sqrt(.variance)
endproc
