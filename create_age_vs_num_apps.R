library(readr)
library(tidyverse)

df <- read_csv("derived_data/cleaned_user_behavior.csv")

df %>% ggplot(aes(x = age, y = app_num, color = as.factor(class), size = screen_time)) + 
  geom_point(alpha = 0.6) +
  xlab("Age") +
  ylab("Number of Apps Installed") +
  labs(title = "Relationship between user age and number of apps installed", 
       color = "User Behavior Class", 
       size = "Screen On Time (hours/day)") +
  theme_minimal()
  
ggsave("figures/age_vs_num_apps.png",width = 10, height = 7.5)






