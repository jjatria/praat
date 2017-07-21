include ../test/more.proc

@no_plan()

@diag: "Stereo formulas"
# Paul Boersma, February 1, 2008

sample = 100
time   = 0.5

sound = Create Sound from formula: "test", "Stereo",
   ... 0, 1.5, 44100, "randomUniform (-1, 1)"

@diag: "Value at sample number"

average = Get value at sample number: "Average", sample
left    = Get value at sample number: "Left",    sample
right   = Get value at sample number: "Right",   sample

value = Sound_test[sample]
@is: value, average, "Object(sample)"

value = object["Sound test", sample]
@is: value, average, "object[name$, sample]"

value = Sound_test[0, sample]
@is: value, average, "Object[0, sample]"

value = object["Sound test", 0, sample]
@is: value, average, "object[name$, 0, sample]"

value = Sound_test[1, sample]
@is: value, left, "Object[1, sample]"

value = object["Sound test", 1, sample]
@is: value, left, "object[name$, 1, sample]"

value = Sound_test[2, sample]
@is: value, right, "Object[2, sample]"

value = object["Sound test", 2, sample]
@is: value, right, "object[name$, 2, sample]"

@diag: "Value at time"

average = Get value at time: "Average", time, "Linear"
left    = Get value at time: "Left",    time, "Linear"
right   = Get value at time: "Right",   time, "Linear"

value = Sound_test(time)
@is: value, average, "Object(time)"

value = object("Sound test", time)
@is: value, average, "object(name$, time)"

value = Sound_test(time, 0)
@is: value, average, "Object(name$, time, 0)"

value = object("Sound test", time, 0)
@is: value, average, "object(name$, time, 0)"

value = Sound_test(time, 1)
@is: value, left, "Object(time, 1)"

value = object("Sound test", time, 1)
@is: value, left, "object(name$, time, 1)"

value = Sound_test(time, 2)
@is: value, right, "Object(time, 2)"

value = object("Sound test", time, 2)
@is: value, right, "object(name$, time, 2)"

Remove

@ok_selection()

@done_testing()
