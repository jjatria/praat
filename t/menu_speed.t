include test/more.proc

@plan: 1

@diag: "Output of this test is solely for human consumption"

iterations = 1000000

sound = Create Sound as pure tone: "tone",
	... 1, 0, 0.4, 44100, 440, 0.2, 0.01, 0.01

stopwatch
for i to iterations
	x = i
endfor
t1 = stopwatch

stopwatch
for i to iterations
	x = Get duration
endfor
t2 = stopwatch

@diag: "After 'iterations' iterations..."
@diag: "Assignments:   't1:3' seconds"
@diag: "Menu commands: 't2:3' seconds"

removeObject: sound

@ok_selection()

@done_testing()
