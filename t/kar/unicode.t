﻿include ../test/more.proc

# Paul Boersma, 11 March 2010

# This script shouldn't just run correctly, but should also do the following things correctly:
# 1. Menu command "Where am I?".
# 2. Menu command "Go to line...".
# 3. These can be combined by doing Command-L, then OK.
# 4. Menu command "Run selection".
# 5. Menu command "Paste history", both into a cursor position and overwriting.

@no_plan()

outfile$ = "kanweg.txt"

@is: length("éééürtüéŋəü"), 11,
   ... "Precomposed unicode characters"

@is: length("éééürtüéŋəü"), 18,
   ... "Decomposed unicode characters"

@is: length("kanweg_abcåbçéü.txt"), 19,
   ... "Decomposed unicode filename"

@is$: "ɦɑlou" + "ɣujədɑx", "ɦɑlouɣujədɑx",
   ... "BMP (Unicode values up to 0xFFFF)"

@is$: left$("ɦɑlou", 3), "ɦɑl",
   ... "Unicode string slicing"

@cmp_ok$: "ɦɑl", "!=", "??l",
   ... "Unicode characters do not match question marks"

@test: "UTF-8", "UTF-8"

@test: "UTF-8", "UTF-16"

@test: "UTF-8", "try ASCII, then UTF-16"

@test: "try UTF-8, then ISO Latin-1", "try ISO Latin-1, then UTF-16"

#
# Clean up.
#
default$ =  if macintosh then "try UTF-8, then MacRoman"
   ... else if windows   then "try UTF-8, then Windows Latin-1"
   ... else if unix      then "try UTF-8, then ISO Latin-1"
   ... else "" fi fi fi

if default$ == ""
   @bail_out: "Unknown operating system"
endif

Text writing preferences: "try ASCII, then UTF-16"
Text reading preferences: default$

@ok_selection()

@is_false: fileReadable("abcåbçéü_" + outfile$),
   ... "deleted temporary unicode-named file"

@is_false: fileReadable(outfile$),
   ... "deleted temporary output file"

@done_testing()

procedure test: .read$, .write$
   Text reading preferences: .read$
   Text writing preferences: .write$

   @diag: .read$ + " / " + .write$

   # The text I/O commands ">", ">>", and "<":
   deleteFile: outfile$
   text$ = "adddɦɑlouɣujədɑxdɑx"
   text$ > 'outfile$'
   text$ < 'outfile$'
   @ok: text$ == "adddɦɑlouɣujədɑxdɑx",
      ... "I/O with > and <"

   text$ >> 'outfile$'
   text$ < 'outfile$'
   @is$: text$, "adddɦɑlouɣujədɑxdɑxadddɦɑlouɣujədɑxdɑx",
      ... "I/O with >> and <"

   # ASCII appending:
   deleteFile: outfile$
   fileappend 'outfile$' abc'newline$'
   fileappend 'outfile$' def'newline$'
   fileappend 'outfile$' ghi'newline$'
   text$ < 'outfile$'
   @is$: text$, "abc" + newline$ + "def" + newline$ + "ghi" + newline$,
      ... "ASCII appending"

   # UTF-16 appending (or UTF-8, or first ISO Latin-1
   # then change to UTF-16):
   deleteFile: outfile$
   fileappend 'outfile$' åbc'newline$'
   fileappend 'outfile$' dëf'newline$'
   fileappend 'outfile$' ‘ghi’וּ'newline$'
   text$ < 'outfile$'
   @is$: text$, "åbc" + newline$ + "dëf" + newline$ + "‘ghi’וּ" + newline$,
      ... "UTF-16 appending"

   # Append to file first in ASCII, then change
   # the encoding of the whole file to UTF-16 (or UTF-8):
   deleteFile: outfile$
   fileappend 'outfile$' abc'newline$'
   fileappend 'outfile$' dëf'newline$'
   fileappend 'outfile$' ‘ghi’וּ'newline$'
   text$ < 'outfile$'
   @is$: text$, "abc" + newline$ + "dëf" + newline$ + "‘ghi’וּ" + newline$,
      ... "ASCII then UTF-16 or UTF-8 appending"

   @is_true: fileReadable(outfile$),
      ... "file created"

   deleteFile: outfile$
   @is_false: fileReadable(outfile$),
      ... "file deleted"

   # Unicode file names (precomposed source code):
   deleteFile: "abcåbçéü_" + outfile$
   fileappend abcåbçéü_'outfile$' hallo
   @is_true: fileReadable("abcåbçéü_" + outfile$),
      ... "created file with decomposed filename"

   deleteFile: "abcåbçéü_" + outfile$
   @is_false: fileReadable("abcåbçéü_" + outfile$),
      ... "deleted file with decomposed filename"

   fileappend abcåbçéü_'outfile$' hallo
   text$ < abcåbçéü_'outfile$'
   @is$: text$, "hallo",
      ... "read from file with decomposed filename"

   Read from file: "åbçéü.wav"
   @is: numberOfSelected("Sound"), 1,
      ... "read from Sound file with unicode filename"

   info$ = Info
   secondLine = index (info$, "Object type")
   header$ = left$ (mid$ (info$, secondLine, 10000), 38)
   @is$: header$,
      ... "Object type: Sound" + newline$ + "Object name: åbçéü" + newline$,
      ... "read Sound header"
   Remove

   textgrid = Create TextGrid: 0, 1, "test" , ""
   Set interval text: 1, 1, "åçé"
   Write to text file: outfile$
   textgrid2 = Read from file: outfile$
   @is_deeply: textgrid, textgrid2,
      ... "TextGrid I/O as text"
   removeObject: textgrid, textgrid2

   Create Strings as file list: "list", "*.txt"
   n = Get number of strings
   only_txt = 1
   for i to n
      file_name$ = Get string: i
      if right$(file_name$, 4) != ".txt"
         only_txt = 0
      endif
      length = length (file_name$)
      if left$(file_name$, 10) = "kanweg_abc"
         @ok: left$(file_name$, 15) == "kanweg_abcåbçéü",
            ... "found filename in list"
      endif
   endfor
   deleteFile: outfile$
   deleteFile: "abcåbçéü_" + outfile$

   @is_true: only_txt,
      ... "globbing file list with unicode names"
   Remove
endproc
