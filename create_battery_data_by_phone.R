library(readr)
library(tidyverse)


df <- read_csv("derived_data/cleaned_user_behavior.csv")

df %>%
  group_by(device) %>%
  summarise(`Average Battery Drain (mAh/day)` = mean(battery_usage),
            `Average Data Usage (MB/day)` = mean(data_usage)) %>%
  pivot_longer(cols = starts_with("Ave"), names_to = "Metric", values_to = "value") %>%
  ggplot(aes(x = device, y = value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Phone Type") +
  ylab("Average Value") +
  ggtitle("Average Battery Drain and Data Use by Phone Type") +
  theme_minimal()+
  theme(axis.text.x = element_text(angle=45, vjust=1, hjust=1))

ggsave("figures/battery_data_by_phone.png",width = 10, height = 7.5)
