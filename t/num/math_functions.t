include ../test/more.proc

@no_plan()

@diag: "sqrt"
# Paul Boersma, July 6, 2003
@is: sqrt (-100),        undefined, "sqrt(-100)"
@is: sqrt (0),           0,         "sqrt(0)"
@is: sqrt (1),           1,         "sqrt(1)"
@is: sqrt (4),           2,         "sqrt(4)"
@is: sqrt (9),           3,         "sqrt(9)"
@is: sqrt (123456789^2), 123456789, "sqrt(123456789) ^ 2"
@is_approx: sqrt (2) ^ 2, 2, 1e-15, "sqrt(2) ^ 2"

@diag: "exp"
# Paul Boersma, September 13, 2015
@is: exp (-10000), 0, "exp(-10000)"
@is: exp (0), 1, "exp(0)"
@is_approx: exp (1), e, 1e-15, "exp(1)"
@is_approx: 1, exp (100) / e ^   100,  1e-13, "exp (100) / e ^   100"
@is_approx: 1, exp (100) * exp (-100), 1e-15, "exp (100) * exp (-100)"
@is_approx: 1, e ^  100  * e ^  -100,  1e-14, "e ^  100  * e ^  -100"

@diag: "pow"
# Paul Boersma, August 27, 2003
@is: 0^7, 0, "0^7"
@is: 7^0, 1, "7^0"
@is: 0^0, 1, "special choice"

@diag: "ln"
# Paul Boersma, July 6, 2003
@is: ln (-100), undefined, "ln(-100)"
@is: ln (0),    undefined, "ln(0)"
@is: ln (1),    0,         "ln(1)"
for n from -2 to 2
   n$ = "1e'n'"
   x = number(n$)
   @is_approx: ln (exp (x)), x,    1e-13, "ln(exp('n$'))"
endfor

@diag: "lnGamma"
# Paul Boersma, July 13, 2003
@is: lnGamma (-100), undefined, "lnGamma(-100)"
@is: lnGamma (0),    undefined, "lnGamma(0)"
@is: lnGamma (1),    0,         "lnGamma(1)"
@is_approx: lnGamma (e^-100), 100, 1e-13, "lnGamma (e^-100)"
@is_approx: e^lnGamma(4),       6, 1e-13, "e^lnGamma(4)"
@is_approx: exp(lnGamma(4)),    6, 1e-13, "exp(lnGamma(4))"
factorial = 1
for i to 170
   factorial *= i
   @is_approx: 1, e^lnGamma(i + 1) / factorial, 1e-12,
      ... "e^lnGamma('i' + 1) / 'factorial'"
endfor
for i from -100 to 2
   x = 1.23456789 * 10^i
   gamma = exp (lnGamma (x))
   gamma2 = exp (lnGamma (x + 1))
   gamma3 = x * gamma
   @is_approx: 1, gamma2 / gamma3, 1e-13,
      ... "'gamma2' / 'gamma3'"
endfor

@done_testing()
