include ../test/more.proc

@no_plan()

a# = zero# (3)
a#[1] = 3
a#[2] = 2
a#[3] = 4
output# = softmax#(a#)

@is_approx: output#[1], 0.244728, 1e-6, ""
@is_approx: output#[2], 0.090030, 1e-6, ""
@is_approx: output#[3], 0.665240, 1e-6, ""

@done_testing()
