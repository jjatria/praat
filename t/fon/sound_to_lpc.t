include ../test/more.proc

@no_plan()

# t/fon/sound_to_lpc.praat
# Paul Boersma, 22 November 2011

for i to 30
   duration = randomUniform (0.001, 0.003)
   window_duration = randomUniform (0.002, 0.005)
   sampling_frequency = randomUniform (16000, 96000)

   .sound = Create Sound from formula: "test", 1, 0,
      ... duration, sampling_frequency,
      ... "1 / 2 * sin(2 * pi * 377 * x) + randomGauss(0, 0.1)"
   .lpc = noprogress To LPC (burg): 16, window_duration, 0.005, 50

   @pass: "'duration:3'-second sound " +
      ... "at 'sampling_frequency' s/s " +
      ... "and 'window_duration:3'-second window"
   removeObject: .lpc, .sound
endfor

@ok_selection()

@done_testing()
