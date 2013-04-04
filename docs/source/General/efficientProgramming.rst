Efficient programming
=====================

Some usual techniques in other languages don't work in R, or don't
scale. Use profiling to evaluate your code.

Profiling
---------

system.time
~~~~~~~~~~~

Use the command system.time(expression) returning 3 numbers: user,
system, and **elapsed**.

\`\`\`r n <- 1e+05 m <- 100

sizes <- vector("numeric", n) results <- NULL system.time(for (i in
1:n) { result <- mean(runif(m)) results <- c(results, result) })
\`\`\`

``## utilisateur     système      écoulé  ##      33.110       0.176      33.436``

\`\`\`r

sizes <- vector("numeric", n) results <- vector("numeric", n)

system.time(for (i in 1:n) { result <- mean(runif(m)) results[i] <-
result }) \`\`\`

``## utilisateur     système      écoulé  ##       3.032       0.000       3.046``

\`\`\`r

system.time( results <- sapply(1:n, FUN=function(m){mean(runif(m))}) )
======================================================================

\`\`\`

Rprof()
~~~~~~~

\`\`\`r Rprof() pvalues <- NULL for (i in 1:1e+05) { a <- runif(6)
ttest <- t.test(a[1:3], a[4:6]) pval <- ttest$p.value

::

    pvalues <- c(pvalues, pval)

} Rprof(NULL) summaryRprof() \`\`\`

``## $by.self ##                  self.time self.pct total.time total.pct ## "c"                  43.84    52.38      43.84     52.38 ## "t.test.default"      6.22     7.43      36.70     43.85 ## "deparse"             5.76     6.88      15.88     18.97 ## ".deparseOpts"        3.20     3.82       5.68      6.79 ## "pmatch"              2.98     3.56       3.14      3.75 ## "stopifnot"           2.34     2.80       4.64      5.54 ## "match"               2.18     2.60       7.90      9.44 ## "mean"                2.18     2.60       3.08      3.68 ## "t.test"              2.08     2.49      38.82     46.38 ## "paste"               1.34     1.60      14.22     16.99 ## "eval"                1.24     1.48      83.70    100.00 ## "var"                 1.12     1.34       7.10      8.48 ## "mode"                1.12     1.34       6.26      7.48 ## "match.call"          1.10     1.31       2.30      2.75 ## "mean.default"        0.90     1.08       0.90      1.08 ## "is.data.frame"       0.68     0.81       0.68      0.81 ## "runif"               0.68     0.81       0.68      0.81 ## "sys.call"            0.66     0.79       1.20      1.43 ## "qt"                  0.66     0.79       0.66      0.79 ## "sys.parent"          0.64     0.76       0.64      0.76 ## "match.arg"           0.60     0.72       4.84      5.78 ## "%in%"                0.56     0.67       8.22      9.82 ## "pt"                  0.52     0.62       0.52      0.62 ## "$"                   0.50     0.60       0.50      0.60 ## "formals"             0.22     0.26       0.36      0.43 ## "-"                   0.10     0.12       0.10      0.12 ## "parent.frame"        0.10     0.12       0.10      0.12 ## ":"                   0.08     0.10       0.08      0.10 ## "sys.function"        0.04     0.05       0.14      0.17 ## "is.list"             0.04     0.05       0.04      0.05 ## "as.character"        0.02     0.02       0.02      0.02 ##  ## $by.total ##                       total.time total.pct self.time self.pct ## "eval"                     83.70    100.00      1.24     1.48 ## "<Anonymous>"              83.70    100.00      0.00     0.00 ## "apply"                    83.70    100.00      0.00     0.00 ## "block_exec"               83.70    100.00      0.00     0.00 ## "call_block"               83.70    100.00      0.00     0.00 ## "doTryCatch"               83.70    100.00      0.00     0.00 ## "evaluate"                 83.70    100.00      0.00     0.00 ## "evaluate_call"            83.70    100.00      0.00     0.00 ## "FUN"                      83.70    100.00      0.00     0.00 ## "handle"                   83.70    100.00      0.00     0.00 ## "in_dir"                   83.70    100.00      0.00     0.00 ## "knit"                     83.70    100.00      0.00     0.00 ## "process_file"             83.70    100.00      0.00     0.00 ## "process_group.block"      83.70    100.00      0.00     0.00 ## "source"                   83.70    100.00      0.00     0.00 ## "try"                      83.70    100.00      0.00     0.00 ## "tryCatch"                 83.70    100.00      0.00     0.00 ## "tryCatchList"             83.70    100.00      0.00     0.00 ## "tryCatchOne"              83.70    100.00      0.00     0.00 ## "withCallingHandlers"      83.70    100.00      0.00     0.00 ## "withVisible"              83.70    100.00      0.00     0.00 ## "c"                        43.84     52.38     43.84    52.38 ## "t.test"                   38.82     46.38      2.08     2.49 ## "t.test.default"           36.70     43.85      6.22     7.43 ## "deparse"                  15.88     18.97      5.76     6.88 ## "paste"                    14.22     16.99      1.34     1.60 ## "%in%"                      8.22      9.82      0.56     0.67 ## "match"                     7.90      9.44      2.18     2.60 ## "var"                       7.10      8.48      1.12     1.34 ## "mode"                      6.26      7.48      1.12     1.34 ## ".deparseOpts"              5.68      6.79      3.20     3.82 ## "match.arg"                 4.84      5.78      0.60     0.72 ## "stopifnot"                 4.64      5.54      2.34     2.80 ## "pmatch"                    3.14      3.75      2.98     3.56 ## "mean"                      3.08      3.68      2.18     2.60 ## "match.call"                2.30      2.75      1.10     1.31 ## "sys.call"                  1.20      1.43      0.66     0.79 ## "mean.default"              0.90      1.08      0.90     1.08 ## "is.data.frame"             0.68      0.81      0.68     0.81 ## "runif"                     0.68      0.81      0.68     0.81 ## "qt"                        0.66      0.79      0.66     0.79 ## "sys.parent"                0.64      0.76      0.64     0.76 ## "pt"                        0.52      0.62      0.52     0.62 ## "$"                         0.50      0.60      0.50     0.60 ## "formals"                   0.36      0.43      0.22     0.26 ## "sys.function"              0.14      0.17      0.04     0.05 ## "-"                         0.10      0.12      0.10     0.12 ## "parent.frame"              0.10      0.12      0.10     0.12 ## ":"                         0.08      0.10      0.08     0.10 ## "is.list"                   0.04      0.05      0.04     0.05 ## "as.character"              0.02      0.02      0.02     0.02 ##  ## $sample.interval ## [1] 0.02 ##  ## $sampling.time ## [1] 83.7``

If we don't call the t.test() function and instead replace it by a
difference in means divided by a variance plus a call to pt(), we
can gain around 1/3 of overall time, because we miss the overhead
of expression evaluation by R.

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


