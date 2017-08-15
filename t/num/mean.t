include ../test/more.proc

@no_plan()

@diag: "Mean..."

for i from 2 to 100
        a = sum (linear# (1, i,     i,     0))
        b = sum (linear# (1, i - 1, i - 1, 0)) + i
	@is: a, b, "Sum comparison: i = 'i'"
endfor

n  = 1e5+1
n7 = 7 * n
d = 0
;d = 0.23456
d = 0.000547462463

big0 = 1 + d 
sequenceA# = { 1, 2, 3, 4, 5, 6, 7 }
meanA = mean (sequenceA#)
stdevA = stdev (sequenceA#) * sqrt (6 / 7) / sqrt (1 - 1 / n7)
sequenceB# = linear# (1, n, n, 0)
meanB = mean (sequenceB#)
stdevB = stdev (sequenceB#)
sequenceC# = { 0 }
meanC = 0.0
stdevC = 0.0

Debug: "no", 48   ; naive mean
big = big0

limit = 18 - log10(n)
pass = 1

for power to 25
	big *= 10
	a# = repeat# (big + sequenceA#, n)
	mean1 = mean (a#)
	dmean1 = mean1 - big - meanA
	mean2 = a# [1] + mean (- a# [1] + a#)
	dmean2 = mean2 - big - meanA

	mean3 = mean (a#) + mean (- mean1 + a#)
	dmean3 = mean3 - big - meanA

	if    big == round(big) and dmean2 != 0 and power <= limit
		pass = 0
	elsif big == round(big) and dmean3 != 0 and power <= limit
	        pass = 0
	endif
	
	if !pass
		@diag: "ERROR"
	endif
	
	diffSquare1# = (- mean1 + a#) * (- mean1 + a#)
	meanSquare1 = mean (diffSquare1#)
	diffSquare2# = (- mean2 + a#) * (- mean2 + a#)
	meanSquare2 = mean (diffSquare2#)
	diffSquare3# = (- mean3 + a#) * (- mean3 + a#)
	meanSquare3 = mean (diffSquare3#)
	;mean2q = mean2 + mean (- mean2 + diff2#)
	stdev1 = sqrt (meanSquare1 * n7 / (n7 - 1))
	stdev2 = sqrt (meanSquare2 * n7 / (n7 - 1))
	stdev3 = sqrt (meanSquare3 * n7 / (n7 - 1))
	
	@diag: "'power' mean: 'dmean1' 'dmean2' 'dmean3' ; stdev: " +
		... string$(stdev1 - stdevA) + " " +
		... string$(stdev2 - stdevA) + " " +
		... string$(stdev3 - stdevA)
endfor
@ok: pass, "dmean tests"

Debug: "no", 0

debug# = { 48, 49, 50, 51, 52, 0 }
debug$ [1] = "Naive 64-bits"
debug$ [2] = "Naive 80-bits"
debug$ [3] = "First-element offset"
debug$ [4] = "Chan pairwise"
debug$ [5] = "Pairwise base case 8"
debug$ [6] = "Pairwise base case 16"

@diag: newline$ + "OFFSET"
for idebug from 1 to size (debug#)
	@diag: newline$ + debug$[idebug] + newline$
	
	Debug: "no", debug#[idebug]
	big = big0
	for power from 1 to 25
		big *= 10
		a# = repeat# (big + sequenceA#, n)
		b# = big + sequenceB#
		c# = repeat# (big + sequenceC#, n7)
		@diag: "Power: 'power'"
		@diag: "  Sawtooth"
		@diag: "    mean "    + string$(mean (a#) - big - meanA)
		@diag: "    stdev "   + string$(stdev(a#) -       stdevA)
		@diag: "  Line: " 
		@diag: "    mean "    + string$(mean (b#) - big - meanB)
		@diag: "    stdev "   + string$(stdev(b#) -       stdevB)
		@diag: "  Constant: "
		@diag: "    mean "    + string$(mean (c#) - big - meanC)
		@diag: "    stdev "   + string$(stdev(c#) -       stdevC)
	endfor
	Debug: "no", 0
endfor

mean = mean ({ -1e18, 3, 1e18 })
@is: mean, 1, "mean"

mean = mean ({ -1e19, 3, 1e19 })
@is: mean, 1, "mean"

@todo: 1, "Below threshold"
mean = mean ({ -1e20, 3, 1e20 })
@is: mean, 1, "mean"

for power to 16
	a = mean (repeat# (10^power + sequenceA#, n)) - 10^power
	b = mean (sequenceA#)
	@is: a, b, "power: 'power'"
endfor

@diag: newline$ + "TIMING" + newline$
numberOfTrials = 100
stopwatch
for i to numberOfTrials
	b# = a#
endfor
@diag: "Baseline: " + string$(stopwatch / numberOfTrials / n7 * 1e9) + " ns"
for idebug from 1 to size(debug#)
	Debug: "no", debug#[idebug]
	stopwatch
	for i to numberOfTrials
		mean: a#
	endfor
	@diag: debug$[idebug] + " mean: " + string$(stopwatch / numberOfTrials / n7 * 1e9) + " ns"
endfor
for idebug from 1 to size (debug#)
	Debug: "no", debug#[idebug]
	stopwatch
	for i to numberOfTrials
		stdev: a#
	endfor
	@diag: debug$[idebug] + " stdev: " + string$(stopwatch / numberOfTrials / n7 * 1e9) + " ns"
endfor

@diag: newline$ + "ONE PEAK" + newline$
procedure do_single_peak: peakLocation, zeroLocation
	a# = d + repeat# ({ 1e13+1e5 }, 1e6 + 2)
	a# [peakLocation] = d + (-1e19-1e11)
	a# [zeroLocation] = d
	@diag: debug$[idebug] + ": " + string$(mean (a#) - d) + " " + string$(mean (a#) + mean (- mean (a#) + a#) - d)
endproc
for idebug to size(debug#)
	Debug: "no", debug#[idebug]
	@do_single_peak: 1, 2
	@do_single_peak: 2, 1
	@do_single_peak: 2, 3
	@do_single_peak: 1e6+2, 1e6+1
	@do_single_peak: 1e6+1, 1e6+2
endfor

@done_testing()
