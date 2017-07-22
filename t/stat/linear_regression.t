include ../test/more.proc

# Paul Boersma, 23 November 2015

@no_plan()

table = Read Table from table file: "logisticRegression/rh.Table"
regression = To linear regression

info$ = Info
intercept = extractNumber (info$, "Intercept: ")
@is_approx: intercept, 10, 1e-10, "Linear regression intercept"

spec = extractNumber (info$, "Coefficient of factor Spec: ")
@is_approx: spec, 0, 1e-10, "Linear regression: spec coefficient"

dur = extractNumber (info$, "Coefficient of factor Dur: ")
@is_approx: dur, 0, 1e-10, "Linear regression: dur coefficient"

i = extractNumber (info$, "Coefficient of factor /I/: ")
@is_approx: i, -1, 1e-10, "Linear regression: /I/ coefficient"

removeObject: table, regression

@done_testing()
