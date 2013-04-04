Expression evaluation
=====================

Assign and retrieve variables on the fly
----------------------------------------

Assign/Get
~~~~~~~~~~

The assign() function is the equivalent of the arrow '<-'
operator.

``r assign("x", mean(runif(10))) get("x")``

``## [1] 0.4392``

\`\`\`r

patientid <- "10" assign(paste("treatment", patientid, sep = ""),
sample(c("control", "treatment"), 1)) treatment10 \`\`\`

``## [1] "control"``

Eval
~~~~

``r eval(parse(text=paste("i <- ", "\"lots lots lots\""))) i``

``## [1] "lots lots lots"``

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


