include ../test/more.proc

# Paul Boersma 2015-11-18

@plan: 22

tex1 = Read from file: "texio/good.TextGrid"
Write to chronological text file: "kanweg.txt"
tex2 = Read from file: "kanweg.txt"
@is_deeply: tex1, tex2, "Text file and chronological are identical"
removeObject: tex1, tex2

procedure test: .msg$
  @is: numberOfSelected(), 0, .msg$
endproc

asserterror Found a number while looking for a string in text (line 10).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/number_for_string.TextGrid"
@test: "Number while looking for string"

asserterror Found a number while looking for an enumerated value in text (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/number_for_enumerated.TextGrid"
@test: "Number while looking for enumerated value"

asserterror Found a string while looking for a real number in text (line 13).
...'newline$'"xmax" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/string_for_number.TextGrid"
@test: "String while looking for real number"

asserterror Found a string while looking for an integer in text (line 14).
...'newline$'Signed integer not read from text file.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/string_for_integer.TextGrid"
@test: "String while looking for integer"

asserterror Found a string while looking for an enumerated value in text (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/string_for_enumerated.TextGrid"
@test: "String while looking for enumerated_value"

asserterror Found an enumerated value while looking for a string in text (line 18).
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/enumerated_for_string.TextGrid"
@test: "Enumerated value while looking for string"

asserterror Found an enumerated value while looking for a real number in text (line 17).
...'newline$'"xmax" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/enumerated_for_real.TextGrid"
@test: "Enumerated value while looking for real number"

asserterror Found an enumerated value while looking for an integer in text (line 14).
...'newline$'Signed integer not read from text file.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/enumerated_for_integer.TextGrid"
@test: "Enumerated value while looking for integer"

asserterror Character x following quote (line 18). End of string or undoubled quote?
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/char_after_quote.TextGrid"
@test: "Character following quote"

asserterror Early end of text detected while looking for a real number (line 21).
...'newline$'"xmax" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_real_xmax.TextGrid"
@test: "Early end of text while looking for real number"

asserterror Early end of text detected while looking for an enumerated value (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_enumerated.TextGrid"
@test: "Early end of text while looking for enumerated value"

asserterror Early end of text detected while looking for an integer (line 14).
...'newline$'Signed integer not read from text file.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_integer.TextGrid"
@test: "Early end of text while looking for integer"

asserterror Early end of text detected while looking for a string (line 18).
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_string.TextGrid"
@test: "Early end of text while looking for string"

asserterror Early end of text detected while looking for a real number (line 18).
...'newline$'"xmin" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_for_real_xmin.TextGrid"
@test: "Early end of text while looking for real number"

asserterror Early end of text detected while reading a string (line 18).
...'newline$'String "text" not read.
...'newline$'IntervalTier not read.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_in_string.TextGrid"
@test: "Early end of text while reading string"

asserterror Early end of text detected while reading an enumerated value (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/early_end_in_enumerated.TextGrid"
@test: "Early end of text while reading enumerated value"

asserterror No matching '>' while reading an enumerated value (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/unmatched_bracket_in_enumerated.TextGrid"
@test: "Unmatched "">"" while reading enumerated value"

asserterror Found strange text while reading an enumerated value in text (line 6).
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/strange_text_in_enumerated.TextGrid"
@test: "Strange text while reading enumerated value"

asserterror "exi" is not a value of the enumerated type.
...'newline$'TextGrid not read.
...'newline$'Data not read from text file
Read from file: "texio/not_an_enumerated_value.TextGrid"
@test: "Not a value of enumerated type"

if windows
   asserterror Cannot open file “'defaultDirectory$'\texio\missing_file.TextGrid”.
   Read from file: "texio/missing_file.TextGrid"
else
   asserterror Cannot open file “'defaultDirectory$'/texio/missing_file.TextGrid”.
   Read from file: "texio/missing_file.TextGrid"
endif
@pass: "Missing file"

@ok_selection()

@done_testing()
