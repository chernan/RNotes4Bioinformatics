Input/output
============

Input
-----

Read a table from a file
~~~~~~~~~~~~~~~~~~~~~~~~

Read a tab-separated file. Always provide stringAsFactors,
row.names and header.

``r read.table("file.dat", header = TRUE, row.names = NULL, stringsAsFactors = FALSE)``

Download a file from the Internet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The download.file() function can be used to dowload a file from the
Internet. A particular attention should be taken if the protocol is
secured (https). Then other methods than the default should be used
(wget or curl) or the user will get a "unsupported url scheme"
error.

``r download.file("https://www.data.gouv.fr/var/download/6c0c22473a289c426bca9aecb9b6e21c.zip",      destfile = "~/produitsBiocides2011.csv", method = "wget")``

Read lines from a web pages
~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to read a web page directly, one should first open a
connexion to the web page giving a URL. Then this connexion is used
to read a given number of lines. n=-1L is the default value and
means that everything will be read, but one can also provide a
specific number of lines.)

``r url <- url("http://www.google.com/") googleMainPage <- readLines(url, n = -1)``

``## Warning: ligne finale incomplète trouvée dans 'http://www.google.com/'``

``r length(googleMainPage)``

``## [1] 17``

``r close(con = url)``

Output
------

Write a table
~~~~~~~~~~~~~

With the write.table() function. By default it uses tabulation as
separator. Row names are also saved. Consequently, the first line
has one element less than following lines.

``r dframe <- data.frame(a = c(1, 5, 3), b = c("blue", "red", "green")) write.table(dframe, "dataframe.txt", append = FALSE, sep = "\t", row.names = FALSE,      quote = FALSE, col.names = FALSE)``

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


