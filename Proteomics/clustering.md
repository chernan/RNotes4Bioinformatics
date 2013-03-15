Clustering methods
========================================================

Methods for clustering (finding groups inside data) are multiple. They often need to know in advance the number of groups in which data have to be partitioned. In that case, they are called supervised clustering methods (e.g. k-means, spectral clustering). 

This domain is not specific to proteomics, but is widely applied to proteomics results, especially in protein quantitation.


Hierarchical clustering
--------------------------------------------------------------------------------

Hierarchical clustering is an unsupervised method, in the sense that it doesn't need a priori to know how many groups are in the data. It just creates a tree based on how close each element is from another. 
A given tree obtained by hierarchival clustering can be subsequently cut in order to obtain the desired number of groups.



```r
## For this chapter, we will use the Iris dataset We will cluster the
## values, and see if they cluster according to their species
data(iris)
irisValues <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]
```



### Computing distances

Before any clustering, meaning before any grouping of the data, one has to compute distances between the elements to be clustered. This is usually achieved by the dist() function.


```r
distances <- as.matrix(dist(irisValues, method = "euclidean"))
```



### Hierarchical clustering

From the distances, we can compute a hierarchy.


```r
hclustTree <- hclust(as.dist(distances))
```



### Plotting dendrograms from distances

The object returned by hclust() can directly be plotted using the base graphics package.


```r
plot(hclustTree)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


Alternatively, the object of class "hclust" returned by a call to hclust() can be turned into a dendrogram. Plotting dendrograms offer more possibilities and accessible parameters.


```r
dendrogram1 <- as.dendrogram(hclustTree)
plot(dendrogram1, nodePar = list(lab.cex = 0.7), horiz = TRUE)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 



### Getting k clusters

A tree can be cut in order to get a given number of groups.


```r
threeGroups <- cutree(hclustTree, k = 3)
```


This partitioning can also be plotted.


```r
## Draw dendogram
plot(hclustTree)
## Draw red borders around the k clusters
rect.hclust(hclustTree, k = 3, border = "red")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


We can compare this partitioning with the species of each observation.

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-81.png) ![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-82.png) ![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-83.png) ![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-84.png) 


Knowing that a tree also has a height, one can cut the tree according to a desired height, or get all groups corresponding to a set of height.



```r
woodSlices <- cutree(hclustTree, h = 1:floor(max(hclustTree$height)))
## Display the groups of the first 20 observations.
woodSlices[1:20, ]
```

```
##    1 2 3 4 5 6 7
## 1  1 1 1 1 1 1 1
## 2  1 1 1 1 1 1 1
## 3  2 1 1 1 1 1 1
## 4  2 1 1 1 1 1 1
## 5  1 1 1 1 1 1 1
## 6  3 2 1 1 1 1 1
## 7  2 1 1 1 1 1 1
## 8  1 1 1 1 1 1 1
## 9  2 1 1 1 1 1 1
## 10 1 1 1 1 1 1 1
## 11 3 2 1 1 1 1 1
## 12 4 2 1 1 1 1 1
## 13 1 1 1 1 1 1 1
## 14 2 1 1 1 1 1 1
## 15 5 2 1 1 1 1 1
## 16 5 2 1 1 1 1 1
## 17 5 2 1 1 1 1 1
## 18 1 1 1 1 1 1 1
## 19 3 2 1 1 1 1 1
## 20 4 2 1 1 1 1 1
```


--------------------------------------------------------------------------------

K-means clustering
--------------------------------------------------------------------------------

This is a supervised clustering, one has to specify a number of groups before performing the clustering.


```r
## Set clusters number
nbClusters4kmeans <- 3
## Maximal number of iterations
nbMaxIteration <- 100
## Algorithm to be used
algo <- "Hartigan-Wong"

# Compute clustering
kmeansClust <- kmeans(irisValues, centers = nbClusters4kmeans, iter.max = nbMaxIteration, 
    algorithm = algo)
kmeansThreeGroups <- kmeansClust$cluster
```


We can also compare the clustering obtained by this method with the real clustering by species.

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-111.png) ![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-112.png) ![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-113.png) ![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-114.png) 


Other methods are available in the 'cluster' package (pam).

-------------------------------------------------------------------------------- 

Evidence Accumulation Clustering
-------------------------------------------------------------------------------- 

An interesting method described here:
http://things-about-r.tumblr.com/post/43894016034/the-wisdom-of-crowds-clustering-using-evidence

More information here:
http://www.cs.msu.edu/prip/ResearchProjects/cluster_research/papers/AFred_AJain_ICPR2002.pdf
and there:
http://web.cse.msu.edu/prip/Files/AFred_AJain_SSPR2002.pdf




```r
createCoAssocMatrix <- function(Iter, rangeK, dataSet) {
    nV <- dim(dataSet)[1]
    CoAssoc <- matrix(rep(0, nV * nV), nrow = nV)
    
    for (j in 1:Iter) {
        jK <- sample(c(rangeK[1]:rangeK[2]), 1, replace = FALSE)
        jSpecCl <- kmeans(x = dataSet, centers = jK)$cluster
        CoAssoc_j <- matrix(rep(0, nV * nV), nrow = nV)
        for (i in unique(jSpecCl)) {
            indVenues <- which(jSpecCl == i)
            CoAssoc_j[indVenues, indVenues] <- CoAssoc_j[indVenues, indVenues] + 
                (1/Iter)
        }
        CoAssoc <- CoAssoc + CoAssoc_j
    }
    return(CoAssoc)
}

eac <- function(Iter, rangeK, dataset, hcMethod = "single") {
    CoAssocSim <- createCoAssocMatrix(Iter, rangeK, dataset)
    
    # transform from similiarity into distance matrix
    CoAssocDist <- 1 - CoAssocSim
    hclustM <- hclust(as.dist(CoAssocDist), method = hcMethod)
    # determine the cut
    cutValue <- hclustM$height[which.max(diff(hclustM$height))]
    return(cutree(hclustM, h = cutValue))
}
```



```r
set.seed(1234)
testClusterMeth <- eac(Iter = 100, rangeK = c(2, 25), dataset = irisValues, 
    hcMethod = "single")
table(testClusterMeth)
```

```
## testClusterMeth
##   1   2 
##  50 100
```


![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-141.png) ![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-142.png) ![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-143.png) ![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-144.png) 



--------------------------------------------------------------------------------

Problem of supervised clustering
--------------------------------------------------------------------------------

The main problem with supervised clustering, or clustering data in k groups, is that in discovery mode there is no a priori knowledge of the real number of groups. Moreover, each clustering method giving a different clustering of the data it is very difficult to decide whether a given partitioning is relevant or not.

One approach is to use a metric/score to evaluate clustering outputs. There exists a set of well known criteria, like the “Dunn-Index”, the “Calinski-Harabasz-Index”, the "Silhouette measure". 

In the case of k-means clustering, a simplistic approach is to minimize the total distance between the elements of each cluster.


```r
## Maximal number of iterations
nbMaxIteration <- 100
## Algorithm to be used
algo <- "Hartigan-Wong"

distWithins <- vapply(2:25, FUN.VALUE = c(Within = 0), FUN = function(nbClusters) {
    return(kmeans(irisValues, centers = nbClusters, iter.max = 100, algorithm = "Hartigan-Wong")$tot.withinss)
})
plot(x = 2:25, y = distWithins, pch = 16, type = "b")
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 



Other scores are available in the clusterCrit package.



