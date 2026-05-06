install.packages("dplyr")
install.packages("moderndive")
install.packages("tidyverse")
install.packages("infer")
install.packages("gapminder")
install.packages("car")
install.packages("skimr")
install.packages("ggplot2")


library(moderndive)
library(tidyverse)
library(infer)
library(openxlsx)
library(skimr)
library(dplyr)
library(gapminder)
library(car)
library(ggplot2)

getwd()
setwd("C:\\Users\\aadig\\OneDrive\\Desktop\\Nuel")

nike_data = read.xlsx("nike_sales_data_features_final.xlsx", sheet = "Sheet1")


month = factor(nike_data$Month)
country = factor(nike_data$Country)
main_ctgr = factor(nike_data$Main_Category)
sub_ctgr = factor(nike_data$Sub_Category)
product_line = factor(nike_data$Product_Line)
price_tier = factor(nike_data$Price_Tier)
units_sold = nike_data$Units_Sold
revenue = nike_data$Revenue_USD
online_sales_percentage = nike_data$Online_Sales_Percentage
retail_price = nike_data$Retail_Price
holiday = nike_data$HolidayCount
offline_Sales = nike_data$Offline.Sales.Amount
holiday_sales = nike_data$Holiday_Sales_Estimate

# Calculating correlation coefficient for each explanatory variable
nike_data %>% get_correlation(formula = Holiday_Sales_Estimate~Units_Sold)
nike_data %>% get_correlation(formula = Holiday_Sales_Estimate~Online_Sales_Percentage)
nike_data %>% get_correlation(formula = Holiday_Sales_Estimate~Retail_Price)
nike_data %>% get_correlation(formula = Holiday_Sales_Estimate~Offline.Sales.Amount)
nike_data %>% get_correlation(formula = Holiday_Sales_Estimate~Revenue_USD)

