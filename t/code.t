include test/more.proc

@no_plan()

@diag: "Checking code updates..."

code$ = readFile$: "../dwtools/Strings_extensions.cpp"
@is_false: index (code$, "Get string..."), "2012-08-11"

code$ = readFile$: "../external/gsl/Makefile"
@is_false: index (code$, "CFLAGS"), "2012-08-08"

code$ = readFile$: "../dwsys/regularExp.cpp"
@is_false: index (code$, "'0' }"), "2012-08-07"

code$ = readFile$: "../external/espeak/speak_lib.cpp"
@is_false: index (code$, "setlocale"), "2012-10-01"

@done_testing()
