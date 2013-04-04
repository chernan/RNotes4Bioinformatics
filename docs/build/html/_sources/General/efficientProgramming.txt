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

``## utilisateur     système      écoulé  ##       29.07       14.63       43.79``

\`\`\`r

sizes <- vector("numeric", n) results <- vector("numeric", n)

system.time(for (i in 1:n) { result <- mean(runif(m)) results[i] <-
result }) \`\`\`

``## utilisateur     système      écoulé  ##       2.936       0.000       2.933``

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

``## $by.self ##                  self.time self.pct total.time total.pct ## "c"                  46.30    54.27      46.30     54.27 ## "deparse"             6.12     7.17      16.64     19.50 ## "t.test.default"      4.52     5.30      36.28     42.52 ## ".deparseOpts"        3.40     3.98       5.92      6.94 ## "pmatch"              2.72     3.19       3.04      3.56 ## "stopifnot"           2.64     3.09       4.42      5.18 ## "match"               2.10     2.46       7.78      9.12 ## "mean"                1.96     2.30       2.80      3.28 ## "t.test"              1.74     2.04      38.08     44.63 ## "var"                 1.52     1.78       7.44      8.72 ## "eval"                1.32     1.55      85.32    100.00 ## "paste"               1.32     1.55      14.82     17.37 ## "mode"                1.24     1.45       6.14      7.20 ## "match.call"          1.16     1.36       1.78      2.09 ## "is.data.frame"       0.98     1.15       0.98      1.15 ## "mean.default"        0.84     0.98       0.84      0.98 ## "qt"                  0.82     0.96       0.82      0.96 ## "runif"               0.72     0.84       0.72      0.84 ## "%in%"                0.66     0.77       8.22      9.63 ## "$"                   0.52     0.61       0.52      0.61 ## "pt"                  0.52     0.61       0.52      0.61 ## "sys.parent"          0.50     0.59       0.50      0.59 ## "match.arg"           0.44     0.52       5.18      6.07 ## "sys.call"            0.34     0.40       0.62      0.73 ## "formals"             0.26     0.30       0.64      0.75 ## ":"                   0.18     0.21       0.18      0.21 ## "sys.function"        0.16     0.19       0.38      0.45 ## "parent.frame"        0.14     0.16       0.14      0.16 ## "-"                   0.10     0.12       0.10      0.12 ## "as.character"        0.06     0.07       0.06      0.07 ## "is.pairlist"         0.02     0.02       0.02      0.02 ##  ## $by.total ##                       total.time total.pct self.time self.pct ## "eval"                     85.32    100.00      1.32     1.55 ## "<Anonymous>"              85.32    100.00      0.00     0.00 ## "apply"                    85.32    100.00      0.00     0.00 ## "block_exec"               85.32    100.00      0.00     0.00 ## "call_block"               85.32    100.00      0.00     0.00 ## "doTryCatch"               85.32    100.00      0.00     0.00 ## "evaluate"                 85.32    100.00      0.00     0.00 ## "evaluate_call"            85.32    100.00      0.00     0.00 ## "FUN"                      85.32    100.00      0.00     0.00 ## "handle"                   85.32    100.00      0.00     0.00 ## "in_dir"                   85.32    100.00      0.00     0.00 ## "knit"                     85.32    100.00      0.00     0.00 ## "process_file"             85.32    100.00      0.00     0.00 ## "process_group.block"      85.32    100.00      0.00     0.00 ## "try"                      85.32    100.00      0.00     0.00 ## "tryCatch"                 85.32    100.00      0.00     0.00 ## "tryCatchList"             85.32    100.00      0.00     0.00 ## "tryCatchOne"              85.32    100.00      0.00     0.00 ## "withCallingHandlers"      85.32    100.00      0.00     0.00 ## "withVisible"              85.32    100.00      0.00     0.00 ## "c"                        46.30     54.27     46.30    54.27 ## "t.test"                   38.08     44.63      1.74     2.04 ## "t.test.default"           36.28     42.52      4.52     5.30 ## "deparse"                  16.64     19.50      6.12     7.17 ## "paste"                    14.82     17.37      1.32     1.55 ## "%in%"                      8.22      9.63      0.66     0.77 ## "match"                     7.78      9.12      2.10     2.46 ## "var"                       7.44      8.72      1.52     1.78 ## "mode"                      6.14      7.20      1.24     1.45 ## ".deparseOpts"              5.92      6.94      3.40     3.98 ## "match.arg"                 5.18      6.07      0.44     0.52 ## "stopifnot"                 4.42      5.18      2.64     3.09 ## "pmatch"                    3.04      3.56      2.72     3.19 ## "mean"                      2.80      3.28      1.96     2.30 ## "match.call"                1.78      2.09      1.16     1.36 ## "is.data.frame"             0.98      1.15      0.98     1.15 ## "mean.default"              0.84      0.98      0.84     0.98 ## "qt"                        0.82      0.96      0.82     0.96 ## "runif"                     0.72      0.84      0.72     0.84 ## "formals"                   0.64      0.75      0.26     0.30 ## "sys.call"                  0.62      0.73      0.34     0.40 ## "$"                         0.52      0.61      0.52     0.61 ## "pt"                        0.52      0.61      0.52     0.61 ## "sys.parent"                0.50      0.59      0.50     0.59 ## "sys.function"              0.38      0.45      0.16     0.19 ## ":"                         0.18      0.21      0.18     0.21 ## "parent.frame"              0.14      0.16      0.14     0.16 ## "-"                         0.10      0.12      0.10     0.12 ## "as.character"              0.06      0.07      0.06     0.07 ## "is.pairlist"               0.02      0.02      0.02     0.02 ##  ## $sample.interval ## [1] 0.02 ##  ## $sampling.time ## [1] 85.32``

If we don't call the t.test() function and instead replace it by a
difference in means divided by a variance plus a call to pt(), we
can gain around 1/3 of overall time, because we miss the overhead
of expression evaluation by R.

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


