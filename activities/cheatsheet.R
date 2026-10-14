
############################################################
#             STATISTICS EXAM CHEAT SHEET
#                    RSTUDIO / R
############################################################

# ==========================================================
# 1. LOAD PACKAGES AND DATASETS
# ==========================================================

# Install once if needed:
# install.packages("tidyverse")

library(tidyverse)

# Load CSV from computer:
# data <- read_csv("filename.csv")

# Load CSV from website:
# data <- read_csv("https://example.com/data.csv")

# Example dataset to practice with:
data <- mtcars

# View entire dataset
View(data)

# First 6 rows
head(data)

# Last 6 rows
tail(data)

# Number of rows
nrow(data)

# Number of columns
ncol(data)

# Column names
names(data)

# Structure of dataset
str(data)

# Summary of dataset
summary(data)

# IMPORTANT:
# For the examples below:
# data = dataset
# mpg = numerical variable
# cyl = categorical/grouping variable
# Replace these with your actual exam variables.


# ==========================================================
# 2. DESCRIPTIVE STATISTICS
# ==========================================================

# Mean
mean(data$mpg, na.rm = TRUE)

# Median
median(data$mpg, na.rm = TRUE)

# Standard deviation
sd(data$mpg, na.rm = TRUE)

# Variance
var(data$mpg, na.rm = TRUE)

# Minimum
min(data$mpg, na.rm = TRUE)

# Maximum
max(data$mpg, na.rm = TRUE)

# Range
range(data$mpg, na.rm = TRUE)

# Interquartile range (IQR)
IQR(data$mpg, na.rm = TRUE)

# Number of nonmissing observations
sum(!is.na(data$mpg))

# All statistics at once
data %>%
  summarise(
    mean = mean(mpg, na.rm = TRUE),
    median = median(mpg, na.rm = TRUE),
    sd = sd(mpg, na.rm = TRUE),
    variance = var(mpg, na.rm = TRUE),
    minimum = min(mpg, na.rm = TRUE),
    maximum = max(mpg, na.rm = TRUE),
    IQR = IQR(mpg, na.rm = TRUE),
    n = sum(!is.na(mpg))
  )


# ==========================================================
# 3. Z-SCORES
# ==========================================================

# FORMULA:
# z = (x - mean) / standard deviation

# Example
x <- 85
mu <- 75
sigma <- 10

z <- (x - mu) / sigma
z

# Calculate z-score using dataset statistics
x <- 25

z <- (x - mean(data$mpg, na.rm = TRUE)) /
  sd(data$mpg, na.rm = TRUE)

z

# Calculate z-scores for every observation
data <- data %>%
  mutate(z_score = as.numeric(scale(mpg)))

# INTERPRETATION:
# z = 0: exactly at mean
# z > 0: above mean
# z < 0: below mean
# z = 2: two standard deviations above mean


# ==========================================================
# 4. NORMAL DISTRIBUTIONS / PROBABILITIES
# ==========================================================

# pnorm = probability BELOW a value
# qnorm = value associated with a percentile
# rnorm = generate random normal observations
# dnorm = height of normal density curve

# Probability BELOW z = 1.5
pnorm(1.5)

# Probability ABOVE z = 1.5
1 - pnorm(1.5)

# Probability BETWEEN z = -1 and z = 1
pnorm(1) - pnorm(-1)

# Probability BELOW X = 120
# Mean = 100, SD = 15
pnorm(120, mean = 100, sd = 15)

# Probability ABOVE X = 120
1 - pnorm(120, mean = 100, sd = 15)

# Probability BETWEEN 85 and 115
pnorm(115, mean = 100, sd = 15) -
  pnorm(85, mean = 100, sd = 15)

# Find z-score for 95th percentile
qnorm(0.95)

# Find value for 90th percentile
qnorm(0.90, mean = 100, sd = 15)

# Generate 1000 normal observations
set.seed(123)
normal_data <- rnorm(1000, mean = 100, sd = 15)


# ==========================================================
# 5. POPULATION PROPORTIONS / PERCENTAGES
# ==========================================================

# FORMULA:
# p_hat = number of successes / sample size

# Example: 120 out of 500 said YES
x <- 120
n <- 500

p_hat <- x / n
p_hat

# Convert proportion to percentage
p_hat * 100

# Proportion satisfying a condition
mean(data$mpg > 20, na.rm = TRUE)

# Percentage satisfying a condition
mean(data$mpg > 20, na.rm = TRUE) * 100

# Count each category
table(data$cyl)

# Proportion of each category
prop.table(table(data$cyl))

# Percentage of each category
prop.table(table(data$cyl)) * 100

# Tidyverse counts and proportions
data %>%
  count(cyl) %>%
  mutate(
    proportion = n / sum(n),
    percentage = proportion * 100
  )

# Example: proportion of cars with 6 cylinders
mean(data$cyl == 6, na.rm = TRUE)


# ==========================================================
# 6. RANDOM SAMPLING
# ==========================================================

# Makes random results reproducible
set.seed(123)

# Random sample of 10 rows
sample_data <- data %>%
  slice_sample(n = 10)

# Random sample of 20% of dataset
sample_data <- data %>%
  slice_sample(prop = 0.20)

# Random sample WITH replacement
sample_data <- data %>%
  slice_sample(n = 100, replace = TRUE)

# Random sample WITHOUT replacement
sample_data <- data %>%
  slice_sample(n = 10, replace = FALSE)

# Randomly sample 50 numbers from 1:1000
sample(1:1000, size = 50)

# Calculate mean of random sample
mean(sample_data$mpg, na.rm = TRUE)

# Calculate sample proportion
mean(sample_data$mpg > 20, na.rm = TRUE)

# REMEMBER:
# replace = TRUE: observations can repeat
# replace = FALSE: observations cannot repeat
# set.seed(): reproduces random results


