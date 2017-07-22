include ../test/more.proc

@no_plan()

# Paul Boersma, December 10, 2007

### THIS FILE SHOULD NOT BE EDITED IN PRAAT
### IT IS MEANT TO STAY IN MAC ROMAN ENCODING

if !macintosh
  @skip_all: "MacRoman encoding tests only needed on Mac"
else
  Read from file: "åbçéü.wav"
endif

@is: numberOfSelected("Sound"), 1, "Read Sound from file with encoded name"
nocheck Remove

@ok_selection()

@done_testing()
