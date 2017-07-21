include ../test/more.proc

# fourier.praat
# Paul Boersma, May 9, 2004
# Checks "Sound: To Spectrum..."

@no_plan()

@diag: "Fourier test"
@diag: "Low sampling frequencies:"

for i to 50
   @test: 1, i
endfor

@diag: "Random sampling frequencies:"
@test: 1, 22049
@test: 1, 22050

for i to 48
   duration = randomUniform (0.2, 3.0)
   sampling_frequency = randomInteger (10, 10000)
   @test: duration, sampling_frequency
endfor

@ok_selection()

@done_testing()

procedure test: .duration, .frequency
   .base = Create Sound: "sound", 0, .duration, .frequency, "randomGauss(0, 1)"
   .reference = Get energy: 0, 0

   .spectrum = To Spectrum (fft)
   Rename: "fft"
   .energy = Get band energy: 0, 0

   @is_approx: .energy, .reference, 1e-6, "d='.duration' f='.frequency'"

   selectObject: .spectrum
   .sound = To Sound (fft)
   .energy = Get energy: 0, 0

   @is_approx: .energy, .reference, 1e-6, "d='.duration' f='.frequency'"

   Formula: "self - Sound_sound [ ]"
   .extremum = Get absolute extremum: 0, 0, "None"

   @cmp_ok: .extremum, "<", 1e-6, "d='.duration' f='.frequency'"

   removeObject: .sound, .spectrum

   selectObject: .base
   .spectrum = To Spectrum (dft)
   Rename: "dft"
   .energy = Get band energy: 0, 0

   @is_approx: .energy, .reference, 1e-6, "d='.duration' f='.frequency'"

   .sound = To Sound (fft)
   .energy = Get energy: 0, 0

   @is_approx: .energy, .reference, 1e-6, "d='.duration' f='.frequency'"

   Formula: "self - Sound_sound [ ]"
   .extremum = Get absolute extremum... 0 0 None

   @cmp_ok: .extremum, "<", 1e-4, "d='.duration' f='.frequency'"
   removeObject: .spectrum, .sound, .base
endproc