# ==========================================================
# 7. PERCENTILES / QUARTILES / IQR
# ==========================================================

# 10th percentile
quantile(data$mpg, 0.10, na.rm = TRUE)

# 25th percentile (Q1)
quantile(data$mpg, 0.25, na.rm = TRUE)

# 50th percentile (median)
quantile(data$mpg, 0.50, na.rm = TRUE)

# 75th percentile (Q3)
quantile(data$mpg, 0.75, na.rm = TRUE)

# 90th percentile
quantile(data$mpg, 0.90, na.rm = TRUE)

# 95th percentile
quantile(data$mpg, 0.95, na.rm = TRUE)

# All quartiles
quantile(data$mpg, na.rm = TRUE)

# Multiple percentiles together
quantile(
  data$mpg,
  probs = c(0.10, 0.25, 0.50, 0.75, 0.90),
  na.rm = TRUE
)

# Interquartile range
IQR(data$mpg, na.rm = TRUE)

# Percentile rank of value 25
mean(data$mpg <= 25, na.rm = TRUE) * 100

# REMEMBER:
# Q1 = 25th percentile
# Q2 = 50th percentile = median
# Q3 = 75th percentile
# IQR = Q3 - Q1


# ==========================================================
# 8. GGPLOT HISTOGRAMS
# ==========================================================

# Basic histogram
ggplot(data, aes(x = mpg)) +
  geom_histogram()

# Histogram with 20 bins
ggplot(data, aes(x = mpg)) +
  geom_histogram(bins = 20)

# Histogram with bin width = 5
ggplot(data, aes(x = mpg)) +
  geom_histogram(binwidth = 5)

# Customized histogram
ggplot(data, aes(x = mpg)) +
  geom_histogram(
    bins = 15,
    fill = "skyblue",
    color = "black"
  ) +
  labs(
    title = "Distribution of MPG",
    x = "Miles Per Gallon",
    y = "Frequency"
  ) +
  theme_minimal()

# Histogram with density curve
ggplot(data, aes(x = mpg)) +
  geom_histogram(
    aes(y = after_stat(density)),
    bins = 15
  ) +
  geom_density(color = "red")


# ==========================================================
# 9. GGPLOT OTHER GRAPHS
# ==========================================================

# BAR CHART (categorical variable)
ggplot(data, aes(x = factor(cyl))) +
  geom_bar()

# SCATTERPLOT (two numeric variables)
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point()

# SCATTERPLOT WITH TREND LINE
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# BOXPLOT
ggplot(data, aes(y = mpg)) +
  geom_boxplot()

