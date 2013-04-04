Packages
========

Note that using RStudio greatly facilitates package creation and
build, as all the process has been completely integrated in the
IDE.

Creation
--------

One can use package.skeleton to create a package from a set of R
scripts located in a folder.

``r all.files <- list.files("myFolder/", recursive = TRUE, full.name = TRUE) package.skeleton("PackageName", code_files = all.files, namespace = TRUE, force = TRUE)``

All \*.R files will be put directly inside R/ folder, and
documentation will be automatically generated for each
function/file in doc/. See "Documentation" paragraph.

Documentation
-------------

One recommended way to manage package documentation is by using
roxygen. The main advantage is that code and documentation are in
the same file, facilitating documentation update during
development.

``r install.packages("roxygen") library("roxygen")``

After creation of a package with package.skeleton, source code can
be "roxygenized"" to create separate documentation files.

``r roxygenize("PackageName", copy.package = FALSE, )``

Build
-----

It's a 2-step process. First check the global structure of the
package, then build it.

Check global structure (must be located above PackageName folder)

``r R CMD check PackageName``

Build package (must be located above PackageName folder)

``r R CMD build PackageName``

This step will produce an archive (PackageName\_1.0.tar.gz)
allowing to install your package.

Note: In Unix environment, building a R package needs pdflatex (and
many other dependencies: lmodern luatex tex-common texlive-base
texlive-binaries texlive-common texlive-doc-base
texlive-latex-base-doc texlive-luatex...). Other packages are also
needed but not installed by default.

``r sudo apt-get install texlive-latex-base sudo apt-get install texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended``

This work by Celine Hernandez is licensed under a Creative Commons
Attribution-ShareAlike 3.0 Unported License.


