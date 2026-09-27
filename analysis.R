# ============================================================
# Longitudinal PC9 response to erlotinib
# ============================================================

# 1. Load packages
# ------------------------------------------------------------

library(dplyr)
library(ggplot2)


# 2. Import data
# ------------------------------------------------------------

data <- read.csv("data/HTS001.csv")


# 3. Initial data checks
# ------------------------------------------------------------

dim(data)
str(data)

# Check for missing values
sum(is.na(data))


# 4. Define analysis dataset
# ------------------------------------------------------------

# Focus on PC9 cells treated with erlotinib
pc9_erlotinib <- data %>%
  filter(
    drug1 == "erlotinib",
    cell.line == "PC9"
  )


# 5. Longitudinal analysis
# ------------------------------------------------------------

# Calculate the mean and standard deviation of cell count
# for each concentration at each time point.
# There are two physical wells per concentration.

pc9_time_summary <- pc9_erlotinib %>%
  group_by(time, drug1.conc) %>%
  summarise(
    Mean_Cell_Count = mean(cell.count),
    SD_Cell_Count = sd(cell.count),
    .groups = "drop"
  )


# Plot longitudinal cell-count trajectories

ggplot(
  pc9_time_summary,
  aes(
    x = time,
    y = Mean_Cell_Count,
    colour = factor(drug1.conc),
    group = drug1.conc
  )
) +
  geom_line(linewidth = 1) +
  geom_vline(
    xintercept = 50,
    linetype = "dashed"
  ) +
  labs(
    x = "Time (hours)",
    y = "Mean cell count",
    colour = "Erlotinib concentration (M)",
    title = "Longitudinal PC9 cell-count response to erlotinib"
  ) +
  theme_classic()


# Save longitudinal figure

ggsave(
  "figures/longitudinal_response.png",
  width = 7,
  height = 5,
  dpi = 300
)


# 6. Endpoint analysis
# ------------------------------------------------------------

# PC9 measurements at the final available time point
# for this cell line (112.4 hours).

pc9_final <- pc9_erlotinib %>%
  filter(time == 112.4)


# Calculate mean and standard deviation for each concentration

pc9_summary <- pc9_final %>%
  group_by(drug1.conc) %>%
  summarise(
    Mean_Cell_Count = mean(cell.count),
    SD_Cell_Count = sd(cell.count),
    Number_of_Wells = n(),
    .groups = "drop"
  )


# Calculate cell count relative to the lowest concentration

pc9_summary <- pc9_summary %>%
  arrange(drug1.conc) %>%
  mutate(
    Percent_of_lowest =
      (Mean_Cell_Count / first(Mean_Cell_Count)) * 100,
    Fold_Change =
      Mean_Cell_Count / first(Mean_Cell_Count)
  )


# 7. Endpoint figure
# ------------------------------------------------------------

ggplot() +
  # Individual physical wells
  geom_point(
    data = pc9_final,
    aes(
      x = drug1.conc,
      y = cell.count
    ),
    size = 3
  ) +
  
  # Mean +/- SD
  geom_errorbar(
    data = pc9_summary,
    aes(
      x = drug1.conc,
      ymin = Mean_Cell_Count - SD_Cell_Count,
      ymax = Mean_Cell_Count + SD_Cell_Count
    ),
    width = 0.15
  ) +
  
  # Mean cell count
  geom_point(
    data = pc9_summary,
    aes(
      x = drug1.conc,
      y = Mean_Cell_Count
    ),
    size = 4
  ) +
  
  scale_x_log10() +
  
  labs(
    x = "Erlotinib concentration (M)",
    y = "Cell count",
    title = "PC9 cell count after 112.4 hours of erlotinib exposure"
  ) +
  
  theme_classic()


# Save endpoint figure

ggsave(
  "figures/endpoint_response.png",
  width = 7,
  height = 5,
  dpi = 300
)


# 8. Statistical analysis
# ------------------------------------------------------------

# Test for a monotonic association between erlotinib
# concentration and endpoint mean cell count.
#
# Spearman correlation is used because the relationship
# is not assumed to be linear.

spearman_test <- cor.test(
  pc9_summary$drug1.conc,
  pc9_summary$Mean_Cell_Count,
  method = "spearman"
)

spearman_test
