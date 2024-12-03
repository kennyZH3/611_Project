library(readr)
library(tidyverse)

df <- read_csv("derived_data/cleaned_user_behavior.csv")

df$gender <- as.numeric(df$gender)

df$gender <- factor(df$gender, levels = c(0, 1), labels = c("Male", "Female"))

df %>%
  ggplot(aes(x = device, y = data_usage, fill = gender)) +
  geom_boxplot() +
  xlab("Device") +
  ylab("Data Usage (GB)") +
  ggtitle("Distribution of Data Usage by Device and Gender") +
  labs(fill = "Gender") + 
  theme_minimal()

ggsave("figures/data_usage_by_device_gender.png",width = 10, height = 7.5)




