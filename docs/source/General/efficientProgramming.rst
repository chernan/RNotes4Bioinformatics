Efficient programming
================================================================================



Some usual techniques in other languages don't work in R, or don't scale.
Use profiling to evaluate your code.

Profiling
--------------------------------------------------------------------------------

### system.time

Use the command system.time(expression) returning 3 numbers: user, system, and **elapsed**.


.. sourcecode:: r
    

    n <- 1e+05
    m <- 100
    
    sizes <- vector("numeric", n)
    results <- NULL
    system.time(for (i in 1:n) {
        result <- mean(runif(m))
        results <- c(results, result)
    })


::

    ## Warning: fermeture de la connexion inutilisée 4
    ## (/home/chernan/Workspace/DataAnalysis/RNotes4Bioinformatics//General/dataStructures.Rmd)



::

    ## Warning: fermeture de la connexion inutilisée 3
    ## (/home/chernan/Workspace/DataAnalysis/RNotes4Bioinformatics//General/dataManipulationAggregation.Rmd)



::

    ## utilisateur     système      écoulé 
    ##       38.32       12.56       51.69


.. sourcecode:: r
    

    
    sizes <- vector("numeric", n)
    results <- vector("numeric", n)
    
    system.time(for (i in 1:n) {
        result <- mean(runif(m))
        results[i] <- result
    })


::

    ## utilisateur     système      écoulé 
    ##       3.048       0.000       3.045


.. sourcecode:: r
    

    
    # system.time( results <- sapply(1:n, FUN=function(m){mean(runif(m))}) )



### Rprof()


.. sourcecode:: r
    

    Rprof()
    pvalues <- NULL
    for (i in 1:1e+05) {
        a <- runif(6)
        ttest <- t.test(a[1:3], a[4:6])
        pval <- ttest$p.value
        
        pvalues <- c(pvalues, pval)
    }
    Rprof(NULL)
    summaryRprof()


::

    ## $by.self
    ##                  self.time self.pct total.time total.pct
    ## "c"                  52.76    56.65      52.76     56.65
    ## "deparse"             5.84     6.27      16.46     17.67
    ## "t.test.default"      5.76     6.18      36.88     39.60
    ## ".deparseOpts"        3.80     4.08       6.26      6.72
    ## "stopifnot"           2.70     2.90       4.44      4.77
    ## "pmatch"              2.68     2.88       3.08      3.31
    ## "match"               2.12     2.28       8.00      8.59
    ## "t.test"              2.02     2.17      38.96     41.83
    ## "mean"                1.62     1.74       2.66      2.86
    ## "paste"               1.56     1.67      15.02     16.13
    ## "eval"                1.50     1.61      93.14    100.00
    ## "var"                 1.10     1.18       7.02      7.54
    ## "mean.default"        1.04     1.12       1.04      1.12
    ## "mode"                1.00     1.07       6.38      6.85
    ## "runif"               0.88     0.94       0.88      0.94
    ## "is.data.frame"       0.86     0.92       0.86      0.92
    ## "qt"                  0.82     0.88       0.82      0.88
    ## "match.call"          0.78     0.84       1.74      1.87
    ## "%in%"                0.68     0.73       8.42      9.04
    ## "pt"                  0.68     0.73       0.68      0.73
    ## "sys.call"            0.62     0.67       0.96      1.03
    ## "sys.parent"          0.58     0.62       0.58      0.62
    ## "$"                   0.56     0.60       0.56      0.60
    ## "match.arg"           0.52     0.56       4.90      5.26
    ## "formals"             0.24     0.26       0.60      0.64
    ## "sys.function"        0.12     0.13       0.36      0.39
    ## "parent.frame"        0.10     0.11       0.10      0.11
    ## "-"                   0.08     0.09       0.08      0.09
    ## ":"                   0.08     0.09       0.08      0.09
    ## "is.list"             0.04     0.04       0.04      0.04
    ## 
    ## $by.total
    ##                       total.time total.pct self.time self.pct
    ## "eval"                     93.14    100.00      1.50     1.61
    ## "<Anonymous>"              93.14    100.00      0.00     0.00
    ## "apply"                    93.14    100.00      0.00     0.00
    ## "block_exec"               93.14    100.00      0.00     0.00
    ## "call_block"               93.14    100.00      0.00     0.00
    ## "doTryCatch"               93.14    100.00      0.00     0.00
    ## "evaluate"                 93.14    100.00      0.00     0.00
    ## "evaluate_call"            93.14    100.00      0.00     0.00
    ## "FUN"                      93.14    100.00      0.00     0.00
    ## "handle"                   93.14    100.00      0.00     0.00
    ## "in_dir"                   93.14    100.00      0.00     0.00
    ## "knit"                     93.14    100.00      0.00     0.00
    ## "process_file"             93.14    100.00      0.00     0.00
    ## "process_group.block"      93.14    100.00      0.00     0.00
    ## "source"                   93.14    100.00      0.00     0.00
    ## "try"                      93.14    100.00      0.00     0.00
    ## "tryCatch"                 93.14    100.00      0.00     0.00
    ## "tryCatchList"             93.14    100.00      0.00     0.00
    ## "tryCatchOne"              93.14    100.00      0.00     0.00
    ## "withCallingHandlers"      93.14    100.00      0.00     0.00
    ## "withVisible"              93.14    100.00      0.00     0.00
    ## "c"                        52.76     56.65     52.76    56.65
    ## "t.test"                   38.96     41.83      2.02     2.17
    ## "t.test.default"           36.88     39.60      5.76     6.18
    ## "deparse"                  16.46     17.67      5.84     6.27
    ## "paste"                    15.02     16.13      1.56     1.67
    ## "%in%"                      8.42      9.04      0.68     0.73
    ## "match"                     8.00      8.59      2.12     2.28
    ## "var"                       7.02      7.54      1.10     1.18
    ## "mode"                      6.38      6.85      1.00     1.07
    ## ".deparseOpts"              6.26      6.72      3.80     4.08
    ## "match.arg"                 4.90      5.26      0.52     0.56
    ## "stopifnot"                 4.44      4.77      2.70     2.90
    ## "pmatch"                    3.08      3.31      2.68     2.88
    ## "mean"                      2.66      2.86      1.62     1.74
    ## "match.call"                1.74      1.87      0.78     0.84
    ## "mean.default"              1.04      1.12      1.04     1.12
    ## "sys.call"                  0.96      1.03      0.62     0.67
    ## "runif"                     0.88      0.94      0.88     0.94
    ## "is.data.frame"             0.86      0.92      0.86     0.92
    ## "qt"                        0.82      0.88      0.82     0.88
    ## "pt"                        0.68      0.73      0.68     0.73
    ## "formals"                   0.60      0.64      0.24     0.26
    ## "sys.parent"                0.58      0.62      0.58     0.62
    ## "$"                         0.56      0.60      0.56     0.60
    ## "sys.function"              0.36      0.39      0.12     0.13
    ## "parent.frame"              0.10      0.11      0.10     0.11
    ## "-"                         0.08      0.09      0.08     0.09
    ## ":"                         0.08      0.09      0.08     0.09
    ## "is.list"                   0.04      0.04      0.04     0.04
    ## 
    ## $sample.interval
    ## [1] 0.02
    ## 
    ## $sampling.time
    ## [1] 93.14



If we don't call the t.test() function and instead replace it by a difference in means divided by a variance plus a call to pt(), we can gain around 1/3 of overall time, because we miss the overhead of expression evaluation by R.


<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/80x15.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Celine Hernandez</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
