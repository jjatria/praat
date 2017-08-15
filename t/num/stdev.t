include ../test/more.proc

@no_plan()

for power to 18
	a# = 10 ^ power + { 14.34629189464373, 7.23754354546, 13.645326754, 16.45342671345 }
	if power > 11
		@todo: 1, "rounding error"
	endif
	@is_approx: stdev(a#), 3.972229, 1e-6, "stdev"

	a# = randomGauss# (a#, 1, 10 ^ - power)
	stdev1 = stdev(a#)
	Debug: "no", 48
	stdev2 = stdev(a#)
	Debug: "no", 49
	stdev3 = stdev(a#)
	Debug: "no", 0
	@is_approx: stdev1, stdev2, 1e-15, "plain v. 48"
	@is_approx: stdev1, stdev3, 1e-15, "plain v. 49"
endfor

@done_testing()
