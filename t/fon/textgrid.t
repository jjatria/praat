include ../test/more.proc

# t/fon/textgrid.praat
# Paul Boersma, 19 November 2013

@no_plan()

textgrid = Create TextGrid: 0, 3, "A B C", ""

@is: do("Get interval at time...", 2, -1), 0, "Interval at negative time"
@is: do("Get interval at time...", 2,  0), 1, "Interval at zero time"
@is: do("Get interval at time...", 2,  1), 1, "Interval at 00:00:01"
@is: do("Get interval at time...", 2,  2), 1, "Interval at 00:00:02"
@is: do("Get interval at time...", 2,  3), 1, "Interval at 00:00:03"
@is: do("Get interval at time...", 2,  4), 0, "Interval out of time"

@is: do("Get low interval at time...", 2, -1), 0, "Low interval at negative time"
@is: do("Get low interval at time...", 2,  0), 0, "Low interval at zero time"
@is: do("Get low interval at time...", 2,  1), 1, "Low interval at 00:00:01"
@is: do("Get low interval at time...", 2,  2), 1, "Low interval at 00:00:02"
@is: do("Get low interval at time...", 2,  3), 1, "Low interval at 00:00:03"
@is: do("Get low interval at time...", 2,  4), 0, "Low interval out of time"

@is: do("Get high interval at time...", 2, -1), 0, "High interval at negative time"
@is: do("Get high interval at time...", 2,  0), 1, "High interval at zero time"
@is: do("Get high interval at time...", 2,  1), 1, "High interval at 00:00:01"
@is: do("Get high interval at time...", 2,  2), 1, "High interval at 00:00:02"
@is: do("Get high interval at time...", 2,  3), 0, "High interval at 00:00:03"
@is: do("Get high interval at time...", 2,  4), 0, "High interval out of time"

@is: do("Get interval edge from time...", 2, -1), 0, "Interval edge at negative time"
@is: do("Get interval edge from time...", 2,  0), 1, "Interval edge at zero time"
@is: do("Get interval edge from time...", 2,  1), 0, "Interval edge at 00:00:01"
@is: do("Get interval edge from time...", 2,  2), 0, "Interval edge at 00:00:02"
@is: do("Get interval edge from time...", 2,  3), 1, "Interval edge at 00:00:03"
@is: do("Get interval edge from time...", 2,  4), 0, "Interval edge out of time"

@is: do("Get interval boundary from time...", 2, -1), 0, "Interval boundary at negative time"
@is: do("Get interval boundary from time...", 2,  0), 0, "Interval boundary at zero time"
@is: do("Get interval boundary from time...", 2,  1), 0, "Interval boundary at 00:00:01"
@is: do("Get interval boundary from time...", 2,  2), 0, "Interval boundary at 00:00:02"
@is: do("Get interval boundary from time...", 2,  3), 0, "Interval boundary at 00:00:03"
@is: do("Get interval boundary from time...", 2,  4), 0, "Interval boundary out of time"

Insert boundary: 2, 1
Insert boundary: 2, 2

@is: do("Get interval at time...", 2, -1), 0, "Interval at negative time"
@is: do("Get interval at time...", 2,  0), 1, "Interval at zero time"
@is: do("Get interval at time...", 2,  1), 2, "Interval at 00:00:01"
@is: do("Get interval at time...", 2,  2), 3, "Interval at 00:00:02"
@is: do("Get interval at time...", 2,  3), 3, "Interval at 00:00:03"
@is: do("Get interval at time...", 2,  4), 0, "Interval out of time"

@is: do("Get low interval at time...", 2, -1), 0, "Low interval at negative time"
@is: do("Get low interval at time...", 2,  0), 0, "Low interval at zero time"
@is: do("Get low interval at time...", 2,  1), 1, "Low interval at 00:00:01"
@is: do("Get low interval at time...", 2,  2), 2, "Low interval at 00:00:02"
@is: do("Get low interval at time...", 2,  3), 3, "Low interval at 00:00:03"
@is: do("Get low interval at time...", 2,  4), 0, "Low interval out of time"

@is: do("Get high interval at time...", 2, -1), 0, "High interval at negative time"
@is: do("Get high interval at time...", 2,  0), 1, "High interval at zero time"
@is: do("Get high interval at time...", 2,  1), 2, "High interval at 00:00:01"
@is: do("Get high interval at time...", 2,  2), 3, "High interval at 00:00:02"
@is: do("Get high interval at time...", 2,  3), 0, "High interval at 00:00:03"
@is: do("Get high interval at time...", 2,  4), 0, "High interval out of time"

@is: do("Get interval edge from time...", 2, -1), 0, "Interval edge at negative time"
@is: do("Get interval edge from time...", 2,  0), 1, "Interval edge at zero time"
@is: do("Get interval edge from time...", 2,  1), 2, "Interval edge at 00:00:01"
@is: do("Get interval edge from time...", 2,  2), 3, "Interval edge at 00:00:02"
@is: do("Get interval edge from time...", 2,  3), 3, "Interval edge at 00:00:03"
@is: do("Get interval edge from time...", 2,  4), 0, "Interval edge out of time"

@is: do("Get interval boundary from time...", 2, -1), 0, "Interval boundary at negative time"
@is: do("Get interval boundary from time...", 2,  0), 0, "Interval boundary at zero time"
@is: do("Get interval boundary from time...", 2,  1), 2, "Interval boundary at 00:00:01"
@is: do("Get interval boundary from time...", 2,  2), 3, "Interval boundary at 00:00:02"
@is: do("Get interval boundary from time...", 2,  3), 0, "Interval boundary at 00:00:03"
@is: do("Get interval boundary from time...", 2,  4), 0, "Interval boundary out of time"

removeObject: textgrid

@ok_selection()

@done_testing()
