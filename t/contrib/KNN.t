include ../test/more.proc

a1 = 0
a2 = 0
a3 = 0

@no_plan()

for i from 1 to 30
   Create iris example...  0 0
   ffnet      = selected("FFNet")
   pattern    = selected("Pattern")
   categories = selected("Categories")

   selectObject: pattern, categories
   knn = To KNN Classifier: "Classifier", "Sequential"

   selectObject: knn
   temp = Get accuracy estimate: "Leave one out",
      ... 10, "Inverse squared distance"
   a1 = a1 + (temp - a1) / i
   Shuffle

   temp = Get accuracy estimate: "10-fold cross-validation",
      ... 10, "Inverse squared distance"
   a2 = a2 + (temp - a2) / i

   Prune: 1, 1, 10
   selectObject: pattern, categories, knn
   temp = Evaluate: 10, "Inverse squared distance"
   a3 = a3 + (temp - a3) / i

   removeObject: ffnet, pattern, categories, knn
endfor

result = (a1 + a2 + a3) / 3

@cmp_ok: result, ">", 96, "KNN tests"

@ok_selection()

@done_testing()
