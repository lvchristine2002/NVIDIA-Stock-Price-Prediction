# Install dplyr package
# # Install zoo package
# install tidyr package
library(dplyr)
library(zoo)
library(tidyr) 
library(ggplot2)

nvidia_data <- read.csv("Downloads/NVDA.csv", TRUE, ",")
head(nvidia_data)

# Check for null values (returns 0)
sum(is.na(nvidia_data)) 

#Makes sure all are same date format
nvidia_data$Date<- as.Date(nvidia_data$Date)
head(nvidia_data)

# 7 day simple moving average to help identity patterns, trends, and relationships. 
nvidia_data <- nvidia_data %>%
  arrange(Date) %>%
  mutate(SMA_7 = rollmean(Close, k = 7, fill = NA, align = "right"),
         previous_close = lag(Close, 1))
nvidia_data <- nvidia_data %>% drop_na()

# visualize data with closing prices and SMA
ggplot(nvidia_data, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close")) +
  geom_line(aes(y = SMA_7, color = "SMA_7")) +
  labs(title = "Closing Prices and SMA", y = "Price") +
  theme_minimal()
