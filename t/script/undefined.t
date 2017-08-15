include ../test/more.proc

@no_plan()

#
# Some normal numbers.
#
@isnt: 1 / 2,    undefined, "1 / 2"
@isnt: 0 / 2,    undefined, "0 / 2"
@isnt: sqrt(10), undefined, "sqrt(10)"

#
# Some infinities.
#
@is: 1 / 0,     undefined, "1 / 0"
@is: 1 div 0,   undefined, "1 div 0"
@is: 1 mod 0,   undefined, "1 mod 0"
@is: 10 ^ 500,  undefined, "10 ^ 500"
@is: exp(1000), undefined, "exp(1000)"

#
# Some infinitesimals.
#
@is: 10 ^ -500,  0, "10 ^ -500"
@is: exp(-1000), 0, "exp(-1000)"

#
# Some not-a-numbers.
#
@is: sqrt(-10), undefined, "sqrt(-10)"
@is: 0 / 0,     undefined, "0 / 0"
@is: 0 div 0,   undefined, "0 div 0"
@is: 0 mod 0,   undefined, "0 mod 0"

#
# Propagation.
#
@is: - undefined,           undefined, "- undefined"
@is: undefined - undefined, undefined, "undefined - undefined"
@is: sqrt(undefined),       undefined, "sqrt(  undefined)"
@is: sqrt(- undefined),     undefined, "sqrt(- undefined)"
@is: undefined * 0,         undefined, "undefined * 0"
@is: 0 * undefined,         undefined, "0 * undefined"
@is: 1 / undefined,         undefined, "1 / undefined"
@is: 0 ^ undefined,         undefined, "0 ^ undefined"
@is: undefined ^ undefined, undefined, "undefined ^ undefined"

#
# Propagation within larger expressions.
#
@is: 1 / (1 / 0),   undefined, "1 / (1 / 0)"
@is: 1 / (0 / 0),   undefined, "1 / (0 / 0)"
@is: 1 / exp(1000), undefined, "1 / exp(1000)" ; not the same as exp (-1000)!
@is: 0 ^ (1 / 0),   undefined, "0 ^ (1 / 0)"
@is: 0 * (0 / 0),   undefined, "0 * (0 / 0)"
@is: 0 * (1 / 0),   undefined, "0 * (1 / 0)"

#
# Exception to propagation: anything to the power 0 always gives 1 (as in R).
#
@is: 0 ^ 0,         1,         "0 ^ 0"
@is: undefined ^ 0, undefined, "undefined ^ 0"
@is: sqrt(-1)  ^ 0, undefined, "sqrt(-1)  ^ 0"

@todo: 2, "powers of undefined"
@is: undefined ^ 0, 1, "undefined ^ 0"
@is: sqrt(-1)  ^ 0, 1, "sqrt(-1)  ^ 0"

@done_testing()
