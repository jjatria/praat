﻿echo texio
# Paul Boersma 2015-11-18

tex1 = Read from file... texio/texio1.TextGrid
Write to chronological text file... kanweg.txt
tex2 = Read from file... kanweg.txt
assert objectsAreIdentical (tex1, tex2)
removeObject: tex1, tex2

asserterror Found a number while looking for a string in text (line 10).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/number_for_string.TextGrid"

asserterror Found a number while looking for an enumerated value in text (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/number_for_enumerated.TextGrid"

asserterror Found a string while looking for a real number in text (line 13).
...'newline$'"xmax" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/string_for_number.TextGrid"

asserterror Found a string while looking for an integer in text (line 14).
...'newline$'Signed integer not read from text file.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/string_for_integer.TextGrid"

asserterror Found a string while looking for an enumerated value in text (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/string_for_enumerated.TextGrid"

asserterror Found an enumerated value while looking for a string in text (line 18).
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/enumerated_for_string.TextGrid"

asserterror Found an enumerated value while looking for a real number in text (line 17).
...'newline$'"xmax" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/enumerated_for_real.TextGrid"

asserterror Found an enumerated value while looking for an integer in text (line 14).
...'newline$'Signed integer not read from text file.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/enumerated_for_integer.TextGrid"

asserterror Character x following quote (line 18). End of string or undoubled quote?
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/char_after_quote.TextGrid"

asserterror Early end of text detected while looking for a real number (line 21).
...'newline$'"xmax" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_real_xmax.TextGrid"

asserterror Early end of text detected while looking for an enumerated value (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_enumerated.TextGrid"

asserterror Early end of text detected while looking for an integer (line 14).
...'newline$'Signed integer not read from text file.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_integer.TextGrid"

asserterror Early end of text detected while looking for a string (line 18).
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_string.TextGrid"

asserterror Early end of text detected while looking for a real number (line 18).
...'newline$'"xmin" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_real_xmin.TextGrid"

asserterror Early end of text detected while reading a string (line 18).
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_in_string.TextGrid"

asserterror Early end of text detected while reading an enumerated value (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_in_enumerated.TextGrid"

asserterror No matching '>' while reading an enumerated value (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/unmatched_bracket_in_enumerated.TextGrid"

asserterror Found strange text while reading an enumerated value in text (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/strange_text_in_enumerated.TextGrid"

asserterror "exi" is not a value of the enumerated type.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/not_an_enumerated_value.TextGrid"

if windows
   asserterror Cannot open file “'defaultDirectory$'\texio\missing_file.TextGrid”.
   Read from file: "texio/missing_file.TextGrid"
else
   asserterror Cannot open file “'defaultDirectory$'/texio/missing_file.TextGrid”.
   Read from file: "texio/missing_file.TextGrid"
endif
