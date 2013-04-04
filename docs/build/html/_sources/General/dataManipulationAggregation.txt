Data manipulation/aggregation
================================================================================

Contingency table
--------------------------------------------------------------------------------

table()


"Apply" family
--------------------------------------------------------------------------------

### apply()

MAR=1 to loop on rows
MAR=2 to loop on columns

Other specialized function are often more efficient, like rowSums(matrix).

### lapply() 
to apply on the elements of a list

### sapply() 
to apply on the elements of a list and simplify the result to a vector if possible.

### tapply(data, factorForGroups, FUN) 
apply a function FUN on a matrix after aggregating data using a factor. Or one can use split(data[, "height"], data[ ,"sex"])


Aggregate
--------------------------------------------------------------------------------

aggregate(x, by, FUN) data.frame/**list**/function, works in a similar way to tapply() but:
- works on whole data.frame (multiple columns
- **only produces scalar summaries**


.. sourcecode:: r
    

    data(iris)
    head(iris, 3)


::

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa


.. sourcecode:: r
    

    aggregate(iris[, 1:4], iris[5], FUN = mean)


::

    ##      Species Sepal.Length Sepal.Width Petal.Length Petal.Width
    ## 1     setosa        5.006       3.428        1.462       0.246
    ## 2 versicolor        5.936       2.770        4.260       1.326
    ## 3  virginica        6.588       2.974        5.552       2.026


.. sourcecode:: r
    

    ## Note that iris[5] is a list (as iris['Species']), instead of iris[,5]
    ## which is a vector (as iris$Species)



Merge
--------------------------------------------------------------------------------

### merge()
Merge two data frames, by column or by row. By default the function finds all common column names and use them all.
Interesting parameters include :
'by' (by.x, by.y) to specify common columns to use for the merge
'all' (all.x, all.x) to specify if all lines should be kept (even the ones without correspondance in the other data frame). 

.. sourcecode:: r
    

    x <- data.frame(index = c(2, 3, 1), fruit = c("orange", "lemon", "grapefruit"))
    y <- data.frame(index = c(3, 1, 2, 1), quantity = c(13, 6, 3, 5))
    merge(x, y)


::

    ##   index      fruit quantity
    ## 1     1 grapefruit        6
    ## 2     1 grapefruit        5
    ## 3     2     orange        3
    ## 4     3      lemon       13




A good practice is to specify each time by which column you want to merge for x and y.

### union/intersect/setdiff/setequal

### match(newlist, reflist) 
a general way for finding common values


Split data according to groups information
--------------------------------------------------------------------------------

split() splits a vector (or rows of a data frame) into separate elements of a list, ready for further processing.


From wide to long format
--------------------------------------------------------------------------------

stack() transforms a matrix with headers (wide format), into one 2-columns data-frame with measurements/labels (long format).
Correlation need wide format, modeling need long format.

reshape() has more possibilities, and is consequently more complex.


<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/80x15.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Celine Hernandez</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
