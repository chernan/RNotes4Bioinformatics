String manipulation
================================================================================

Concatenate
--------------------------------------------------------------------------------

paste a set of character strings, and can do replication in strings.


.. sourcecode:: r
    

    paste("Chr", c(1:22, "X", "Y"), sep = "")


::

    ##  [1] "Chr1"  "Chr2"  "Chr3"  "Chr4"  "Chr5"  "Chr6"  "Chr7"  "Chr8" 
    ##  [9] "Chr9"  "Chr10" "Chr11" "Chr12" "Chr13" "Chr14" "Chr15" "Chr16"
    ## [17] "Chr17" "Chr18" "Chr19" "Chr20" "Chr21" "Chr22" "ChrX"  "ChrY"




Split
--------------------------------------------------------------------------------

strsplit(vector, separator)

strsplit on the empty string separates all characters.


.. sourcecode:: r
    

    sequence <- "ATTGCCTGGATT"
    strsplit(sequence, "")


::

    ## [[1]]
    ##  [1] "A" "T" "T" "G" "C" "C" "T" "G" "G" "A" "T" "T"




Regular expressions
--------------------------------------------------------------------------------

grep() find if a string contains a given pattern (see also regexpr())

sub() find a pattern and replace it (see also ). If it can't replace anything in a string, the full string is itself returned.

See also
--------------------------------------------------------------------------------

See also factors in "Data structures" chapter.



<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/80x15.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Celine Hernandez</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