# BOXPLOT BY GROUP
ggplot(data, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot()

# LINE GRAPH
# Use when x represents ordered values or time
ggplot(data, aes(x = wt, y = mpg)) +
  geom_line()

# DENSITY PLOT
ggplot(data, aes(x = mpg)) +
  geom_density()

# ADD TITLES AND LABELS
ggplot(data, aes(x = mpg)) +
  geom_histogram(bins = 15) +
  labs(
    title = "My Graph",
    x = "X Axis",
    y = "Y Axis"
  ) +
  theme_minimal()

# Save most recent graph
ggsave("my_graph.png", width = 8, height = 5)

# REMEMBER:
# geom_histogram() = numeric distributions
# geom_bar() = categorical counts
# geom_point() = scatterplots
# geom_boxplot() = boxplots
# geom_line() = line graphs


# ==========================================================
# 10. FILTER / SELECT / MUTATE / ARRANGE
# ==========================================================

# Filter observations greater than 20
data %>%
  filter(mpg > 20)

# Filter observations equal to category
data %>%
  filter(cyl == 6)

# Filter multiple conditions
data %>%
  filter(mpg > 20, cyl == 4)

# Select specific columns
data %>%
  select(mpg, cyl, wt)

# Create a new variable
data %>%
  mutate(double_mpg = mpg * 2)

# Sort ascending
data %>%
  arrange(mpg)

# Sort descending
data %>%
  arrange(desc(mpg))

# Count categories
data %>%
  count(cyl)

# Count categories highest to lowest
data %>%
  count(cyl, sort = TRUE)

# Remove missing observations
data %>%
  filter(!is.na(mpg))


# ==========================================================
# 11. GROUP_BY AND SUMMARISE
# ==========================================================

# Mean by category
data %>%
  group_by(cyl) %>%
  summarise(
    mean_mpg = mean(mpg, na.rm = TRUE)
  )

# Mean, median, SD, and count by category
data %>%
  group_by(cyl) %>%
  summarise(
    mean = mean(mpg, na.rm = TRUE),
    median = median(mpg, na.rm = TRUE),
    sd = sd(mpg, na.rm = TRUE),
    n = n()
  )

# Count categories
data %>%
  count(cyl)

# Frequency table
table(data$cyl)

# Cross-tabulation
table(data$cyl, data$gear)


# ==========================================================
# 12. SAMPLING DISTRIBUTIONS / SIMULATIONS
# ==========================================================

set.seed(123)

# Simulate 1000 sample means
# Each sample contains 20 observations
sample_means <- replicate(
  1000,
  mean(sample(data$mpg,
              size = 20,
              replace = TRUE))
)

# Average of simulated means
mean(sample_means)

# SD of simulated sample means
sd(sample_means)

# Plot sampling distribution
ggplot(tibble(sample_mean = sample_means),
       aes(x = sample_mean)) +
  geom_histogram(bins = 30)

# SIMULATE POPULATION PROPORTIONS

# Population proportion = 10%
# Sample size = 100
# Repeat 1000 times

sample_props <- replicate(
  1000,
  mean(rbinom(
    n = 100,
    size = 1,
    prob = 0.10
  ))
)

# Average sample proportion
mean(sample_props)

# SD of sample proportions
sd(sample_props)

# Plot sampling distribution
ggplot(tibble(prop = sample_props),
       aes(x = prop)) +
  geom_histogram(bins = 25)

# REMEMBER:
# replicate() repeats a calculation
# rbinom() generates binomial random values
# mean(rbinom(n, 1, p)) = simulated sample proportion


# ==========================================================
# 13. STANDARD ERROR
# ==========================================================

# Standard error of the sample mean
# SE = sample SD / sqrt(sample size)

s <- sd(data$mpg, na.rm = TRUE)
n <- sum(!is.na(data$mpg))

SE <- s / sqrt(n)
SE

# Standard error of sample proportion
# SE = sqrt(p_hat * (1 - p_hat) / n)

p_hat <- 0.40
n <- 200

SE_prop <- sqrt(p_hat * (1 - p_hat) / n)
SE_prop


# ==========================================================
# 14. CONFIDENCE INTERVALS
# ==========================================================

# 95% confidence interval for mean
# Uses t distribution and sample SD

xbar <- mean(data$mpg, na.rm = TRUE)
s <- sd(data$mpg, na.rm = TRUE)
n <- sum(!is.na(data$mpg))

SE <- s / sqrt(n)

margin <- qt(0.975, df = n - 1) * SE

lower <- xbar - margin
upper <- xbar + margin

lower
upper

# Built-in 95% confidence interval for mean
t.test(data$mpg)

# Approximate 95% CI for population proportion
p_hat <- 0.40
n <- 200

SE_prop <- sqrt(p_hat * (1 - p_hat) / n)

lower <- p_hat - 1.96 * SE_prop
upper <- p_hat + 1.96 * SE_prop

lower
upper

# Built-in proportion confidence interval
prop.test(x = 80, n = 200,
          correct = FALSE)


# ==========================================================
# 15. HYPOTHESIS TESTING
# ==========================================================

# ONE-SAMPLE T-TEST
# H0: population mean = 20
t.test(data$mpg, mu = 20)

# TWO-SAMPLE T-TEST
# Compare mean mpg for two cylinder groups
two_groups <- data %>%
  filter(cyl %in% c(4, 6))

t.test(mpg ~ cyl, data = two_groups)

# CORRELATION
cor(data$mpg, data$wt,
    use = "complete.obs")

# CHI-SQUARE TEST
tab <- table(data$cyl, data$gear)
chisq.test(tab)

# ONE-SAMPLE PROPORTION TEST
# H0: population proportion = 0.50
prop.test(
  x = 60,
  n = 100,
  p = 0.50,
  correct = FALSE
)

# EXACT BINOMIAL TEST
binom.test(
  x = 60,
  n = 100,
  p = 0.50
)

# REMEMBER:
# p-value < 0.05: reject H0 at alpha = 0.05
# p-value >= 0.05: fail to reject H0


# ==========================================================
# 16. MOST IMPORTANT FUNCTIONS TO MEMORIZE
# ==========================================================

# LOAD DATA
# library(tidyverse)
# read_csv("filename.csv")
# View(data)
# head(data)
# summary(data)

# DESCRIPTIVE STATISTICS
# mean(x)
# median(x)
# sd(x)
# var(x)
# min(x)
# max(x)
# IQR(x)
# nrow(data)

# Z-SCORES
# (x - mu) / sigma
# scale(x)

# PROBABILITIES
# pnorm(z)       = probability below z
# 1 - pnorm(z)   = probability above z
# qnorm(p)       = z-score for percentile p
# rnorm(n)       = random normal observations

# PROPORTIONS
# x / n
# mean(condition)
# prop.table(table(x))

# PERCENTILES
# quantile(x, 0.25)
# quantile(x, 0.50)
# quantile(x, 0.75)
# quantile(x, 0.90)

# SAMPLING
# set.seed(123)
# sample(x, size = 10)
# slice_sample(n = 10)
# slice_sample(prop = 0.10)
# slice_sample(n = 10, replace = TRUE)

# GGPLOT
# ggplot(data, aes(x = variable))
# geom_histogram()
# geom_bar()
# geom_point()
# geom_boxplot()
# geom_line()
# geom_density()
# labs(title = "", x = "", y = "")
# theme_minimal()

# TIDYVERSE
# filter()
# select()
# mutate()
# arrange()
# count()
# group_by()
# summarise()

# SIMULATIONS
# replicate()
# rnorm()
# rbinom()

# HYPOTHESIS TESTS
# t.test()
# prop.test()
# binom.test()
# chisq.test()
# cor()


# ==========================================================
# 17. EXAM REMINDERS
# ==========================================================

# na.rm = TRUE ignores missing values
# %>% passes results to the next operation
# == means equals
# != means not equal
# > means greater than
# < means less than
# >= means greater than or equal to
# <= means less than or equal to
# & means AND
# | means OR

# pnorm() = probability from a value
# qnorm() = value from a probability

# mean(condition) = proportion meeting condition
# mean(condition) * 100 = percentage

# Histograms = numerical variables
# Bar charts = categorical variables
# Scatterplots = two numerical variables

# Positive z-score = above mean
# Negative z-score = below mean

# Q1 = 25th percentile
# Q2 = median
# Q3 = 75th percentile

# Standard error decreases as sample size increases

# IMPORTANT:
# Replace dataset and column names with your own.
# R is case-sensitive: Age and age are different.

############################################################
#                END OF CHEAT SHEET
############################################################


############################################################
#          JOUR405 STATISTICS EXAM CHEAT SHEET
#               COMPLETE RSTUDIO REFERENCE
############################################################

# TOPICS:
# 1. Loading Packages and Datasets
# 2. Exploring and Cleaning Data
# 3. Descriptive Statistics
# 4. Filtering, Selecting, and Mutating
# 5. Grouping and Summarizing
# 6. Population Proportions and Crime Rates
# 7. Random Sampling
# 8. Polling Simulations
# 9. Z-Scores
# 10. Normal Distributions and Probability
# 11. Percentiles and Quartiles
# 12. Correlation and Correlation Tests
# 13. GGPlot Histograms
# 14. GGPlot Scatterplots
# 15. Bar Charts, Line Graphs, and Heatmaps
# 16. Dates and Formatting
# 17. Common Mistakes
# 18. Quick Exam Reference

# ==========================================================
# 1. LOADING PACKAGES AND DATASETS
# ==========================================================

# Install packages ONLY ONCE:
# install.packages("tidyverse")
# install.packages("janitor")
# install.packages("lubridate")

# Load packages every new R session:
library(tidyverse)
library(janitor)
library(lubridate)

# Load CSV from computer:
# data <- read_csv("filename.csv")

# Load CSV from GitHub:
# data <- read_csv("https://raw.githubusercontent.com/
# username/repository/main/data/filename.csv")

# ACTUAL JOUR405 CES DATASET:
ces <- read_csv(
  "https://raw.githubusercontent.com/dwillis/jour405/refs/heads/main/data/ces_2024_religion.csv"
)

# Example built-in dataset for practicing:
data <- as_tibble(mtcars)

# IMPORTANT:
# Replace data with your dataset name.
# Replace mpg with your numeric variable.
# Replace cyl with your grouping variable.

# ==========================================================
# 2. EXPLORING AND CLEANING DATA
# ==========================================================

# View dataset in RStudio
View(data)

# First 6 rows
head(data)

# Last 6 rows
tail(data)

# Number of rows
nrow(data)

# Number of columns
ncol(data)

# Column names
names(data)

# Structure and data types
str(data)

# Summary of all columns
summary(data)

# CLEAN COLUMN NAMES
# Requires library(janitor)

# Converts "Grand Total" to "grand_total"
data <- data |>
  clean_names()

# REMOVE MISSING VALUES
# Drops rows with NA in any column
clean_data <- data |>
  drop_na()

# Drop NA only for specified columns
clean_data <- data |>
  drop_na(mpg, wt)

# R is case-sensitive:
# Population and population are different.

# ==========================================================
# 3. DESCRIPTIVE STATISTICS
# ==========================================================

# MEAN = average
mean(data$mpg, na.rm = TRUE)

# MEDIAN = middle value
median(data$mpg, na.rm = TRUE)

# STANDARD DEVIATION = spread
sd(data$mpg, na.rm = TRUE)

# VARIANCE
var(data$mpg, na.rm = TRUE)

# MINIMUM
min(data$mpg, na.rm = TRUE)

# MAXIMUM
max(data$mpg, na.rm = TRUE)

# RANGE
range(data$mpg, na.rm = TRUE)

# SUM
sum(data$mpg, na.rm = TRUE)

# INTERQUARTILE RANGE
IQR(data$mpg, na.rm = TRUE)

# COUNT OF NONMISSING VALUES
sum(!is.na(data$mpg))

# ALL STATISTICS TOGETHER
data |>
  summarize(
    average = mean(mpg, na.rm = TRUE),
    median = median(mpg, na.rm = TRUE),
    sd = sd(mpg, na.rm = TRUE),
    minimum = min(mpg, na.rm = TRUE),
    maximum = max(mpg, na.rm = TRUE),
    total = sum(mpg, na.rm = TRUE),
    n = n()
  )

# REMEMBER:
# mean() = average
# sd() = standard deviation
# sum() = adds values
# n() = counts rows
# na.rm = TRUE ignores missing values

# ==========================================================
# 4. FILTER / SELECT / MUTATE / ARRANGE
# ==========================================================

# FILTER = keep rows matching condition

# Keep cars with mpg > 20
data |>
  filter(mpg > 20)

# Keep cars with 4 cylinders
data |>
  filter(cyl == 4)

# Multiple conditions (AND)
data |>
  filter(mpg > 20, cyl == 4)

# OR condition
data |>
  filter(cyl == 4 | cyl == 6)

# %in% = matches ANY value in a list
data |>
  filter(cyl %in% c(4, 6))

# SELECT = choose columns
data |>
  select(mpg, cyl, wt)

# SELECT AND RENAME AT SAME TIME
data |>
  select(
    miles_per_gallon = mpg,
    weight = wt
  )

# RENAME = change column name
data |>
  rename(miles_per_gallon = mpg)

# BACKTICKS for names containing spaces:
# select(country = `Country name`)

# MUTATE = create a new column
data |>
  mutate(double_mpg = mpg * 2)

# SAVE THE NEW COLUMN
data <- data |>
  mutate(double_mpg = mpg * 2)

# ARRANGE = sort ascending
data |>
  arrange(mpg)

# ARRANGE DESCENDING
data |>
  arrange(desc(mpg))

# COUNT categories
data |>
  count(cyl)

# COUNT highest to lowest
data |>
  count(cyl, sort = TRUE)

# IMPORTANT:
# mutate() does NOT permanently save changes
# unless you assign the result with <-

# ==========================================================
# 5. GROUP_BY AND SUMMARIZE
# ==========================================================

# GROUP_BY = split data into categories
# SUMMARIZE = calculate one result per group

# Average MPG for each cylinder group
data |>
  group_by(cyl) |>
  summarize(
    average_mpg = mean(mpg)
  )

# Multiple statistics by group
data |>
  group_by(cyl) |>
  summarize(
    average = mean(mpg),
    median = median(mpg),
    sd = sd(mpg),
    total = sum(mpg),
    count = n()
  )

# VOLLEYBALL EXAMPLE:
# Total aces by team
#
# team_aces <- matches |>
#   group_by(team) |>
#   summarize(
#     total_aces = sum(aces, na.rm = TRUE)
#   ) |>
#   arrange(desc(total_aces))

# GROUPED MUTATE:
# Adds group statistics to EVERY original row
data |>
  group_by(cyl) |>
  mutate(
    group_mean = mean(mpg)
  ) |>
  ungroup()

# DIFFERENCE:
# mutate() keeps original rows
# summarize() reduces to one row per group

# Without group_by(), summarize()
# calculates one result for entire dataset.

# ungroup() removes grouping after calculations.

# ==========================================================
# 6. POPULATION PROPORTIONS AND CRIME RATES
# ==========================================================

# PROPORTION FORMULA:
# p_hat = successes / total observations

# Example: 120 successes out of 500
x <- 120
n <- 500

p_hat <- x / n
p_hat

# Convert proportion to percentage
p_hat * 100

# TRUE/FALSE AS A PROPORTION
# TRUE = 1, FALSE = 0

mean(data$mpg > 20)

# Percentage with mpg > 20
mean(data$mpg > 20) * 100

# POLLING EXAMPLE:
# Identify religiously unaffiliated respondents

ces <- ces |>
  mutate(
    unaffiliated = trad %in% c(
      "Atheist",
      "Agnostic",
      "Nothing in Particular"
    )
  )

# Proportion unaffiliated
proportion <- mean(
  ces$unaffiliated,
  na.rm = TRUE
)

proportion

# Percentage unaffiliated
proportion * 100

# Count TRUE/FALSE
table(ces$unaffiliated)

# Proportion of each category
prop.table(table(ces$unaffiliated))

# CRIME RATE FORMULA:
# (Number of crimes / population) * multiplier

# Example:
total_crimes <- 450
population <- 100000

# Crimes per 10,000 people
crime_rate <- total_crimes / population * 10000
crime_rate

# Crimes per 100,000 people
crime_rate_100k <- total_crimes /
  population * 100000

crime_rate_100k

# CRIME DATASET EXAMPLE:
#
# crimes <- crimes |>
#   mutate(
#     violent_rate =
#       violent_crime_total / population * 10000,
#     property_rate =
#       property_crime_total / population * 10000
#   )

# REMEMBER:
# Numerator = what you are counting
# Denominator = population
# Multiply by 1000, 10000, or 100000

# ==========================================================
# 7. RANDOM SAMPLING
# ==========================================================

# set.seed() makes random results reproducible
set.seed(42)

# Create a population of 1000 people
population <- tibble(
  id = 1:1000,
  age = sample(18:80, 1000, replace = TRUE)
)

# Randomly sample 100 people
sample_data <- population |>
  sample_n(100)

# Randomly sample 50 people
sample_50 <- population |>
  sample_n(50)

# Newer alternative to sample_n()
sample_data <- population |>
  slice_sample(n = 100)

# Sample 10% of population
sample_data <- population |>
  slice_sample(prop = 0.10)

# Sample WITH replacement
sample_data <- population |>
  slice_sample(n = 100, replace = TRUE)

# Sample WITHOUT replacement
sample_data <- population |>
  slice_sample(n = 100, replace = FALSE)

# POPULATION MEAN
mean(population$age)

# SAMPLE MEAN
mean(sample_data$age)

# POPULATION SD
sd(population$age)

# SAMPLE SD
sd(sample_data$age)

# Sample summary
sample_data |>
  summarize(
    mean_age = mean(age),
    sd_age = sd(age)
  )

# REMEMBER:
# A sample is a subset of the population.
# Larger samples generally have less sampling error.
# Sampling does not modify original population.
# replace = TRUE allows repeated observations.

# ==========================================================
# 8. POLLING SIMULATIONS
# ==========================================================

# FUNCTION = reusable block of code
# replicate() = repeat calculation many times

# Function to simulate polling
simulate_polls <- function(
    data,
    sample_size,
    n_simulations = 1000
) {

  proportions <- replicate(n_simulations, {

    s <- data |>
      sample_n(sample_size)

    mean(s$unaffiliated, na.rm = TRUE)

  })

  tibble(
    proportion = proportions,
    sample_size = sample_size
  )
}

# Simulate 1000 polls with 50 respondents
set.seed(42)

simulations_50 <- simulate_polls(
  ces,
  sample_size = 50
)

# Simulate 1000 polls with 500 respondents
simulations_500 <- simulate_polls(
  ces,
  sample_size = 500
)

# Combine simulation results
simulations_all <- bind_rows(
  simulations_50,
  simulations_500
) |>
  mutate(
    sample_size = paste("n =", sample_size)
  )

# Mean simulated proportion
mean(simulations_50$proportion)

# Standard deviation of simulated proportions
sd(simulations_50$proportion)

# HISTOGRAM COMPARING SAMPLE SIZES
ggplot(simulations_all,
       aes(x = proportion)) +
  geom_histogram(
    bins = 30,
    fill = "steelblue",
    color = "white"
  ) +
  geom_vline(
    xintercept = proportion,
    color = "red",
    linetype = "dashed"
  ) +
  facet_wrap(~sample_size)

# IMPORTANT:
# bind_rows() stacks data vertically.
# inner_join() merges matching rows horizontally.
# facet_wrap() creates separate chart panels.
# Larger samples usually have less variability.

# ==========================================================
# 9. Z-SCORES
# ==========================================================

# Z-SCORE FORMULA:
# z = (x - mean) / standard deviation

# Example:
x <- 85
mu <- 75
sigma <- 10

z <- (x - mu) / sigma
z

# Result = 1
# Value is 1 standard deviation above mean.

# Z-score using dataset mean and SD
x <- 25

z <- (x - mean(data$mpg)) /
  sd(data$mpg)

z

# Add z-score column
data <- data |>
  mutate(
    z_score = (mpg - mean(mpg)) / sd(mpg)
  )

# Alternative using scale()
data <- data |>
  mutate(
    z_score = as.numeric(scale(mpg))
  )

# FIND UNUSUAL OBSERVATIONS
# abs() converts negative values to positive

data |>
  filter(abs(z_score) > 2)

# FLAG UNUSUAL OBSERVATIONS
data <- data |>
  mutate(
    unusual = abs(z_score) > 2
  )

# REMEMBER:
# z = 0: at mean
# z = 1: one SD above mean
# z = -1: one SD below mean
# abs(z) > 2: often considered unusual

# ==========================================================
# 10. SEASONAL Z-SCORES
# ==========================================================

# Seasonal z-scores compare observations
# against the SAME month across years.

# CAR THEFT EXAMPLE:
#
# car_thefts <- car_thefts |>
#   group_by(month_of_year) |>
#   mutate(
#     seasonal_mean = mean(total),
#     seasonal_sd = sd(total),
#     seasonal_z_score =
#       (total - seasonal_mean) / seasonal_sd
#   ) |>
#   ungroup()

# Example with sample data:
seasonal_data <- tibble(
  month_of_year = rep(1:12, times = 5),
  total = rpois(60, lambda = 100)
)

seasonal_data <- seasonal_data |>
  group_by(month_of_year) |>
  mutate(
    seasonal_mean = mean(total),
    seasonal_sd = sd(total),
    seasonal_z_score =
      (total - seasonal_mean) / seasonal_sd
  ) |>
  ungroup()

# Find unusually high seasonal values
seasonal_data |>
  filter(seasonal_z_score > 2)

# REMEMBER:
# Regular z-score compares to all observations.
# Seasonal z-score compares within each season.
# Always ungroup() when finished.

# ==========================================================
# 11. NORMAL DISTRIBUTION AND PNORM
# ==========================================================

# pnorm() = probability BELOW a value
# 1 - pnorm() = probability ABOVE a value
# qnorm() = find value from probability

# Probability BELOW z = 2.5
pnorm(2.5)

# Probability ABOVE z = 2.5
1 - pnorm(2.5)

# Alternative for ABOVE
pnorm(2.5, lower.tail = FALSE)

# Probability BETWEEN z = -2 and z = 2
pnorm(2) - pnorm(-2)

# Probability BELOW a raw value
# Mean = 400, SD = 80
pnorm(500, mean = 400, sd = 80)

# Probability ABOVE a raw value
pnorm(
  500,
  mean = 400,
  sd = 80,
  lower.tail = FALSE
)

# Probability BETWEEN 350 and 500
pnorm(500, mean = 400, sd = 80) -
  pnorm(350, mean = 400, sd = 80)

# Find z-score for 95th percentile
qnorm(0.95)

# Find raw value at 90th percentile
qnorm(0.90, mean = 400, sd = 80)

# REMEMBER:
# pnorm(z) assumes mean = 0, SD = 1.
# If using RAW VALUES, specify mean and sd.
# If using Z-SCORES, default mean=0, sd=1 is correct.

# ==========================================================
# 12. PERCENTILES / QUARTILES / NTILE
# ==========================================================

# Find 25th percentile
quantile(data$mpg, 0.25)

# Find median / 50th percentile
quantile(data$mpg, 0.50)

# Find 75th percentile
quantile(data$mpg, 0.75)

# Find 90th percentile
quantile(data$mpg, 0.90)

# Find 95th percentile
quantile(data$mpg, 0.95)

# All quartiles
quantile(data$mpg)

# Interquartile range
IQR(data$mpg)

# Percentile rank of a value
mean(data$mpg <= 25) * 100

# NTILE = divide observations into groups

# Quartiles: 4 groups
data |>
  mutate(
    quartile = ntile(mpg, 4)
  )

# Deciles: 10 groups
data |>
  mutate(
    decile = ntile(mpg, 10)
  )

# Percentile bins: 100 groups
data |>
  mutate(
    percentile = ntile(mpg, 100)
  )

# NOTE:
# With fewer than 100 rows, some bins are empty.
# ntile() may split tied values across bins.

# PERCENT_RANK
data |>
  mutate(
    percentile_rank = percent_rank(mpg)
  )

# Convert percent_rank to percentage
data |>
  mutate(
    percentile_rank = percent_rank(mpg) * 100
  )

# VOLLEYBALL EXAMPLE:
#
# team_aces <- matches |>
#   group_by(team) |>
#   summarize(
#     total_aces = sum(aces)
#   ) |>
#   arrange(desc(total_aces))
#
# team_aces <- team_aces |>
#   mutate(
#     percentile = ntile(total_aces, 100)
#   )

# REMEMBER:
# quantile() = value at a percentile
# ntile() = assign observations to bins
# percent_rank() = relative rank from 0 to 1
# ntile(x, 4) = quartiles
# ntile(x, 10) = deciles
# ntile(x, 100) = percentile bins

# ==========================================================
# 13. CORRELATION
# ==========================================================

# Correlation measures the strength and
# direction of a LINEAR relationship.

# r ranges from -1 to +1
# r = +1: perfect positive correlation
# r = -1: perfect negative correlation
# r = 0: no linear correlation

# COR() = correlation coefficient only
cor(data$mpg, data$wt)

# COR.TEST() = correlation + p-value + CI
cor_result <- cor.test(
  data$mpg,
  data$wt
)

# View full results
cor_result

# Extract correlation coefficient
cor_result$estimate

# Extract p-value
cor_result$p.value

# Extract confidence interval
cor_result$conf.int

# Round correlation to 3 decimals
round(cor_result$estimate, 3)

# CORRELATION MATRIX
# Select only numeric columns
cor_matrix <- data |>
  select(mpg, wt, hp, disp) |>
  cor()

cor_matrix

# Round matrix values
round(cor_matrix, 3)

# REMEMBER:
# cor() = just correlation coefficient
# cor.test() = coefficient, p-value, CI
# Correlation does NOT prove causation.
# cor() only works with numeric columns.

# ==========================================================
# 14. GGPLOT HISTOGRAMS
# ==========================================================

# Basic histogram
ggplot(data, aes(x = mpg)) +
  geom_histogram()

# Histogram with 20 bins
ggplot(data, aes(x = mpg)) +
  geom_histogram(bins = 20)

# Histogram with specific bin width
ggplot(data, aes(x = mpg)) +
  geom_histogram(binwidth = 5)

# CUSTOM HISTOGRAM
ggplot(data, aes(x = mpg)) +
  geom_histogram(
    bins = 15,
    fill = "steelblue",
    color = "white"
  ) +
  labs(
    title = "Distribution of MPG",
    x = "Miles Per Gallon",
    y = "Frequency"
  ) +
  theme_minimal()

# HISTOGRAM WITH REFERENCE LINE
ggplot(data, aes(x = mpg)) +
  geom_histogram(
    bins = 15,
    fill = "steelblue"
  ) +
  geom_vline(
    xintercept = mean(data$mpg),
    color = "red",
    linetype = "dashed",
    linewidth = 1
  )

# SIDE-BY-SIDE HISTOGRAMS
ggplot(data, aes(x = mpg)) +
  geom_histogram(bins = 15) +
  facet_wrap(~cyl)

# REMEMBER:
# bins = number of bars
# binwidth = width of each bar
# geom_vline() = vertical reference line
# facet_wrap() = separate panels

# ==========================================================
# 15. GGPLOT SCATTERPLOTS
# ==========================================================

# BASIC SCATTERPLOT
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point()

# ADD TREND LINE
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE)

