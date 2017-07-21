include ../test/more.proc

# Discriminant.praat
# Paul Boersma 2016-01-01

@no_plan()

#
# This test follows the Praat manual page on "Discriminant analysis"
#
@diag: "test discriminant analysis"

table = Create TableOfReal (Pols 1973): "no"
Formula: "if col <= 3 then log10 (self) else self fi"
Standardize columns
Set column label (index): 1, "standardized log (%F__1_)"
Set column label (index): 2, "standardized log (%F__2_)"
Set column label (index): 3, "standardized log (%F__3_)"

Select outer viewport: 0.0, 5.0, 0.0, 5.0
Draw scatter plot: 1, 2, 0, 0, -2.9, 2.9, -2.9, 2.9, 10, "yes", "+", "yes"

discriminant = To Discriminant

if !macintosh
   @skip: 2, "Test only required on Mac"
endif

test = Read from file: "Pols.text.Discriminant"
@is_deeply: test, discriminant, "Identical to text object"
Remove

test = Read from file: "Pols.binary.Discriminant"
@is_deeply: test, discriminant, "Identical to binary object"
Remove

selectObject: discriminant, table
configuration = To Configuration: 0
Draw: 1, 2, -2.9, 2.9, -2.9, 2.9, 12, "yes", "+", "yes"

removeObject: table, discriminant, configuration

@ok_selection()

@done_testing()
