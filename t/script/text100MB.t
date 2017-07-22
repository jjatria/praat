# text100MB.praat
# Paul Boersma, 9 November 2008

include ../test/more.proc

@no_plan()

outfile$ = "kanweg.txt"

stopwatch
a$ = "a"
for i to 8
   a$ = a$ + a$ + a$ + a$ + a$ + a$ + a$ + a$ + a$ + a$
endfor
t = stopwatch
@isnt$: a$, "a",
   ... "Creating (" + fixed$(t, 3) + "s)"

stopwatch
writeFile: outfile$, a$
t = stopwatch
@ok_formula: "fileReadable(""kanweg.txt"")",
   ... "Writing (" + fixed$(t, 3) + "s)"

b$ = ""
stopwatch
b$ = readFile$: outfile$
t = stopwatch
@isnt$: b$, "",
   ... "Reading (" + fixed$(t, 3) + "s)"

stopwatch
compare = if a$ == b$ then 1 else 0 fi
t = stopwatch
@ok: compare,
   ... "Comparing (" + fixed$(t, 3) + "s)"

deleteFile: outfile$

@done_testing()