# COLOR POINTS BY CATEGORY
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point(aes(color = factor(cyl)))

# SIZE POINTS BY ANOTHER VARIABLE
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point(aes(size = hp))

# MULTIPLE VISUAL VARIABLES
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point(
    aes(
      color = hp,
      size = disp
    ),
    alpha = 0.7
  ) +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "darkgreen"
  )

# LABEL SELECTED POINTS
ggplot(data, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_text(
    aes(label = mpg),
    data = data |>
      filter(mpg > 30),
    size = 3,
    check_overlap = TRUE
  )

# COLOR POINTS BASED ON CONDITION
ggplot(data,
       aes(x = wt,
           y = mpg,
           color = abs(z_score) > 2)) +
  geom_point(size = 3) +
  scale_color_manual(
    values = c("black", "red"),
    name = "Unusual Value",
    labels = c("Normal", "Unusual")
  )

# REMEMBER:
# geom_point() = dots
# geom_smooth(method="lm") = regression line
# se=TRUE = confidence band
# alpha = transparency
# geom_text() = labels
# color = point/line color

# ==========================================================
# 16. BAR CHARTS / LINE GRAPHS / BOXPLOTS
# ==========================================================

# BAR CHART FOR CATEGORIES
ggplot(data, aes(x = factor(cyl))) +
  geom_bar()

# BOXPLOT
ggplot(data, aes(y = mpg)) +
  geom_boxplot()

# BOXPLOT BY CATEGORY
ggplot(data,
       aes(x = factor(cyl), y = mpg)) +
  geom_boxplot()

# LINE GRAPH
# Use with chronological or ordered data
line_data <- tibble(
  year = 2020:2025,
  total = c(100, 120, 140, 130, 170, 190)
)

ggplot(line_data,
       aes(x = year, y = total)) +
  geom_line() +
  geom_point()

# REMEMBER:
# Histogram = numerical distribution
# Bar chart = category counts
# Scatterplot = relationship of two numbers
# Line graph = trends over time
# Boxplot = median, quartiles, outliers

# ==========================================================
# 17. CORRELATION MATRIX HEATMAP
# ==========================================================

# Select numeric variables
# Calculate correlation matrix
# Reshape into long format
# Plot colored tiles

data |>
  select(mpg, wt, hp, disp) |>
  cor() |>
  round(3) |>
  as.data.frame() |>
  rownames_to_column("Variable") |>
  pivot_longer(
    -Variable,
    names_to = "Measure",
    values_to = "Correlation"
  ) |>
  ggplot(
    aes(
      x = Variable,
      y = Measure,
      fill = Correlation
    )
  ) +
  geom_tile() +
  scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0
  ) +
  geom_text(
    aes(label = round(Correlation, 2)),
    color = "black",
    size = 3
  )

