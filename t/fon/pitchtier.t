include ../test/more.proc

# PitchTier.praat
# Paul Boersma 2015-12-21

@no_plan()

@diag: "PitchTier test"

tier = Create PitchTier: "tier", -1.0, 1.8
Add point: 0.5, 150.0
Add point: 0.6, 178.0
Add point: 0.6, 180.0   ; shouldn't do anything
Add point: 0.3, 200.0   ; should be inserted as the first point

@diag: "Check time domain."

@is: do("Get starting time"),   -1.0, "Starting time"
@is: do("Get end time"),         1.8, "End time"
@is: do("Get duration"),         2.8, "Duration"

n = Get number of points
@is: n, 3,   "Number of points"

@diag: "Check values and sorting."
for i to n
   time[i]  = Get time from index: i
   pitch[i] = Get value at index:  i
endfor

@is: time[1],  0.3, "Time of point 1"
@is: time[2],  0.5, "Time of point 2"
@is: time[3],  0.6, "Time of point 3"
@is: pitch[1], 200, "Value of point 1"
@is: pitch[2], 150, "Value of point 2"
@is: pitch[3], 178, "Value of point 3"

removeObject: tier

@ok_selection()

@done_testing()
