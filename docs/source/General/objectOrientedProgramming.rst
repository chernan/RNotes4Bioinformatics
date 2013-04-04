Object-Oriented programming in R
================================

Definitions
-----------

We use it without knowing it, nor worrying about it. A bit of vocab
: object, class, attribute, method, inheritance, polymorphism.

Two frameworks: S3 ("old-style", widely used in base packages) and
S4 ("formal classes", since R 1.7, widely used in Bioconductor).

S3 framework
------------

Class is a label attached to an object. Every object in R has a
class ("numeric", "matrix", "lm", "factor"...).

Method dispatch
~~~~~~~~~~~~~~~

Example of the summary() function. Applied on different objects
gives different outputs. Many summary."classname"() defined, for
each class.

``r summary``

``## function (object, ...)  ## UseMethod("summary") ## <bytecode: 0x9bb0d3c> ## <environment: namespace:base>``

``r methods("summary")``

``##  [1] summary.aov             summary.aovlist         ##  [3] summary.aspell*         summary.connection      ##  [5] summary.data.frame      summary.Date            ##  [7] summary.default         summary.ecdf*           ##  [9] summary.factor          summary.glm             ## [11] summary.infl            summary.lm              ## [13] summary.loess*          summary.manova          ## [15] summary.matrix          summary.mlm             ## [17] summary.nls*            summary.packageStatus*  ## [19] summary.PDF_Dictionary* summary.PDF_Stream*     ## [21] summary.POSIXct         summary.POSIXlt         ## [23] summary.ppr*            summary.prcomp*         ## [25] summary.princomp*       summary.srcfile         ## [27] summary.srcref          summary.stepfun         ## [29] summary.stl*            summary.table           ## [31] summary.tukeysmooth*    ##  ##    Non-visible functions are asterisked``

Non-visible functions can be accessed by
getAnywhere("functionname")

``r summary.loess()``

``## Error: impossible de trouver la fonction "summary.loess"``

``r getAnywhere(summary.loess)``

``## A single object matching 'summary.loess' was found ## It was found in the following places ##   registered S3 method for summary from namespace stats ##   namespace:stats ## with value ##  ## function (object, ...)  ## { ##     class(object) <- "summary.loess" ##     object ## } ## <bytecode: 0xb41e54d8> ## <environment: namespace:stats>``

Access all methods of a class.

``r methods(class = "lm")``

``##  [1] add1.lm*           alias.lm*          anova.lm           ##  [4] case.names.lm*     confint.lm*        cooks.distance.lm* ##  [7] deviance.lm*       dfbeta.lm*         dfbetas.lm*        ## [10] drop1.lm*          dummy.coef.lm*     effects.lm*        ## [13] extractAIC.lm*     family.lm*         formula.lm*        ## [16] hatvalues.lm       influence.lm*      kappa.lm           ## [19] labels.lm*         logLik.lm*         model.frame.lm     ## [22] model.matrix.lm    nobs.lm*           plot.lm            ## [25] predict.lm         print.lm           proj.lm*           ## [28] qr.lm*             residuals.lm       rstandard.lm       ## [31] rstudent.lm        simulate.lm*       summary.lm         ## [34] variable.names.lm* vcov.lm*           ##  ##    Non-visible functions are asterisked``

Creating an S3 object
~~~~~~~~~~~~~~~~~~~~~

Example of the mygsea2 package.

``r # Create a list z <- list() # Label it with the correct class class(z) <- "gsea" # Create the methods the user of the class/object will need print.gsea <- function(object) { } # If needed, create a new generic method reduce.gsea <- function(object) { } reduce <- function(object) UseMethod("reduce")``

The user can easily access the attributes directly, modify it...
and R will not complain!

S4 framework
------------

Based on the same "method dispatch" idea than S3, but more formal.

\`\`\`r setClass("GSEA", representation(nperms = "numeric"),
contains = "genelist", validity = function(object) {

::

    })

\`\`\`

``## Error: No definition was found for superclass "genelist" in the ## specification of class "GSEA"``

``r gsea <- new("GSEA", nperms = 1000)``

``## Error: "GSEA" is not a defined class``

Checks are made for the validity of any created object. Properties
include a name, representation, inheritance, prototype,
validation(), etc. Attributes are stored in slots, similar to the
components of a list for a S3 object, but use @ to "enter" the
attributes of an object. S3 use print(), S4 use show(). "ANY" is
the basic inheritance.

One can choose whichever one wants, but in any case, avoid mixing
S3 and S4.

How to access information in an unknown object?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class(object) look at documentation find if S3 or S4 names(object)
or isS4(object) look at the methods available for the object
methods(class="class") or showMethods(class="class") look at the
attributes using $ or @ if needed look at a method to see how it
handles the attributes (method.class or getMethods("method",
"class") )

R5 framework
------------

Still under development... See ?ReferenceClasses and
http://github.com/hadley/devtools/wiki/R5

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


