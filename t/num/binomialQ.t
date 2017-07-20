include ../test/more.proc

@no_plan()

@diag: "binomialQ"

@is_approx: invBinomialP (0.025, 211, 1000),
    ... 0.237622, 0.000001, "invBinomialP"

@is_approx: invBinomialQ (0.025, 211, 1000),
    ... 0.186092, 0.000001, "invBinomialQ"

@is_approx: binomialP (invBinomialP (0.025, 211, 1000), 211, 1000),
    ... 0.025, 1e-14, "round trip Q"

@is_approx: binomialQ (invBinomialQ (0.025, 211, 1000), 211, 1000),
    ... 0.025, 1e-15, "round trip P"

@done_testing()
