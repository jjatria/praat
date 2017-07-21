include ../test/more.proc

@no_plan()

#! Praat test script min.praat
# Paul Boersma, July 26, 2003

@diag: "min"

@is: min (5, 6),                 5,   "min with integers"
@is: min (-7.8),                -7.8, "min with negative"
@is: min (3, 4, 5, 7, 2, 10),    2,   "min in middle"
@is: min (3, 4, 5, 7, 12, 10),   3,   "min at start"
@is: min (3, 4, 5, 7, 12, 1),    1,   "min at end"

@is: imin (5, 6),                1,   "imin with integers"
@is: imin (-7.8),                1,   "imin with negative"
@is: imin (3, 4, 5, 7, 2, 10),   5,   "imin in middle"
@is: imin (3, 4, 5, 7, 12, 10),  1,   "imin at start"
@is: imin (3, 4, 5, 7, 12, 1),   6,   "imin at end"

@is: max (5, 6),                 6,   "max with integers"
@is: max (-7.8),                -7.8, "max with negative"
@is: max (3, 4, 5, 7, 2, 10),   10,   "max at end"
@is: max (3, 4, 5, 7, 12, 10),  12,   "max in middle"
@is: max (13, 4, 5, 7, 12, 10), 13,   "max at start"

@is: imax (5, 6),                2,   "imax with integers"
@is: imax (-7.8),                1,   "imax with negative"
@is: imax (3, 4, 5, 7, 2, 10),   6,   "imax at end"
@is: imax (3, 4, 5, 7, 12, 10),  5,   "imax in middle"
@is: imax (13, 4, 5, 7, 12, 10), 1,   "imax at start"

@is:  min (undefined, 3), undefined, " min with undefined at start"
@is: imin (undefined, 3), undefined, "imin with undefined at start"
@is:  max (undefined, 3), undefined, " max with undefined at start"
@is: imax (undefined, 3), undefined, "imax with undefined at start"

@is:  min (3, undefined), undefined, " min with undefined at end"
@is: imin (3, undefined), undefined, "imin with undefined at end"
@is:  max (3, undefined), undefined, " max with undefined at end"
@is: imax (3, undefined), undefined, "imax with undefined at end"

@done_testing()