# Visualization of the relationship
ggplot(nike_data, aes(x = Units_Sold, y = Holiday_Sales_Estimate)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(nike_data, aes(x = Online_Sales_Percentage, y = Holiday_Sales_Estimate)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(nike_data, aes(x = Retail_Price, y = Holiday_Sales_Estimate)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(nike_data, aes(x = Offline.Sales.Amount, y = Holiday_Sales_Estimate)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(nike_data, aes(x = Revenue_USD, y = Holiday_Sales_Estimate)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

scatterplotMatrix(~ units_sold + online_sales_percentage + retail_price + offline_Sales + revenue, regLine = list(col = 2),
                  col = 1, smooth = list(col.smooth = 4, col.spread = 4), data = nike_data)

#Baseline Model
linearModel_1 = lm(holiday_sales~main_ctgr+country+product_line+online_sales_percentage+units_sold+price_tier+retail_price+offline_Sales+holiday, data = nike_data)
rg1 = get_regression_table(linearModel_1)
summary(linearModel_1)

#Performed EDA to improve model
hist(nike_data$Holiday_Sales_Estimate, xlab="Holiday Estimates")
hist(nike_data$Units_Sold, xlab="Units Sold")
hist(nike_data$Online_Sales_Percentage, xlab="Online Sales")
hist(nike_data$Retail_Price, xlab="Retail Price")
hist(nike_data$Offline.Sales.Amount, xlab="Offline Sales")

# Creating Test Model 
num_rows <- nrow(nike_data)
num_cols <- ncol(nike_data)
set.seed(123)
train.index <- sample(row.names(nike_data), floor(0.8*num_rows)) 
test.index <- setdiff(row.names(nike_data), train.index) 
train.df <- nike_data[train.index, -num_rows]
test.df <- nike_data[test.index, -num_rows]
nike_data_mod1 <- lm(train.df$Holiday_Sales_Estimate ~ ., data = train.df) 
summary(nike_data_mod1)
preds.nike_data_mod1 <- predict(nike_data_mod1, newdata = test.df)
MSE1 <- mean((preds.nike_data_mod1 - test.df$Holiday_Sales_Estimate)^2)
RMSE1 <- sqrt(MSE1)
print(RMSE1) #2721380

# Creating Test Model 2
num_rows <- nrow(nike_data)
num_cols <- ncol(nike_data)
set.seed(123)
train.index <- sample(row.names(nike_data), floor(0.7*num_rows)) 
test.index <- setdiff(row.names(nike_data), train.index) 
train.df <- nike_data[train.index, -num_rows]
test.df <- nike_data[test.index, -num_rows]
nike_data_mod2 <- lm(train.df$Holiday_Sales_Estimate ~ ., data = train.df) 
summary(nike_data_mod2)
preds.nike_data_mod2 <- predict(nike_data_mod2, newdata = test.df)
MSE2 <- mean((preds.nike_data_mod2 - test.df$Holiday_Sales_Estimate)^2)
RMSE2 <- sqrt(MSE2)
print(RMSE2) #2325557

# Another model without month and sub_ctrgr variables
num_rows <- nrow(nike_data)
num_cols <- ncol(nike_data)
set.seed(123)
train.index <- sample(row.names(nike_data), floor(0.7*num_rows)) 
test.index <- setdiff(row.names(nike_data), train.index) 
train.df <- nike_data[train.index, -num_rows]
test.df <- nike_data[test.index, -num_rows]
nike_data_mod3 <- lm(Holiday_Sales_Estimate ~ . - Month - Sub_Category, data = train.df) 
summary(nike_data_mod3)
preds.nike_data_mod3 <- predict(nike_data_mod3, newdata = test.df) 
MSE3 <- mean((preds.nike_data_mod3 - test.df$Holiday_Sales_Estimate)^2)
RMSE3 <- sqrt(MSE3)
print(RMSE3) #2277371

# Another model without month, sub_ctrgr and product_line variables
num_rows <- nrow(nike_data)
num_cols <- ncol(nike_data)
set.seed(123)
train.index <- sample(row.names(nike_data), floor(0.7*num_rows)) 
test.index <- setdiff(row.names(nike_data), train.index) 
train.df <- nike_data[train.index, -num_rows]
test.df <- nike_data[test.index, -num_rows]
nike_data_mod4 <- lm(Holiday_Sales_Estimate ~ . - Month - Sub_Category -Product_Line, data = train.df) 
preds.nike_data_mod4 <- predict(nike_data_mod4, newdata = test.df) 
MSE4 <- mean((preds.nike_data_mod4 - test.df$Holiday_Sales_Estimate)^2)
RMSE4 <- sqrt(MSE4)
print(RMSE4) #2254028

# Only considering log for holiday sales
nike_data$log_offlinesales <- log(nike_data$Offline.Sales.Amount)
nike_data$log_HolidaySales <- log(nike_data$Holiday_Sales_Estimate)
num_rows <- nrow(nike_data)
num_cols <- ncol(nike_data)
set.seed(123)
train.index <- sample(row.names(nike_data), floor(0.7*num_rows)) 
test.index <- setdiff(row.names(nike_data), train.index) 
train.df <- nike_data[train.index, -num_rows]
test.df <- nike_data[test.index, -num_rows]
nike_data_mod4 <- lm(log_HolidaySales ~ . - Month - Sub_Category -Product_Line - log_offlinesales, data = train.df) 
preds.nike_data_mod4 <- predict(nike_data_mod4, newdata = test.df) 
MSE4 <- mean((preds.nike_data_mod4 - test.df$log_HolidaySales)^2)
RMSE4 <- sqrt(MSE4)
print(RMSE4) #0.4389905

# Another model without month, sub_ctrgr, product_line and revenue_usd variables & performed log transformation on offline sales amount and holiday sales estimate
num_rows <- nrow(nike_data)
num_cols <- ncol(nike_data)
set.seed(123)
train.index <- sample(row.names(nike_data), floor(0.7*num_rows)) 
test.index <- setdiff(row.names(nike_data), train.index) 
train.df <- nike_data[train.index, -num_rows]
test.df <- nike_data[test.index, -num_rows]
nike_data_mod5 <- lm(log_HolidaySales ~ .- Month - Sub_Category -Product_Line -Revenue_USD - Offline.Sales.Amount, data = train.df) 
rg4 = get_regression_table(nike_data_mod5)
summary(nike_data_mod5)
preds.nike_data_mod5 <- predict(nike_data_mod5, newdata = test.df) 
MSE5 <- mean((preds.nike_data_mod5 - test.df$log_HolidaySales)^2)
RMSE5 <- sqrt(MSE5)
print(RMSE5) #0.4181234


# Final model
nike_data_final.df = rbind(train.df, test.df)
nike_data_final_model <- lm(log_HolidaySales ~ . - Month - Sub_Category -Product_Line -Revenue_USD - offline_Sales, data = nike_data_final.df)
summary(nike_data_final_model)
rg6 = get_regression_table(nike_data_final_model)
preds.nike_data_final_model <- predict(nike_data_final_model, newdata = nike_data_final.df)
MSE_final <- mean((preds.nike_data_final_model - test.df$log_HolidaySales)^2)
RMSE_final <- sqrt(MSE_final)
print(RMSE_final) #1.600522