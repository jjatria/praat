include ../test/more.proc

@no_plan()

@diag: "FFT speed:"

stopwatch
parent = Create Sound from formula: "sine", mono,
   ... 0, 50, 44100,
   ... "1/2 * sin (2 * pi * 377 * x)"
reference = Get mean: 0, 0, 0

spectrum = To Spectrum: "yes"
child = To Sound
mean = Get mean: 0, 0, 0

t = stopwatch

@diag: "Finished in 't:3' seconds"

@is_approx: mean, reference, 1e-15, "Means of sounds are similar"

removeObject: parent, spectrum, child

@ok_selection()

@done_testing()
