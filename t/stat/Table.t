include ../test/more.proc

@no_plan()

stopwatch
for i to 100000
   d'i' = i
endfor
t = stopwatch
appendInfoLine: "# Assigned 100000 variables: ", fixed$(t, 3), " seconds"

d43789 = Create formant table (Weenink 1985)
name$ = selected$("Table")

stopwatch
for cycle to 300
   for row to 360
            z = Table_'name$'[row, "F0"]
   endfor
endfor
t = stopwatch
@pass: "Table query (object accessor with name): " + fixed$(t, 3) + " seconds"

stopwatch
for cycle to 300
   for row to 360
            z = Object_'d43789'[row, "F0"]
   endfor
endfor
t = stopwatch
@pass: "Table query (object accessor with ID): " + fixed$(t, 3) + " seconds"

stopwatch
for cycle to 300
   for row to 360
      z = object[d43789, row, "F0"]
   endfor
endfor
t = stopwatch
@pass: "Table query (object accessor without interpolation): " + fixed$(t, 3) + " seconds"

stopwatch
for cycle to 300
   for row to 360
      z = Get value: row, "F0"
   endfor
endfor
t = stopwatch
@pass: "Table query (command): " + fixed$(t, 3) + " seconds"

removeObject: d43789

pb1 = Create formant table (Peterson & Barney 1952)
pb2 = Read from file: "pb.Table"
@is_deeply: pb1, pb2, "Peterson & Barney formant table"

removeObject: pb1, pb2

@done_testing()
