include ../test/more.proc

@no_plan()

@diag: "Sound files..."

data_path$ = "data/"
outfile$ = "kanweg.out"

procedure test: .bitness$, .type$, .duration
   .factor = if .bitness$ == "32" then 65536 else
      ...    if .bitness$ == "24" then   256 else
      ...       1 fi fi

   .bitness$ = if .bitness$ != "" then .bitness$ + "-bit " else "" fi

   @diag: "Testing " + .bitness$ + .type$ + " files..."

   for .channels to 8
      .sound = Create Sound from formula: "sound",
         ... .channels, 0, .duration / .channels, 44100,
         ... "1 / 4 * sin(2 * pi * 377 * x) + randomGauss(0, 0.05)"

      Formula: "round (self * 32768 * '.factor') / (32768 * '.factor')"
      .energy1 = Get energy in air

      do("Save as " + .bitness$ + .type$ + " file...", outfile$)

      stopwatch
      .sound2 = Read from file: outfile$
      .t = stopwatch

      .energy2 = Get energy in air
      @is_approx: .energy1, .energy2, 1e-12, string$(.channels) + " channels"

      removeObject: .sound, .sound2
      deleteFile: outfile$
      @diag: "Read '.duration'-second file in " + fixed$(.t, 4) + " seconds"
   endfor
endproc

Debug: "no", 18
@test: "",   "WAV",      3
Debug: "no",  0

@test: "",   "WAV",      3
@test: "",   "AIFF",     3
@test: "",   "AIFC",     3
@test: "",   "Next/Sun", 3
@test: "",   "NIST",     3
@test: "",   "FLAC",     3

Debug: "no", 18
@test: "",   "WAV",     30
Debug: "no",  0

@test: "",   "WAV",     30
@test: "24", "WAV",      3

Debug: "no", 18
@test: "32", "WAV",      3
Debug: "no",  0

@test: "32", "WAV",      3

procedure do ()
   Read from file: data_path$ + "test.wav"
   .wav = Get energy in air
   Remove

   Read from file: data_path$ + "test.flac"
   .flac = Get energy in air
   Remove

   @is_approx: .wav, .flac, 1e-12, "FLAC and WAV energyies are comparable"
endproc

@diag :"Optimized:"
Debug: "no", 0
@do()

@diag: "Portable:"
Debug: "no", 18
@do()
Debug: "no", 0

@ok_selection()

@done_testing()
