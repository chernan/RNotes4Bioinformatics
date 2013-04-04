Expression evaluation
================================================================================

Assign and retrieve variables on the fly
--------------------------------------------------------------------------------

### Assign/Get

The assign() function is the equivalent of the arrow '<-' operator.


.. sourcecode:: r
    

    assign("x", mean(runif(10)))
    get("x")


::

    ## [1] 0.6653


.. sourcecode:: r
    

    
    patientid <- "10"
    assign(paste("treatment", patientid, sep = ""), sample(c("control", "treatment"), 
        1))
    treatment10


::

    ## [1] "treatment"




### Eval


.. sourcecode:: r
    

    eval(parse(text=paste("i <- ", "\"lots lots lots\"")))
    i


::

    ## [1] "lots lots lots"




<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/80x15.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Celine Hernandez</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
