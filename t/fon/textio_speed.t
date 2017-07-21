include ../test/more.proc

# textioSpeed.praat
# Paul Boersma, 2015-11-18

@no_plan()

@diag: "Text I/O speed:"

outfile$ = "kanweg.Collection"
total_objects = 10

for i to total_objects
   sound[i] = Create Sound from formula: string$(i), "Mono", 0, 5, 44100, "i"
endfor

selectObject()
for i to total_objects
   plusObject: sound[i]
endfor

stopwatch
Write to text file: outfile$
t = stopwatch

@diag: "Finished writing in 't:3' seconds"
Remove

stopwatch
Read from file: outfile$
t = stopwatch

@diag: "Finished reading in 't:3' seconds"

@is: numberOfSelected(), total_objects, "Recovered all objects from collection"

n = round(total_objects / 2)
id = selected(n)
minusObject: id
Remove
selectObject: id

@is: do("Get mean...", "All", 0, 0), n, "Mean of generated objects"
Remove
deleteFile: outfile$

@ok_selection()

@done_testing()
