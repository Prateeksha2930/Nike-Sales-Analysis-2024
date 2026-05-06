# Nike-Sales-Analysis-2024
Project Overview
This project investigates the factors influencing Nike's sales performance across various countries and product categories in 2024. By analyzing internal sales data and external factors like public holidays, the analysis uncovers key drivers of revenue, assesses customer behavior, and provides data-driven strategies for improvement.

Objectives
The primary objectives of this study are:

Identify Primary Sales Drivers: Analyze the relationship between revenue, units sold, and retail price across product attributes like category and price tier.

Customer Demographics & Behavior: Assess regional preferences and purchasing behavior, including the ratio between online and offline sales.

Impact of External Factors: Quantify how seasonal holidays (Holiday Count) affect total revenue.

Define Key Performance Indicators (KPIs): Establish metrics for revenue growth, sales by category, and channel contribution.

Dataset Description
The analysis utilizes internal and external datasets:

Internal Data: Sourced from Kaggle, providing detailed Nike sales figures for 2024, including Units Sold, Revenue_USD, Retail Price, and Price Tier.

External Data: Holiday data for countries like the US, UK, JP, CN, and KR was fetched via the Holiday API to track public holidays per month.

Tech Stack
Python: Used for automated data collection from external APIs (Holiday API) and preprocessing.

R (tidyverse, moderndive, car): Employed for comprehensive exploratory data analysis (EDA) and statistical modeling, specifically Multiple Linear Regression.

Tableau: Utilized for building interactive dashboards to visualize regional trends and KPIs.

Excel: Used for initial data management and performing Exponential Smoothing for revenue forecasting.

Methodology
Data Collection: Integrated Nike sales records with holiday frequency data gathered through Python scripts.

Preprocessing: Performed log transformations on variables like Holiday Sales Estimate and Offline Sales Amount to reduce skewness and improve model accuracy.

Statistical Modeling: Conducted an iterative Multiple Linear Regression analysis in R, reducing the RMSE from 0.43899 to 0.41812 through feature selection.

Forecasting: Applied Exponential Smoothing in Excel to observe revenue fluctuations and seasonality impacts.

Key Insights
Units Sold: This was the strongest predictor of holiday-related sales and overall revenue.

Offline Sales Importance: Offline channels proved to be critical, showing a positive correlation with sales spikes during holiday periods.

Holiday Impact: Seasonality, driven by public holiday counts, significantly amplifies revenue performance.

Online vs. Offline: Online sales showed a minimal or even negative impact on holiday-specific sales estimates, suggesting customers prefer offline shopping during those times.

Actionable Recommendations
Channel Strategy: Prioritize inventory management and marketing efforts for offline channels during major holiday windows.

Regional Focus: Target product categories and countries that demonstrate higher-than-average responsiveness to holiday trends.

Online Strategy Reassessment: Shift aggressive online marketing to non-holiday periods to complement the seasonal offline surge.
