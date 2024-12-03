library(readr)
library(tidyverse)

df <- read_csv("derived_data/cleaned_user_behavior.csv")

df %>%
  ggplot(aes(x = app_time, y = battery_usage, color = as.factor(class))) +
  geom_point() +
  xlab("App Usage Time (min/day)") +
  ylab("Battery Drain (mAh/day)") +
  ggtitle("Relationship Between App Usage Time and Battery Drain by Class") +
  labs(color = "User Behavior Class") 

ggsave("figures/app_usage_vs_battery.png",width = 10, height = 7.5)