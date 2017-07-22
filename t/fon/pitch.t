include ../test/more.proc

# pitch.praat
# Paul Boersma, December 10, 2007
# Tests "Sound: To Pitch..."

@no_plan()

@diag: "Pitch test"

method$ = "cc"

for freq from 76.1 to 106
   @sine_test: freq, 0.1
endfor

for freq from 106.1 to 226
   @sine_test: freq, 0.01
endfor

for i from 2 to 20
   @sine_test: i * 100 + 77, 0.02
endfor

for i from 21 to 29
   @sine_test: i * 100 + 77, 0.1
endfor

for i from 30 to 35
   @sine_test: i * 100 + 77, 1.0
endfor

for i from 36 to 60
   @sine_test: i * 100 + 77, 5.0
endfor

for i from 61 to 107
   @sine_test: i * 100 + 77, 10.0
endfor

for i from 1080 to 1095
   @sine_test: i * 10 - 0.1, 10.0
endfor

for freq from 76.1 to 136
   @pulse_test: freq, 0.1
endfor

for freq from 136.1 to 226
   @pulse_test: freq, 0.2
endfor

for i from 2 to 13
   @pulse_test: i * 100 + 77, 1
endfor

for i from 14 to 20
   @pulse_test: i * 100 + 77, 2
endfor

for i from 210 to 219
   @pulse_test: i * 10 + 77, 10
endfor

for i from 22 to 30
   @pulse_test: i * 100 + 77, 2
endfor

for i from 31 to 53
   @pulse_test: i * 100 + 77, 5
endfor
@pulse_test: 219, 1
@pulse_test: 220, 1

method$ = "ac"

for freq from 75.1 to 106
   @sine_test: freq, 0.1
endfor

for freq from 106.1 to 226
   @sine_test: freq, 0.01
endfor

for i from 2 to 105
   @sine_test: i * 100 + 77, 0.02
endfor

for i from 106 to 107
   @sine_test: i * 100 + 77, 0.1
endfor

for i from 1080 to 1095
   @sine_test: i * 10 - 0.1, 0.3
endfor

for freq from 75.1 to 226
   @pulse_test: freq, 0.03
endfor

for i from 2 to 20
   @pulse_test: i * 100 + 77, 1
endfor

for i from 210 to 219
   @pulse_test: i * 10 + 77, 4
endfor

for i from 22 to 53
   @pulse_test: i * 100 + 77, 1
endfor
@pulse_test: 219, 1
@pulse_test: 220, 1
# Tests above 5512.5 Hz are superfluous,
# since pulses are no different from since waves then.

@ok_selection()

@done_testing()

procedure sine_test: .pitch, .precision
   .id = Create Sound: "sound", 0, 1, 22050, "sin(2 * pi * sine_test.pitch * x)"
   @analyse: .pitch, .precision
   removeObject: .id
endproc

procedure pulse_test: .pitch, .precision
   .tier = Create PitchTier: "sound", 0, 1
   Add point: 0.5, .pitch
   .sound = To Sound (pulse train): 22050, 1, 1e-9, 2000, "no"
   @analyse: .pitch, .precision
   removeObject: .sound, .tier
endproc

procedure analyse: .pitch, .precision
   .id = noprogress do("To Pitch (" + method$ + ")...",
      ... 0.09457464735, 75, 15, "no", 0.03,
      ... 0.45, 0.03, 0.35, 0.14, 11025)
   .min = Get minimum: 0, 0, "Hertz", "None"
   .max = Get maximum: 0, 0, "Hertz", "None"
   removeObject: .id

   .diff1 = .min - .pitch
   .diff2 = .max - .pitch

   .abs_diff = max(abs(.diff1), abs(.diff2))

   @cmp_ok: .abs_diff, "<", .precision, "'.pitch' '.min' '.max'"
endproc
