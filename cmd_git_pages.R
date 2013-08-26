setwd("/home/chernan/Workspace/DataAnalysis/RNotes4Bioinformatics")
projectWd <- getwd()

## Checkout branch where doc is stored

dir.create('./dist_doc')
setwd(paste0(getwd(), '/dist_doc'))
# system('git clone https://github.com/chernan/RNotes4Bioinformatics.git')
setwd(paste0(getwd(), '/RNotes4Bioinformatics'))
# system('git fetch origin')
# system('git checkout gh-pages')

alldocWd <- getwd()

## List files to be transformed

filesRmd <- data.frame(
    directory=rep(c("General", "Graphics"),
                  times=c(8,3)
    ),
    fileName=c("dataManipulationAggregation",
               "dataStructures",
               #"efficientProgramming",
               "expressionEvaluation",
               "inputOutput",
               "objectOrientedProgramming",
               "packageConstruction",
               "stringManipulation",
               "workspaceManagement",
               
               "base",
               "lattice",
               "ggplot2",
               "ggplot2_howtos"
    ))

## For each listed file

## create folder if doesn't exist

## Knit HTML
library("knitr")
library("markdown")
oldBasedir <- opts_knit$get("base.dir")

## Temp files for knitr will be stored there
temp_knitr <- paste0(projectWd, '/dist_doc/temp/')
dir.create(temp_knitr)
opts_knit$set(base.dir = temp_knitr)

## Style (in <head>)
styleConnection <- file(paste0(projectWd, '/help_css/style.txt'))
styleHTMLText <- readLines(styleConnection, n=-1)
styleHTMLText <- paste(styleHTMLText, collapse="\n")
close(styleConnection)

## Header
headerConnection <- file(paste0(projectWd, '/help_css/header.txt'))
headerHTMLText <- readLines(headerConnection, n=-1)
headerHTMLText <- paste(headerHTMLText, collapse="\n")
close(headerConnection)

## Footer
footerConnection <- file(paste0(projectWd, '/help_css/footer.txt'))
footerHTMLText <- readLines(footerConnection, n=-1)
footerHTMLText <- paste(footerHTMLText, collapse="\n")
close(footerConnection)


# fileRmd <- (filesRmd[1, ])
apply(filesRmd, 1, FUN=function(fileRmd) {
    
    current_RmdWd <- paste0(projectWd, '/', fileRmd["directory"])
    current_docWd <- paste0(alldocWd, '/', fileRmd["directory"])
    
    ## HTML output will be created there 
    dir.create(current_docWd)
    
    filePathRmd <- paste0(current_RmdWd, '/', fileRmd["fileName"], '.Rmd')
    filePathMd <- paste0(temp_knitr, '/', fileRmd["fileName"], '.md')
    filePathHtml <- paste0(current_docWd, '/', fileRmd["fileName"], '.html')
    
    knit(filePathRmd, output = filePathMd)
    markdownToHTML(file = filePathMd, output = filePathHtml)
    
    ## Open HTML file to add style, header, footer
    htmlConnection <- file(filePathHtml)
    allHTMLText <- readLines(htmlConnection)
    close(htmlConnection)
    
    ## Add style
    newText <- sub(pattern='<head>', replacement=styleHTMLText, x=allHTMLText, perl=TRUE)
    newText <- sub(pattern='<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>', replacement='', x=newText, fixed=TRUE)
    ## Add header
    newText <- sub(pattern='<body>', replacement=headerHTMLText, x=newText, fixed=TRUE)
    ## Add footer
    newText <- sub(pattern='</body>', replacement=footerHTMLText, x=newText, fixed=TRUE)
    
    write(newText, file=filePathHtml)
    
})

opts_knit$set(base.dir = oldBasedir)


setwd(projectWd)


## Manual step (to be sure...)

## Open project in dist_doc
## Add newly created files
## Commit changes
## Go to : http://chernan.github.io/RNotes4Bioinformatics
## When everything is fine, folder dist_doc can be deleted