# REMEMBER:
# cor() = correlation matrix
# pivot_longer() = wide to long data
# geom_tile() = colored rectangles
# scale_fill_gradient2() = color scale

# ==========================================================
# 18. DATES / PARSE_DATE_TIME
# ==========================================================

# parse_date_time() converts text to dates.
# Requires lubridate (loaded with tidyverse).

# Create example data
dates <- tibble(
  month = c("Jan 2017", "Feb 2017", "Mar 2017")
)

# Convert month-year text into date format
dates <- dates |>
  mutate(
    date = parse_date_time(month, "my")
  )

# Other common date formats:
# "my"  = Jan 2017
# "ymd" = 2017-01-15
# "mdy" = 01/15/2017

# Extract year from date
dates |>
  mutate(year = year(date))

# Extract month
dates |>
  mutate(month_number = month(date))

# REMEMBER:
# Dates must be parsed to sort chronologically.
# Text dates may sort alphabetically instead.

# ==========================================================
# 19. PASTE / SPRINTF / CAT
# ==========================================================

# paste() combines text and numbers
r <- 0.78
p <- 0.003

paste("Pearson's r =", round(r, 3))

paste(
  "Pearson's r =", round(r, 3),
  ", p-value =", round(p, 4)
)

# sprintf() formats numbers into text
sprintf("Correlation: %.2f", r)

