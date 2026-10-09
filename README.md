# 🛒 Customer Shopping Behavior Analysis - End to End Project
**Author: Asmita Chavan47 | Location: Pune | Tools: Python, MySQL, Power BI**

### 📌 Project Overview
Analyzed 3900+ E-commerce customer records to find revenue patterns, loyalty trends & product performance. This is an End-to-End Data Analyst project.

### 📂 Dataset
- 3900 rows, 18 columns
- Columns: Customer ID, Age, Gender, Item Purchased, Category, Purchase Amount (USD), Review Rating, Subscription Status, Shipping Type, Discount, Payment Method, Frequency

### Step 1: Python - Data Cleaning (Jupyter Notebook)
- Found 37 NULLs in `Review Rating` -> Filled with Category-wise Median using `groupby().transform()`
- Cleaned column names: `lower()` & `replace(' ', '_')`
- Created `age_group` using `pd.qcut` -> Young Adult, Adult, Middle-aged, Senior
- Created `purchase_frequency_days` -> Weekly=7, Monthly=30, Annually=365
- Removed duplicate logic: `discount_applied == promo_code_used` -> dropped `promo_code_used`

### Step 2: MySQL - 10 Business Questions (Advanced SQL)
1. Total Revenue by Gender - GROUP BY, SUM()
2. High spenders despite discount - Subquery with AVG()
3. Top 5 Highest Rated Products - AVG() + ORDER BY LIMIT
4. Avg Purchase: Standard vs Express Shipping
5. Subscribed vs Non-Subscribed Analysis
6. Products with Highest Discount Dependency - CASE WHEN
7. Customer Segmentation (New/Returning/Loyal) - CTE + CASE
8. Top 3 Products per Category - Window Function ROW_NUMBER() OVER (PARTITION BY category)
9. Repeat Buyers (>5 purchases) & Subscription
10. Revenue by Age Group (18-25, 26-35, 36-50, 51+) - CASE

### 📊 Step 3: Power BI Dashboard
**KPIs:** 3.9K Customers | $59.76 Avg Purchase | 3.75 Avg Rating
- 73% Non-Subscribed vs 27% Subscribed
- Clothing category = Highest Revenue
- Young Adult & Middle-aged = Top revenue contributors
- Slicers used: Gender, Category, Shipping Type

### 💡 Key Insights
- Clothing drives max revenue, need to focus marketing on it
- 73% customers are not subscribed - huge opportunity for subscription model
- Express shipping users spend more on average

### 🔗 Tech Stack
Python (Pandas, NumPy), MySQL (CTE, Window Functions, Subqueries), Power BI
