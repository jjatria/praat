# fisherQ
# Paul Boersma, August 27, 2003
# April 7, 2008: more accuracy in fisherQ because of GSL (n.b. GSL not to be used in invFisherQ)
# Computes a significance from zero, given a measured F value.

include ../test/more.proc

@no_plan()

df1 = 2
df2 = 70
f = 33.59
fisherQ = fisherQ (f, df1, df2)
fisherQ$ = fixed$ (fisherQ, 20)

@diag: "fisherQ test: 'fisherQ' 'fisherQ$'"
@is$: fisherQ$, "0.00000000005932714540", "fisherQ initial test"

pass = 1
@diag: "Test for definedness of fisherQ"
for i to 10000
   random = randomUniform(3, 4)
   if fisherQ (random, 1, 100000) == undefined
      @diag: "fisherQ ('random', 1, 100000) == undefined"
      pass = 0
   endif
endfor
@ok: pass, "fisherQ does not return undefined"

@diag: "invFisherQ"

@test_fisherQ: 2, 70, 1e-14
@test_fisherQ: 70, 2, 1e-14
@test_fisherQ: 1, if windows then 100 else 100000 fi, 1e-11

if not windows
	@test_fisherQ: 1, 1, 1e-14
	@test_fisherQ: 100000, 1, 1e-11
endif

@test_fisherQ: 100, 100, 1e-9

procedure test_fisherQ: .df1, .df2, .precision
   # Known values.
   @is: invFisherQ (0, .df1, .df2), undefined, "invFisherQ of 0 is undefined"
   @is: invFisherQ (1, .df1, .df2), 0, "invFisherQ of 1 is 0"

   .pass = 1
   for .i to 1000
      if abs (fisherQ (
         ... 	invFisherQ (.i / 1000, .df1, .df2),
         ... .df1, .df2) - .i / 1000) >= .precision
         @diag: "Failed with i='.i' df1='.df1' df2='.df2'"
         .pass = 0
      endif
   endfor
   @ok: .pass, "We should be able to draw a curve of invFisherQ."

   @diag: "Q near 0, i.e. F large: relative precision"

   .start = 4
   .end = if windows then 147 else 150 fi
   @range_test: .start, .end, .precision * 10, 0

   .start = .end + 1
   .end = 307
   @range_test: .start, .end, .precision * 300, 1

   # Q near 1, i.e. F near zero
   .num$ = "0.999"
   .pass = 1
   for .x to 6
      .num$ = .num$ + "9"
      .q = invFisherQ (number(.num$), .df1, .df2)
      .f =    fisherQ (.q,            .df1, .df2)

      @round_trip: number(.num$), .df1, .df2, .precision
  endfor
  @ok: .pass, "Q near 1, i.e. F near zero"

   @diag: "The inverse relationship: q values from"
   @diag: "measured f values should map back to those f values."
   .pass = 1
   for .power to 100
      .f = 10 ^ -.power
      .q = fisherQ (.f, .df1, .df2)

      if !(.q == 1 or abs (invFisherQ (.q, .df1, .df2) - .f) < .precision)
         @diag: "Round-trip did not pass threshold: f='.f', df1='.df1', df2='.df2'"
         pass = 0
      endif
   endfor
   @ok: .pass, "Test in range 10^-1 .. 10^-100"

   .pass = 1
   for .f from 10 to 99
      .x = .f / 100
      .q = fisherQ (.x, .df1, .df2)

      if !(.q > (1 - .precision) or
         ... abs (invFisherQ (.q, .df1, .df2) - .x) < .precision)

         @diag: "1) Round trip did not pass threshold: f='.x', df1='.df1', df2='.df2'"
         .pass = 0
      endif

      @round_trip: .f / 10, .df1, .df2, .precision * .f / 10
      @round_trip: .f,      .df1, .df2, .precision * .f
      @round_trip: 10 * .f, .df1, .df2, .precision * .f * 10

      .q = fisherQ (100 * .f, .df1, .df2)
      if !(.q != 0 or
         ... abs (invFisherQ (.q, .df1, .df2) - 100 * .f)
         ...    < 100 * .f * .precision)

         @diag: "2) Round trip did not pass threshold: f='.f', df1='.df1', df2='.df2'"
      endif

      .q = fisherQ (1000 * .f, .df1, .df2)
      if !(.q == 0 or
         ... abs (invFisherQ (.q, .df1, .df2) - 1000 * .f)
         ...    < 1000 * .f * .precision)

         @diag: "3) Round trip did not pass threshold: f='.f', df1='.df1', df2='.df2'"
      endif

   endfor
   @ok: .pass, "Test round trips in 10 .. 99 range"
endproc

procedure round_trip: .x, .df1, .df2, .precision
   .q =    fisherQ (.x, .df1, .df2)
   .f = invFisherQ (.q, .df1, .df2)

   if abs(.f - .x) >= .precision
      @diag: "Round trip did not pass threshold: f='.x', df1='.df1', df2='.df2'"
      test_fisherQ.pass = 0
   endif
endproc

procedure range_test: .start, .end, .precision, .undefined_ok
   .df1 = test_fisherQ.df1
   .df2 = test_fisherQ.df2

   test_fisherQ.pass = 1
   .undefined = 0
   for .power from .start to .end
      .q = 10 ^ -.power
      .f = invFisherQ (.q, .df1, .df2)

      if .f == undefined
         @diag: "invFisherQ ('.q', '.df1', '.df2') returned undefined"
         .undefined = 1
      elsif abs (fisherQ (.f, .df1, .df2) - .q) >= .q * .precision
         @diag: "Round-trip did not pass threshold: f='.f', df1='.df1', df2='.df2'"
         test_fisherQ.pass = 0
      endif
   endfor

   if !.undefined_ok and .undefined
      test_fisherQ.pass = 0
   endif

   @ok: test_fisherQ.pass, "Test in range '.start' .. '.end'"
endproc

@diag: "Regression tests"
@isnt: invFisherQ (0.13, 1, 1e9), undefined, "used to exceed 60 iterations"
@isnt: invFisherQ (0.159, 2, 70), undefined, "used to exceed 60 iterations"

#
# Things that still go wrong.
#
@todo: 1, ""
@is: fisherQ (1, 1e19, 1e19), undefined, ""

@diag: "Check that we invert better than GSL does"
Debug: "no", 29 ; set invFisherQ to GSL

.f = invFisherQ (0.01, 1, 10000)   ; not such an unusual case

msg$ = "Using invFisherQ from GSL"
if .f != undefined or abs(.f - 6.63743) < 1e-5
   @fail: msg$
   @diag: "        got: '.f'"
   @diag: "   expected: nan or 6.63743 +- 1e05"
else
   @pass: msg$
endif

Debug: "no", 0   ; use our corrected NUMridders again
.f = invFisherQ (0.01, 1, 10000)   ; same case
@is_approx: .f, 6.63743, 1e-5, "Using our corrected NUMridders"

@done_testing()