# %d = whole number
# %.2f = decimal with 2 digits
# \n = new line

total <- 450

cat(sprintf("Total thefts: %d\n", total))

z <- 2.54

cat(sprintf("Z-score: %.2f\n", z))

# REMEMBER:
# paste() = combine text and values
# round() = round numbers
# sprintf() = format strings
# cat() = print formatted text

# ==========================================================
# 20. COMMON MISTAKES
# ==========================================================

# MISTAKE 1: FORGETTING TO SAVE MUTATE
#
# This does not save changes:
# data |> mutate(new_col = mpg * 2)
#
# Correct:
data <- data |>
  mutate(new_col = mpg * 2)

# MISTAKE 2: USING == FOR MULTIPLE VALUES
#
# Wrong:
# cyl == c(4, 6)
#
# Correct:
data |>
  filter(cyl %in% c(4, 6))

# MISTAKE 3: FORGETTING GROUP_BY
#
# This gives ONE total:
data |>
  summarize(total = sum(mpg))

# This gives one total PER GROUP:
data |>
  group_by(cyl) |>
  summarize(total = sum(mpg))

# MISTAKE 4: CONFUSING MUTATE/SUMMARIZE
#
# mutate() = keeps rows, adds columns
# summarize() = reduces groups to one row

# MISTAKE 5: PNORM ABOVE VS BELOW
#
# BELOW:
pnorm(2.5)

