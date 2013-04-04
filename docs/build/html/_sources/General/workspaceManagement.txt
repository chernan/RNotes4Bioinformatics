Workspace management
========================================================

Installing a package
--------------------------------------------------------------------------------

From inside the workspace.

.. sourcecode:: r
    

    install.packages("knitr")



From outside any R session
Download from CRAN, by ex. http://cran.r-project.org/web/packages/knitr/index.html

.. sourcecode:: r
    

    R CMD INSTALL knitr



List loaded packages
--------------------------------------------------------------------------------

Get a global view of the current session. In reproducible research, this information is important to keep after a data analysis, in order to be able to re-set the same environment.


.. sourcecode:: r
    

    sessionInfo()


::

    ## R version 2.15.2 (2012-10-26)
    ## Platform: i686-pc-linux-gnu (32-bit)
    ## 
    ## locale:
    ##  [1] LC_CTYPE=fr_CH.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=fr_CH.UTF-8        LC_COLLATE=fr_CH.UTF-8    
    ##  [5] LC_MONETARY=fr_CH.UTF-8    LC_MESSAGES=fr_CH.UTF-8   
    ##  [7] LC_PAPER=C                 LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=fr_CH.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] markdown_0.5.4 knitr_1.1     
    ## 
    ## loaded via a namespace (and not attached):
    ## [1] digest_0.6.3   evaluate_0.4.3 formatR_0.7    stringr_0.6.2 
    ## [5] tools_2.15.2




Get the list of all currently loaded packages, and a few information on them.


.. sourcecode:: r
    

    installed.packages()[.packages(), ]


::

    ##           Package     LibPath                                         
    ## markdown  "markdown"  "/home/chernan/R/i686-pc-linux-gnu-library/2.15"
    ## knitr     "knitr"     "/home/chernan/R/i686-pc-linux-gnu-library/2.15"
    ## stats     "stats"     "/usr/lib/R/library"                            
    ## graphics  "graphics"  "/usr/lib/R/library"                            
    ## grDevices "grDevices" "/usr/lib/R/library"                            
    ## utils     "utils"     "/usr/lib/R/library"                            
    ## datasets  "datasets"  "/usr/lib/R/library"                            
    ## methods   "methods"   "/usr/lib/R/library"                            
    ## base      "base"      "/usr/lib/R/library"                            
    ##           Version  Priority Depends        
    ## markdown  "0.5.4"  NA       "R (>= 2.11.1)"
    ## knitr     "1.1"    NA       "R (>= 2.14.1)"
    ## stats     "2.15.2" "base"   NA             
    ## graphics  "2.15.2" "base"   NA             
    ## grDevices "2.15.2" "base"   NA             
    ## utils     "2.15.2" "base"   NA             
    ## datasets  "2.15.2" "base"   NA             
    ## methods   "2.15.2" "base"   NA             
    ## base      "2.15.2" "base"   NA             
    ##           Imports                                                                                       
    ## markdown  NA                                                                                            
    ## knitr     "evaluate (>= 0.4.3), digest, formatR (>= 0.3-4), markdown (>=\n0.4), stringr (>= 0.6), tools"
    ## stats     NA                                                                                            
    ## graphics  "grDevices"                                                                                   
    ## grDevices NA                                                                                            
    ## utils     NA                                                                                            
    ## datasets  NA                                                                                            
    ## methods   "utils"                                                                                       
    ## base      NA                                                                                            
    ##           LinkingTo
    ## markdown  NA       
    ## knitr     NA       
    ## stats     NA       
    ## graphics  NA       
    ## grDevices NA       
    ## utils     NA       
    ## datasets  NA       
    ## methods   NA       
    ## base      NA       
    ##           Suggests                                                                 
    ## markdown  "RCurl"                                                                  
    ## knitr     "testthat, rgl, codetools, R2SWF (>= 0.4), XML, RCurl, Rcpp\n(>= 0.10.0)"
    ## stats     NA                                                                       
    ## graphics  NA                                                                       
    ## grDevices NA                                                                       
    ## utils     NA                                                                       
    ## datasets  NA                                                                       
    ## methods   NA                                                                       
    ## base      NA                                                                       
    ##           Enhances OS_type License            Built   
    ## markdown  NA       NA      "GPL-3"            "2.15.2"
    ## knitr     NA       NA      "GPL"              "2.15.2"
    ## stats     NA       NA      "Part of R 2.15.2" "2.15.2"
    ## graphics  NA       NA      "Part of R 2.15.2" "2.15.2"
    ## grDevices NA       NA      "Part of R 2.15.2" "2.15.2"
    ## utils     NA       NA      "Part of R 2.15.2" "2.15.2"
    ## datasets  NA       NA      "Part of R 2.15.2" "2.15.2"
    ## methods   NA       NA      "Part of R 2.15.2" "2.15.2"
    ## base      NA       NA      "Part of R 2.15.2" "2.15.2"




Load/detach a package
--------------------------------------------------------------------------------


.. sourcecode:: r
    

    ## Detach a package
    detach("package:affy", unload = TRUE)
    
    ## Load a package
    library("Biobase", lib.loc = "/home/chernan/R/i686-pc-linux-gnu-library/2.15")
    
    ## Write the list in a file
    instPackages <- installed.packages()[.packages(), ]
    write.table(instPackages, "loadedPackages.txt", quote = TRUE)
    
    ## Load packages from a file
    packagesToLoad <- read.table("loadedPackages.txt", header = TRUE, stringsAsFactors = FALSE)
    apply(packagesToLoad, 1, FUN = function(aLib) {
        library(package = aLib["Package"], lib.loc = aLib["LibPath"], character.only = TRUE)
    })




<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/80x15.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Celine Hernandez</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
