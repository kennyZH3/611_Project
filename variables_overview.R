library(readr)
library(tidyverse)
library(gridExtra)


df <- read_csv("derived_data/cleaned_user_behavior.csv")

df$os<- factor(df$os, levels = c(0, 1), labels = c("Android", "iOS"))
df$gender <- factor(df$gender, levels = c(0, 1), labels = c("Male", "Female"))
df$class <- as.factor(df$class)

# Define categorical and continuous variables
categorical_vars <- c("device", "os", "gender", "class")
continuous_vars <- c("app_time", "screen_time", "battery_usage", "app_num", "data_usage", "age")

# Create a mapping of variable names to more readable titles
variable_titles <- list(
  device = "Device Models",
  os = "Operating System",
  gender = "Gender",
  class = "User Behavior Class",
  app_time = "App Usage Time (min/day)",
  screen_time = "Screen On Time (min/day)",
  battery_usage = "Battery Drain (mAh/day)",
  app_num = "Number of Apps Installed",
  data_usage = "Data Usage (MB/day)",
  age = "Age"
)

# Create list to store all plots
plot_list <- list()

# Create pie charts for categorical variables
for (var in categorical_vars) {
  df_cat <- df %>%
    group_by(!!sym(var)) %>%
    summarise(count = n()) %>%
    mutate(percentage = round(100 * count / sum(count), 1))
  
  p <- ggplot(df_cat, aes(x = "", y = count, fill = !!sym(var))) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y") +
    labs(title = paste("Pie Chart of", variable_titles[[var]]), fill = variable_titles[[var]]) +
    geom_text(aes(label = paste0(percentage, "%")), position = position_stack(vjust = 0.5)) +
    theme_void() +
    theme(legend.position = "right")
  
  plot_list[[length(plot_list) + 1]] <- p
}

# Create histograms for continuous variables
for (var in continuous_vars) {
  p <- ggplot(df, aes(x = !!sym(var))) +
    geom_histogram(aes(y = ..density..), bins = 20, fill = "skyblue", color = "black", alpha = 0.6) +
    geom_density(color = "red", size = 1) +
    labs(title = paste("Histogram of", variable_titles[[var]]), x = variable_titles[[var]], y = "Density") +
    theme_minimal()
  
  plot_list[[length(plot_list) + 1]] <- p
}


png("figures/user_behavior_summary.png", width = 1600, height = 1200)
grid.arrange(grobs = plot_list, ncol = 3)
dev.off()