include ../test/more.proc

# test/fon/FormantGrid.praat
# Paul Boersma, 18 September 2011

@no_plan()

Create FormantGrid: "schwa", 0, 1, 10, 550, 1100, 60, 50
Formula (frequencies): "self + 200"
Remove

@pass: "Called FormantGrid commands"

@ok_selection()

@done_testing()
