R data structures
=================

Any R object has 2 attributes: mode (type of data: logical,
numeric, function, complex, character, raw, list,...) and class
(label)

R storage modes
---------------

Obtained by the typeof() function

``r f <- function() { } f$a``

``## Error: objet de type 'closure' non indiçable``

``r ## Error mentionning type 'closure'``

logical, numeric (integer or double), function (closure or builtin
or special)

Logical
-------

Easy to convert (and back) with numeric. But this easy conversion
can cause problems.

``r vector <- 1:10 vector[c(0, 1)]``

``## [1] 1``

``r vector[c(F, T)]``

``## [1]  2  4  6  8 10``

Never use F and T shortcuts for False and TRUE.

Vector
------

Contain values of the **same mode**.

``r x <- c(1, 2, 3, 4) x``

``## [1] 1 2 3 4``

``r mode(x)``

``## [1] "numeric"``

``r x <- c(1, 2, TRUE, 3) x``

``## [1] 1 2 1 3``

``r mode(x)``

``## [1] "numeric"``

``r x <- c(1, 2, "true", 4) x``

``## [1] "1"    "2"    "true" "4"``

``r mode(x)``

``## [1] "character"``

Matrix
------

Can also access an element with one index

``r a <- 1:30 attr(a, "dim") <- c(5, 6) class(a) <- "matrix" a``

``##      [,1] [,2] [,3] [,4] [,5] [,6] ## [1,]    1    6   11   16   21   26 ## [2,]    2    7   12   17   22   27 ## [3,]    3    8   13   18   23   28 ## [4,]    4    9   14   19   24   29 ## [5,]    5   10   15   20   25   30``

``r a[11]``

``## [1] 11``

``r a[1, 3]``

``## [1] 11``

As for vectors, all elements must be of the same mode. Insert a
text, and all numeric will turn into characters.

List
----

Is a collection of objects with different modes. Access either by
rank or by name.

``r mylist <- list(ages = c(12, 35, 34, 62), height = c(135, 128, 164, 165), sex = c("M",      "F", "M", "M")) mylist[[1]]``

``## [1] 12 35 34 62``

``r class(mylist[[1]])``

``## [1] "numeric"``

``r mylist[1]``

``## $ages ## [1] 12 35 34 62``

``r class(mylist[1])``

``## [1] "list"``

``r mylist$height``

``## [1] 135 128 164 165``

Data frames
-----------

List with each element has same number of elements.

``r data <- as.data.frame(mylist) data``

``##   ages height sex ## 1   12    135   M ## 2   35    128   F ## 3   34    164   M ## 4   62    165   M``

``r class(data)``

``## [1] "data.frame"``

``r mode(data)``

``## [1] "list"``

Data access
~~~~~~~~~~~

``r data[1]``

``##   ages ## 1   12 ## 2   35 ## 3   34 ## 4   62``

``r data[[1]]``

``## [1] 12 35 34 62``

``r data$height``

``## [1] 135 128 164 165``

A good rule of thumb is to always **use labels** for accessing data
frame columns (in case order changes), and **full labels** as
partial labels imply R checking for all column names.

Subset
~~~~~~

Using negative indices (not valid with column names).

``r data[, -2]``

``##   ages sex ## 1   12   M ## 2   35   F ## 3   34   M ## 4   62   M``

Using -grep() but be carefull of which column really matches.

``r data[, -grep("h", names(data))]``

``##   ages sex ## 1   12   M ## 2   35   F ## 3   34   M ## 4   62   M``

Using subset() and a - sign in front of the column name you want to
discard.

``r subset(data, select = -height)``

``##   ages sex ## 1   12   M ## 2   35   F ## 3   34   M ## 4   62   M``

Factors
-------

Represent categorical variables.

``r hair <- factor(c("blond", "brown", "red", "blond")) hair``

``## [1] blond brown red   blond ## Levels: blond brown red``

``r hair[2] <- "blond" hair[2] <- "grey"``

``## Warning: niveau de facteur incorrect, NAs générés``

``r hair``

``## [1] blond <NA>  red   blond ## Levels: blond brown red``

``r class(hair)``

``## [1] "factor"``

``r mode(hair)``

``## [1] "numeric"``

``r as.numeric(hair)``

``## [1]  1 NA  3  1``

They are also more memory-efficient than tables of characters.

Difficult to concatenate

``r c(hair, hair)``

``## [1]  1 NA  3  1  1 NA  3  1``

``r # Workaround 1 factor(as.character(hair), as.character(hair))``

``## Warning: les niveaux dupliqués ne seront plus acceptés pour les variables ## de type 'factor'``

``## [1] blond <NA>  red   blond ## Levels: blond red blond``

``r # Workaround 2 unlist(list(hair, hair))``

``## [1] blond <NA>  red   blond blond <NA>  red   blond ## Levels: blond brown red``

To add a value: turn factor to character, add element and turn it
to factor again.

Use ordered=TRUE for ordered values.

``r time <- factor(c(1, 2, 3, 2, 2, 1), levels = c(1, 2, 3), labels = c("never",      "sometimes", "always"), ordered = TRUE) time``

``## [1] never     sometimes always    sometimes sometimes never     ## Levels: never < sometimes < always``

``r time[2] < time[3]``

``## [1] TRUE``

``r "sometimes" < "always"``

``## [1] FALSE``

``r boxplot(measure ~ groups)``

``## Error: objet 'measure' introuvable``

``r summary(aov(measure ~ groups))``

``## Error: objet 'measure' introuvable``

``r groups <- as.factor(groups)``

``## Error: objet 'groups' introuvable``

``r groups``

``## Error: objet 'groups' introuvable``

``r summary(aov(measure ~ groups))``

``## Error: objet 'measure' introuvable``

By default, data.frame() and read.table() convert all non-numerical
values into factors. Use stringsAsFactors=FALSE or as.is=TRUE It
can also be set in defaults options(stringsAsFactors=FALSE)

Other related functions
-----------------------

summary()
~~~~~~~~~

``r summary(mylist)``

``##        Length Class  Mode      ## ages   4      -none- numeric   ## height 4      -none- numeric   ## sex    4      -none- character``

Class:none means that the class is the same as the mode.

str()
~~~~~

**Detailed** information (as detailed as possible) about the
structure of a model.

``r str(mylist)``

``## List of 3 ##  $ ages  : num [1:4] 12 35 34 62 ##  $ height: num [1:4] 135 128 164 165 ##  $ sex   : chr [1:4] "M" "F" "M" "M"``

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