# ABOVE:
1 - pnorm(2.5)

# MISTAKE 6: PNORM RAW VALUE
#
# If input is a raw value, include mean and SD:
pnorm(500, mean = 400, sd = 80)

# MISTAKE 7: COR WITH TEXT COLUMNS
#
# Wrong:
# cor(data_with_text_columns)
#
# Correct:
data |>
  select(where(is.numeric)) |>
  cor()

# MISTAKE 8: COLOR VS FILL
#
# color = points, lines, outlines
# fill = inside of bars, boxes, tiles

# MISTAKE 9: FORGETTING SET.SEED
#
# Without seed: random results vary
# With seed: reproducible results
set.seed(42)

# MISTAKE 10: CONFUSING $ AND PIPES
#
# Correct:
mean(data$mpg)

# Also correct:
data |>
  summarize(avg = mean(mpg))

# Wrong:
# data |> mean(mpg)

# MISTAKE 11: WRONG CRIME RATE FORMULA
#
# Correct:
# (crimes / population) * 10000
#
# Wrong:
# (population / crimes) * 10000

# MISTAKE 12: BIND_ROWS VS INNER_JOIN
#
# bind_rows() = stack data vertically
# inner_join() = merge by matching key

# MISTAKE 13: NTILE AND TIES
#
# ntile() can split tied values into
# different bins to keep bins balanced.
# percent_rank() gives tied values same rank.

