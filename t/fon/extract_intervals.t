include ../test/more.proc

@no_plan()

sound = Create Sound from formula: "sound",
   ... 1, 0, 1, 44100,
   ... "1/2 * sin(2 * pi * 377 * x) + randomGauss(0, 0.1)"

textgrid = To TextGrid: "Mary John bell", "bell"

Insert boundary: 1, 0.5
Insert boundary: 1, 0.7
Set interval text: 1, 1, "a"
Set interval text: 1, 2, "b"
Set interval text: 1, 3, "c"

selectObject: sound, textgrid
Extract all intervals: 1, "no"

@is: numberOfSelected(), 3, "Extracted intervals"
Remove

removeObject: sound, textgrid

@ok_selection()

@done_testing()
