include ../test/more.proc

# Paul Boersma, 16 December 2015

@no_plan()

table = Read Table from table file: "logisticRegression/rh.Table"
logreg1 = To logistic regression: "Spec Dur", "/I/", "/i/"
logreg2 = Read from file: "logisticRegression/rh.LogisticRegression"

# For some reason, objectsAreIdentical does not work with these objects
@roughly_same: logreg1, logreg2, 1e-10, "Logistic regression matches sample"

info$ = Info
intercept = extractNumber (info$, "Intercept: ")
@is_approx: intercept, -8.7028, 1e-4, "Logistic regression intercept"

spec = extractNumber (info$, "Coefficient of factor Spec: ")
@is_approx: spec, 1.6587, 1e-4, "Logistic regression: spec coefficient"

dur = extractNumber (info$, "Coefficient of factor Dur: ")
@is_approx: dur, 0.6041, 1e-4, "Logistic regression: dur coefficient"

# removeObject: table, logreg1, logreg2

@done_testing()

procedure roughly_same: .id1, .id2, .precision, .msg$
   selectObject: .id1
   .info1$ = Info
   selectObject: .id2
   .info2$ = Info
   .return = 0

   .factors = extractNumber(.info1$, "Number of factors:")
      ...  == extractNumber(.info2$, "Number of factors:")

   .factor1 = extractWord$( .info1$, "Factor 1:")
      ...  == extractWord$( .info2$, "Factor 1:")

   .factor2 = extractWord$( .info1$, "Factor 2:")
      ...  == extractWord$( .info2$, "Factor 2:")

   .intercept = abs(
      ... extractNumber(.info1$, "Intercept:") -
      ... extractNumber(.info2$, "Intercept:") ) <= .precision

   .spec = abs(
      ... extractNumber(.info1$, "Coefficient of factor Spec:") -
      ... extractNumber(.info2$, "Coefficient of factor Spec:")) <= .precision

   .dur = abs(
      ... extractNumber(.info1$, "Coefficient of factor Dur:") -
      ... extractNumber(.info2$, "Coefficient of factor Dur:"))  <= .precision

   @ok: .factors and .factor1 and .factor2 and .spec and .dur, .msg$
   if !ok.value
     @diag: "  Objects '.id1' and '.id2' are not sufficiently similar"

     if !.factors
        @diag: "  Number of factors are different"
     endif
     if !.factor1
        @diag: "  Factor 1 is different"
     endif
     if !.factor2
        @diag: "  Factor 2 is different"
     endif
     if !.spec
        @diag: "  Spec is different"
     endif
     if !.dur
        @diag: "  Dur is different"
     endif
   endif
endproc
