library(readr)
library(tidyverse)

df <- read_csv("derived_data/cleaned_user_behavior.csv")

df$gender <- factor(df$gender, levels = c(0, 1), labels = c("Male", "Female"))

means <- df %>%
  group_by(gender) %>%
  summarise(mean_app_time = mean(app_time))

df %>%
  ggplot(aes(x = gender, y = app_time, fill = gender)) +
  geom_violin(trim = FALSE, alpha = 0.5) + 
  geom_boxplot(width = 0.2, outlier.shape = NA) + 
  stat_summary(fun = mean, geom = "crossbar", width = 0.5, fatten = 2, color = "black") +
  geom_segment(aes(x = means$gender[1], y = means$mean_app_time[1], 
                   xend = means$gender[2], yend = means$mean_app_time[2]), 
               color = "red", linetype = "dashed") +
  xlab("Gender") +
  ylab("App Usage (min/day)") +
  ggtitle("App Usage by Gender: Violin Plot with Boxplot and Mean Comparison") +
  labs(fill="Gender")
  theme_minimal()

ggsave("figures/app_usage_by_gender.png",width = 10, height = 7.5)




