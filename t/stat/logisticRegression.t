include ../test_simple.proc

# Paul Boersma, 16 December 2015

@no_plan()

table = Read Table from table file: "logisticRegression/rh.Table"
logreg1 = To logistic regression: "Spec Dur", "/I/", "/i/"
logreg2 = Read from file: "logisticRegression/rh.LogisticRegression"
@fuzzyIdentityCheck: logreg1, logreg2
@ok: fuzzyIdentityCheck.return,
	... "Logistic regression matches sample"

info$ = Info
intercept = extractNumber (info$, "Intercept: ")
@ok: fixed$(intercept, 4) == "-8.7028",
	... "Logistic regression intercept"

spec = extractNumber (info$, "Coefficient of factor Spec: ")
@ok: fixed$(spec, 4) = "1.6587",
	... "Logistic regression: spec coefficient"

dur = extractNumber (info$, "Coefficient of factor Dur: ")
@ok: fixed$ (dur, 4) = "0.6041",
	... "Logistic regression: dur coefficient"

# removeObject: table, logreg1, logreg2

@done_testing()

procedure fuzzyIdentityCheck: .id1, .id2
	.threshold = 0.00000001
	selectObject: .id1
	.info1$ = Info
	selectObject: .id2
	.info2$ = Info
	.return = 0

	if 	    extractNumber(.info1$, "Number of factors:")         == extractNumber(.info2$, "Number of factors:")                        and
		... extractWord$( .info1$, "Factor 1:")                  == extractWord$( .info2$, "Factor 1:")                                 and
		... extractWord$( .info1$, "Factor 2:")                  == extractWord$( .info2$, "Factor 2:")                                 and
		... extractNumber(.info1$, "Intercept:")                  - extractNumber(.info2$, "Intercept:")                  <= .threshold and
		... extractNumber(.info1$, "Coefficient of factor Spec:") - extractNumber(.info2$, "Coefficient of factor Spec:") <= .threshold and
		... extractNumber(.info1$, "Coefficient of factor Dur:")  - extractNumber(.info2$, "Coefficient of factor Dur:")  <= .threshold

		.return = 1
	endif
endproc
