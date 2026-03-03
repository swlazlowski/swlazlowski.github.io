rm(list=ls())
# ---- Step 1: Load general libraries and the data ----
library(readr)      # for reading CSV
library(dplyr)      # for data manipulation
library(lubridate)  # for dates
library(stringr)    # for text cleaning

# Path to your file
file_path <- "[MODIFY]/linkedin/Charlotin-hallucination_cases.csv"

# Load the dataset
df <- read_csv(file_path)

# Convert Date column (as character) into proper Date
df <- df %>%
  mutate(Date = ymd(Date),
         Year = year(Date),
         Month = floor_date(Date, "month"))

# ---- Step 2: Visualise number of hallucinations per month ----
library(ggplot2)

cases_by_month <- df %>%
  count(Month)

# ==============================================
# TWO VERTICAL PANES:
# 1) MONTHLY PENALTY COUNTS (STACKED) + TOTAL CASES LINE
# 2) MONTHLY PENALTY COMPOSITION (100%)
# ==============================================

library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(scales)
library(patchwork)

# ---- Multi-penalty classification ----
df_penalty <- df %>%
  mutate(
    penalty_warning = ifelse(
      str_detect(tolower(Outcome),
                 "warning|admonish|caution|show cause(?!.*monetary)"),
      1, 0
    ),
    penalty_financial = ifelse(
      !is.na(`Monetary Penalty`) & str_detect(`Monetary Penalty`, "\\d"),
      1, 0
    ),
    penalty_procedural = ifelse(
      str_detect(tolower(Outcome),
                 "struck|dismiss|default judgment|filing restriction|case dismissed"),
      1, 0
    ),
    penalty_professional = ifelse(
      str_detect(tolower(Outcome),
                 "bar referral|professional sanction|revoked|disqualif|pro hac vice"),
      1, 0
    )
  )

# ---- Monthly total cases ----
monthly_cases <- df_penalty %>%
  group_by(Month) %>%
  summarise(TotalCases = n(), .groups = "drop")

# ---- Long format of penalties ----
penalty_monthly_long <- df_penalty %>%
  select(Month,
         penalty_warning,
         penalty_financial,
         penalty_procedural,
         penalty_professional) %>%
  pivot_longer(
    cols = starts_with("penalty_"),
    names_to = "PenaltyType",
    values_to = "Value"
  ) %>%
  filter(Value == 1) %>%
  group_by(Month, PenaltyType) %>%
  summarise(Count = n(), .groups = "drop")

# Clean labels
penalty_monthly_long$PenaltyType <- recode(penalty_monthly_long$PenaltyType,
                                           "penalty_warning"      = "Warning",
                                           "penalty_financial"    = "Financial Penalty",
                                           "penalty_procedural"   = "Procedural Penalty",
                                           "penalty_professional" = "Professional Penalty"
)

# ---- Monthly penalty composition (100%) ----
penalty_monthly_share <- penalty_monthly_long %>%
  group_by(Month) %>%
  mutate(
    TotalPenalties = sum(Count),
    Share = Count / TotalPenalties
  ) %>%
  ungroup()

# ====================================================
# PLOT 1 — Monthly stacked penalty counts + total cases line
# ====================================================

p1 <- ggplot() +
  
  # stacked penalty bars
  geom_bar(data = penalty_monthly_long,
           aes(x = Month, y = Count, fill = PenaltyType),
           stat = "identity", alpha = 0.85) +
  
  # total cases line
  geom_line(data = monthly_cases,
            aes(x = Month, y = TotalCases, color = "Total Cases"),
            size = 1.3) +
  geom_point(data = monthly_cases,
             aes(x = Month, y = TotalCases, color = "Total Cases"),
             size = 2.4) +
  
  scale_color_manual(values = c("Total Cases" = "black")) +
  scale_y_continuous(
    name = "Number of Penalties",
    sec.axis = sec_axis(~ ., name = "Total Cases")
  ) +
  
  labs(
    title = "Monthly Penalty Counts (Stacked) and Total Cases",
    x = "Month",
    fill = "Penalty Type",
    color = ""
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# ====================================================
# PLOT 2 — Monthly 100% penalty type composition
# ====================================================

p2 <- ggplot(penalty_monthly_share,
             aes(x = Month, y = Share, fill = PenaltyType)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = percent_format()) +
  labs(
    title = "Monthly Composition of Penalty Types (100%)",
    x = "Month",
    y = "Share of Penalties",
    fill = "Penalty Type"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# ====================================================
# VERTICAL LAYOUT (one above the other)
# ====================================================

p1 / p2
