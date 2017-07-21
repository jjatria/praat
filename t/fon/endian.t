include ../test/more.proc

@no_plan()

file_root$ = "test"
outfile$ = file_root$ + ".out"
sampling_frequency = 22050

procedure test_format: .format$
   do("Write to '.format$' file...", outfile$)
   Remove
   Read from file: outfile$
   .energy = Get energy in air
   @is: .energy, test.reference, "Correct energy from " + .format$
endproc

procedure test ()
   .reference = 0.00008397361

   .sound = Read from file: file_root$ + ".wav"
   .energy = Get energy in air
   @is_approx: .energy, .reference, 1e-11,
      ... "Correct energy from WAV (source)"
   removeObject: .sound
   .reference = .energy

   .sound = Read from file: file_root$ + ".Sound"
   .energy = Get energy in air
   @is: .energy, .reference, "Correct energy from text file"

   selectObject: .sound
   @test_format: "WAV"
   @test_format: "AIFF"
   @test_format: "FLAC"
   @test_format: "binary"
   .sound = selected()

   # Sesam files require the SDF extension
   .sdf_file$ = outfile$ + ".sdf"
   Write to Sesam file: .sdf_file$
   removeObject: .sound
   .sound = Read from file: .sdf_file$
   .reference = Get energy in air

   Write to Sesam file: .sdf_file$
   removeObject: .sound
   .sound = Read from file: .sdf_file$
   .energy = Get energy in air
   @is: .energy, .reference, "Sesam"
   deleteFile: .sdf_file$

   removeObject: .sound

   @diag: "Sound writing speed tests (s)"
   Create Sound: file_root$,
      ... 0, 100, sampling_frequency, "0.1 * randomGauss(0, 1)"
   @diag: "'tab$''tab$'WAV'tab$'AIFF'tab$'Binary'tab$'FLAC"
   for .i to 2
      stopwatch
      Write to WAV file: outfile$
      t1 = stopwatch

      stopwatch
      Write to AIFF file: outfile$
      t2 = stopwatch

      stopwatch
      Write to binary file: outfile$
      t3 = stopwatch

      stopwatch
      Write to FLAC file: outfile$
      t4 = stopwatch

      @diag: if .i == 1 then "First " else "Second" fi +
         ... " run:'tab$''t1:2''tab$''t2:2''tab$''t3:2''tab$''t4:2'"
   endfor
   Remove

   .formula$ = "exp(-x * 1000)"
   Create Sound: file_root$,
      ... 0, 1, sampling_frequency, .formula$
   @null_test: .formula$, "Get energy in air"

   .formula$ = "exp(x * 1000)"
   Create Sound: file_root$,
      ... 0, 1, sampling_frequency, .formula$
   @null_test: .formula$, "Get energy in air"

   .formula$ = "exp(-col / 22.05)"
   Create TableOfReal: file_root$, 1, sampling_frequency
   Formula: .formula$
   @null_test: .formula$, "Get table norm"

   .formula$ = "exp(col / 22.05)"
   Create TableOfReal: file_root$, 1, sampling_frequency
   Formula: .formula$
   @null_test: .formula$, "Get table norm"
endproc

procedure null_test: .msg$, .query$
   .source = selected()
   .filename$ = file_root$ + ".obj"
   Write to binary file: .filename$
   .target = Read from file: .filename$
   .name$ = replace$(selected$(), " ", "_", 0)
   Formula: "(self = " + .name$ + " []) - 1"
   .norm = do(.query$)
   @is: .norm, 0, .msg$
   removeObject: .source, .target
   deleteFile: .filename$
endproc

@diag: "Optimized:"
Debug: "no", 0
@test()

@diag: "Portable:"
Debug: "no", 18
@test()
Debug: "no", 0

deleteFile: outfile$

@ok_selection()

@done_testing()
