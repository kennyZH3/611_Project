library(readr)
library(tidyverse)
library(nnet)
library(gbm)



df <- read_csv("derived_data/cleaned_user_behavior.csv")

df$device <- as.numeric(factor(df$device, 
                               levels = c("Google Pixel 5", "iPhone 12", "OnePlus 9", "Samsung Galaxy S21", "Xiaomi Mi 11")))
df <- df %>% select(-id)
df$device <- as.factor(df$device)

set.seed(611)  
sample_idx <- sample(1:nrow(df), size = 0.7 * nrow(df))  

training <- df[sample_idx, ]
test <- df[-sample_idx, ]

# Baseline model - Random Guess

set.seed(611)
class_labels <- unique(training$class)
random_predictions <- sample(class_labels, nrow(test), replace = TRUE)

accuracy <- mean(random_predictions == test$class)
print(paste("Baseline Accuracy (Random Guess):", round(accuracy * 100, 2), "%"))


# Multinomial Logistic Regression

mn <- multinom(class ~., data = training)
mn_pred <- predict(mn, newdata = test)

confusion_matrix <- table(mn_pred, test$class)

mn_accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Test Accuracy:", round(mn_accuracy * 100, 2), "%"))

# GBM

gbm_model <- gbm(class ~ ., 
                 data = training, 
                 distribution = "multinomial",  
                 n.trees = 100,  
                 interaction.depth = 3,  
                 shrinkage = 0.1,  
                 cv.folds = 5)

gbm_pred <- predict(gbm_model, newdata = test, type = "response")
gbm_pred_class <- apply(gbm_pred, 1, which.max)  

confusion_matrix <- table(gbm_pred_class, test$class)
gbm_accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Test Accuracy:", round(gbm_accuracy * 100, 2), "%"))

# Result Comparison

result_df <- data.frame(
  Model = factor(c("Baseline", "Multinomial Logistic Regression", "Gradient Boosting Machines"),
                         levels = c("Baseline", "Multinomial Logistic Regression", "Gradient Boosting Machines")),
  Accuracy = c(accuracy, mn_accuracy, gbm_accuracy)
)

ggplot(result_df, aes(x = Model, y = Accuracy, fill = Model)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = paste0(round(Accuracy * 100, 2), "%")), vjust = -0.5) +
  labs(title = "Model Performance Comparison") +
  theme_minimal()

ggsave("figures/classification.png",width = 10, height = 7.5)