# ==========================================================
# 21. QUICK EXAM REFERENCE
# ==========================================================

# -------- LOAD DATA --------
# library(tidyverse)
# library(janitor)
# read_csv("file.csv")
# clean_names()
# View(data)
# head(data)
# summary(data)

# -------- STATISTICS --------
# mean(x)
# median(x)
# sd(x)
# var(x)
# sum(x)
# min(x)
# max(x)
# IQR(x)

# -------- DATA MANIPULATION --------
# filter()
# select()
# rename()
# mutate()
# arrange()
# count()
# group_by()
# summarize()
# ungroup()
# drop_na()

# -------- PROPORTIONS --------
# x / n
# mean(condition)
# mean(condition) * 100
# prop.table(table(x))

# -------- SAMPLING --------
# set.seed(42)
# sample_n(100)
# slice_sample(n = 100)
# slice_sample(prop = 0.10)
# replace = TRUE

# -------- SIMULATIONS --------
# function()
# replicate()
# bind_rows()
# facet_wrap()

# -------- Z-SCORES --------
# (x - mean) / sd
# scale(x)
# abs(z_score) > 2

# -------- PROBABILITIES --------
# pnorm(z)
# 1 - pnorm(z)
# pnorm(z, lower.tail = FALSE)
# qnorm(0.95)

# -------- PERCENTILES --------
# quantile(x, 0.90)
# ntile(x, 4)
# ntile(x, 10)
# ntile(x, 100)
# percent_rank(x)

# -------- CORRELATION --------
# cor(x, y)
# cor.test(x, y)
# cor_result$estimate
# cor_result$p.value
# cor_result$conf.int

# -------- GGPLOT --------
# ggplot(data, aes(x = variable))
# geom_histogram()
# geom_bar()
# geom_point()
# geom_line()
# geom_boxplot()
# geom_smooth(method = "lm")
# geom_vline()
# geom_text()
# geom_tile()
# facet_wrap(~group)
# labs(title = "", x = "", y = "")
# theme_minimal()

# -------- DATES --------
# parse_date_time(x, "my")
# year(date)
# month(date)

# -------- FORMATTING --------
# paste()
# round()
# sprintf()
# cat()

# ==========================================================
# 22. KEY CONCEPTS TO REMEMBER
# ==========================================================

# POPULATION = entire group being studied
# SAMPLE = subset of population

# PROPORTION = successes / total

# RATE = count / population * multiplier

# Z-SCORE = distance from mean in SD units

# PERCENTILE = relative position in distribution

# CORRELATION = strength/direction of linear relationship

# CORRELATION DOES NOT PROVE CAUSATION

# Larger samples generally reduce sampling variability.

# pnorm() gives left-tail probability by default.

# TRUE = 1 and FALSE = 0 when calculating mean().

# group_by() splits observations into groups.

# summarize() reduces each group to one row
# when using summary functions like mean() or sum().

# mutate() adds columns without removing rows.

# ntile() creates approximately equal-sized bins.

# facet_wrap() makes separate graph panels.

# set.seed() makes random sampling reproducible.

# ALWAYS SAVE TRANSFORMATIONS USING <-

############################################################
#                  END OF CHEAT SHEET
############################################################
