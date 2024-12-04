library(readr)
library(tidyverse)
library(gridExtra)

df <- read_csv("derived_data/cleaned_user_behavior.csv")
df$device <- as.numeric(factor(df$device, 
                               levels = c("Google Pixel 5", "iPhone 12", "OnePlus 9", "Samsung Galaxy S21", "Xiaomi Mi 11")))

pca_result <- prcomp(df %>% select(-c(id,class)), center = TRUE, scale. = TRUE)
pca_data <- pca_result$x[, 1:2]  

set.seed(611)
kmeans_result <- kmeans(pca_data, centers = 5)

pca_data <- as.data.frame(pca_data)
pca_data$class <- as.factor(df$class)
pca_data$cluster <- as.factor(kmeans_result$cluster)

plot1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "K-Means Clusters on PCA Data", x = "PC1", y = "PC2") +
  theme_minimal()

plot2 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = class)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "Original Class Labels on PCA Data", x = "PC1", y = "PC2") +
  theme_minimal()


selected_features <- df %>% select(-c(id,class))
standardized_data <- scale(selected_features)
dist_matrix <- dist(standardized_data, method = "manhattan")
hc <- hclust(dist_matrix, method = "ward.D2")
plot(hc, labels = df$class, main = "Dendrogram of Hierarchical Clustering", xlab = "", sub = "")


clusters <- cutree(hc, k = 5)  
df$hierarchical_cluster <- clusters

pca_result <- prcomp(standardized_data, center = TRUE, scale. = TRUE)
pca_data <- as.data.frame(pca_result$x[, 1:2])
pca_data$cluster <- as.factor(clusters)

plot3 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "Hierarchical Clustering on PCA Data", x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal()


p <- grid.arrange(plot2, plot1, plot3, ncol = 3)

ggsave("figures/behavioral_clusters.png",plot = p, width = 12, height = 7.5)




