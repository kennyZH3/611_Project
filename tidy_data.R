library(dplyr)
library(readr)
data <- readr::read_csv("user_behavior_dataset.csv")

# Rename the columns
data <- data %>%
  rename(id = `User ID`, 
         device = `Device Model`,
         os = `Operating System`,
         app_time = `App Usage Time (min/day)`,
         screen_time = `Screen On Time (hours/day)`,
         battery_usage = `Battery Drain (mAh/day)`,
         app_num = `Number of Apps Installed`,
         data_usage = `Data Usage (MB/day)`,
         age = Age,
         gender = Gender,
         class = `User Behavior Class`)

data$gender[data$gender == "Male"] <- 1
data$gender[data$gender == "Female"] <- 0
data$gender <- as.numeric(data$gender)

data$os[data$os == "iOS"] <- 1
data$os[data$os == "Android"] <- 0
data$os <- as.numeric(data$os)

# Check if there are any NAs
print(any(is.na(data)))

write_csv(data, "./derived_data/cleaned_user_behavior.csv")

