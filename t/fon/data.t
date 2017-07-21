include ../test/more.proc

# data.praat
# Paul Boersma, 22 January 2009
# Checks Copy, Equal, Read, Save.
# 10 October 2012
# 9 January 2014

@no_plan()

tracing$ = "no"
current_object = undefined
test_filename$ = "kanweg.Object"

@diag: "Data test"
stopwatch

@diag: "Sound"
synth =  Create SpeechSynthesizer: "English", "default"
sound = To Sound: "This is a test", "no"
@test: current_object
removeObject: synth

@diag: "Pitch"
selectObject: sound
pitch = To Pitch: 0, 75, 600
@test: current_object

@diag: "Formant"
selectObject: sound
formant = To Formant (burg): 0, 5, 5000, 0.025, 50
@test: current_object

@diag: "PointProcess"
selectObject: sound, pitch
pulses = To PointProcess (cc)
@test: current_object

@diag: "PitchTier"
pitchTier = To PitchTier: 0.02
@test: current_object

@diag: "Manipulation"
selectObject: sound
manipulation = To Manipulation: 0.01, 75, 600
@test: current_object

@diag: "Matrix"
matrix = Create simple Matrix: "xy2", 10, 20, "x*y^2"
@test: current_object

Save as matrix text file: test_filename$
matrix2 = Read from file: test_filename$
@is_deeply: matrix, matrix2, "Read Matrix from text file"
removeObject: matrix2

selectObject: matrix
Save as headerless spreadsheet file: test_filename$
matrix2 = Read Matrix from raw text file: test_filename$
@is_deeply: matrix, matrix2, "Read Matrix from headerless spreadsheet file"
removeObject: matrix2

@diag: "Speaker"
speaker = Create Speaker: "man", "male", "2"
@test: current_object

@diag: "OTGrammar"
grammar = Create metrics grammar:
   ... "equal", "FtNonfinal", "no", "no", "no", "Nonfinal", "yes", "no", "no"
@test: current_object

@diag: "Table"
table = Create formant table (Peterson & Barney 1952)
@test: current_object

selectObject: table
Save as tab-separated file: test_filename$
table2 = Read Table from tab-separated file: test_filename$
@is_deeply: table, table2, "Read Table from tab-separated file"
removeObject: table2

selectObject: table
Save as comma-separated file: test_filename$
table2 = Read Table from comma-separated file: test_filename$
@is_deeply: table, table2, "Read Table from comma-separated file"
removeObject: table2

@diag: "TableOfReal"
tableOfReal = Create TableOfReal (Pols 1973): "no"
@test: current_object
Save as headerless spreadsheet file: test_filename$
tableOfReal2 = Read TableOfReal from headerless spreadsheet file: test_filename$
@is_deeply: tableOfReal, tableOfReal2,
   ... "Read TableOfReal from headerless spreadsheet file"
removeObject: tableOfReal2

@diag: "FFNet"
Create iris example: 0, 0
ffnet = selected: "FFNet"
pattern = selected: "Pattern"
categories = selected: "Categories"
@test: ffnet
@test: pattern
@test: categories

@diag: "KNN"
selectObject: pattern, categories
knn = To KNN Classifier: "Classifier", "random"
@test: current_object

@diag: "Discriminant"
selectObject: pattern, categories
discriminant = To Discriminant
@test: current_object

@diag: "TextGrid"
textgrid = Create TextGrid: 0, 1, "tier", ""
Set interval text: 1, 1, "hup åçé pořád 𝄐𝄑 𐌀𐌁𐌂"
@test: current_object

procedure select_all ( )
   selectObject()
   for .i to test.n
      plusObject: test.id[.i]
   endfor
endproc

procedure test_collection()
   Read from file: test_filename$
   .n = numberOfSelected()
   for .i to .n
      .obj[.i] = selected(.i)
   endfor

   for .i to .n
      .test_object = .obj[.i]
      selectObject: .test_object
      .test_type$  = extractWord$(selected$(), "")
      .ref_object  = test.type[.test_type$]
      @is_deeply: .test_object, .ref_object,
         ... .test_type$ + " object from Collection is identical"
      removeObject: .test_object
   endfor
endproc

@diag: "Versbose text Collection"
@select_all()
Save as text file: test_filename$
@test_collection()

@diag: "Concise text Collection"
@select_all()
Save as short text file: test_filename$
@test_collection()

@diag: "Binary Collection"
@select_all()
Save as binary file: test_filename$
@test_collection()

@select_all()
Remove

deleteFile: test_filename$

t = stopwatch
@diag: "Test took 't:3' seconds"

procedure test: .object1
   if !variableExists("test.n")
      .n = 0
   endif

   if .object1 == undefined
      .object1 = selected()
   endif

   selectObject: .object1
   .type$ = extractWord$(selected$(), "")
   .object2 = Copy: "kanweg2"
   @is_deeply: .object1, .object2,
      ... "Copy of " + .type$ + " is identical"
   removeObject: .object2

   # Test verbose text writing (for correct data).
   selectObject: .object1
   Save as text file: test_filename$
   .object2 = Read from file: test_filename$
   @is_deeply: .object1, .object2,
      ... "Verbose text read/write of " + .type$ + " is identical"
   removeObject: .object2

   # Test concise text writing (for correct data).
   selectObject: .object1
   Save as short text file: test_filename$
   .object2 = Read from file: test_filename$
   @is_deeply: .object1, .object2,
      ... "Concise text read/write of " + .type$ + " is identical"
   removeObject: .object2

   # Test binary I/O
   selectObject: .object1
   Debug: tracing$, 18
   Save as binary file: test_filename$
   .object2 = Read from file: test_filename$
   Debug: tracing$, 0
   @is_deeply: .object1, .object2,
      ... "Binary read/write of " + .type$ + " is identical"
   removeObject: .object2

   .type[.type$] = .object1
   .n += 1
   .id[.n]       = .object1

   # Good neighbour.
   selectObject: .object1
endproc

@ok_selection()

@done_testing()