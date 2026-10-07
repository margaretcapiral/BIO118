# BIO 118 Laboratory Exercise 4C
# Multivariate Analysis: PCA and Clustering

# 4.1. Loading and Exploring the Dataset
# 4.1.1 Load the iris dataset

data(iris)
?iris

head(iris)
str(iris)
summary(iris)

# 4.2. Principal Component Analysis

# 4.2.1 Select the Numerical Variables
iris_data <- iris[, 1:4]
head(iris_data)

# 4.2.2 Perform PCA
pca_result <- prcomp(
  iris_data,
  center = TRUE,
  scale. = TRUE
)
# examine the results
names(pca_result)
str(pca_result)
# view PCA scores
head(pca_result$x)
# examine the variation
summary(pca_result)

# 4.2.3 Visualize the PCA Results
pca_result$x
# convert PCA scores to a data frame
pca_scores <- as.data.frame(pca_result$x)
# add the species information
pca_scores$Species <- iris$Species # check the result
head(pca_scores)
# bring Species info back into PCA scores df
# create a PCA score plot
library(ggplot2)
ggplot(pca_scores, aes(x = PC1, y = PC2, color = Species)) +
  geom_point() +
  labs(
    title = "PCA of Iris Measurements",
    x = "PC1",
    y = "PC2",
    color = "Species"
  ) +
  theme_classic()

# 4.2.4 Using ggfortify to visualize PCA biplot
library(ggplot2)
library(ggfortify)
# 1. Run your standard PCA model
pca_model <- prcomp(iris[, 1:4], center = TRUE, scale. = TRUE)
# 2. Plot the biplot and add the title layers
autoplot(pca_model,
         data = iris,
         colour = 'Species',
         loadings = TRUE,
         loadings.label = TRUE,
         loadings.colour = 'black',
         loadings.label.colour = 'black'
) +
  theme_minimal() +
  labs(
    prcomp()",
title = "Principal Component Analysis (PCA) on Iris Dataset",
subtitle = "Reducing 4 physical measurements down to 2 dimensions using
    caption = "Data source: Built-in R Iris dataset",
    colour = "Flower Species" # This updates the legend title cleanly
  )

# 4.3 Hierarchical Clustering

# 4.3.1 Standardize the numerical variables and calculate distances

# standardize the numerical variables
iris_scaled <- scale(iris_data)
# calculate Euclidean distance
dist_matrix <- dist(
  iris_scaled,
  method = "euclidean"
)

# 4.3.2 Perform hierarchical clustering
hclust_result <- hclust(
  dist_matrix,
  method = "complete"
)

# 4.3.3 Visualize the Dendrogram
plot(
  hclust_result,
  labels = FALSE,
  main = "Hierarchical Clustering of Iris Flowers",
  xlab = "Observations",
  ylab = "Height"
)

# 4.3.4 Create Three Clusters
# create three clusters
groups <- cutree(
  hclust_result,
  k = 3)
# create dendrogram showing three clusters
plot(
  hclust_result,
  labels=FALSE,
  main="Hierarchical Clustering of Iris Flowers",
  xlab="Observations",
  ylab="Height"
)
rect.hclust(hclust_result, k=3)
# add cluster assignments to the dataset
iris$Cluster <- as.factor(groups)
# view results
head(iris)
# create contingency table
table(
  iris$Species,
  iris$Cluster
)

# 4.4 K-means Clustering

# 4.4.1 Perform K-means Clustering
# set a seed
set.seed(123)
# perform k-means clustering
kmeans_result <- kmeans(
  iris_scaled,
  centers = 3,
  nstart = 20
)
# inspect the object
kmeans_result
names(kmeans_result)
head(kmeans_result$cluster)
# add clustering assignments
iris$KMeans_Cluster <- as.factor(
  kmeans_result$cluster
)
# check results
head(iris)
table(iris$Species, iris$KMeans_Cluster)

# 4.4.2 Visualizing K-means Clustering
ggplot(
  iris,
  aes(
    x = Petal.Length,
    y = Petal.Width,
    color = KMeans_Cluster
  )
) +
  geom_point() +
  labs(
    title = "K-means Clustering of Iris Flowers",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)",
    color = "Cluster"
  ) +
  theme_classic()
# create contingency table
table(
  iris$Species,
  iris$KMeans_Cluster
)






