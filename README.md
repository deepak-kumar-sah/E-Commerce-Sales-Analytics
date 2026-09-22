# E-Commerce Sales Analytics

## Project Overview

This project analyzes e-commerce sales data to identify revenue trends, customer behavior, product performance, and platform performance.

The project uses **Python, SQL, and Power BI** to perform data cleaning, exploratory data analysis, business analysis, and interactive dashboard development.

## Dataset

The dataset contains **5,000 e-commerce orders** with the following columns:

* `Order_ID` – Unique order identifier
* `Order_Date` – Date of purchase
* `Platform` – Sales platform
* `Customer_ID` – Unique customer identifier
* `Product` – Product purchased
* `Price` – Product price
* `Quantity` – Quantity purchased
* `Discount` – Discount applied
* `Revenue` – Revenue generated from the order
* `Country` – Customer country

## Key KPIs

| KPI                 |         Value |
| ------------------- | ------------: |
| Total Revenue       | 10,961,418.65 |
| Total Orders        |         5,000 |
| Total Quantity Sold |        12,470 |
| Average Order Value |      2,192.28 |
| Unique Customers    |         5,000 |

## Tools & Technologies

* **Python**

  * Pandas
  * NumPy
  * Matplotlib
  * Seaborn
  * Jupyter Notebook

* **SQL**

  * MySQL
  * Aggregations
  * GROUP BY
  * HAVING
  * Subqueries
  * CTEs
  * Window Functions
  * RANK()
  * ROW_NUMBER()
  * LAG()
  * CASE statements

* **Power BI**

  * KPI Cards
  * Interactive Charts
  * Slicers
  * Filters
  * Dashboard Design

## Analysis Performed

### Python EDA

* Data cleaning and validation
* Missing value analysis
* Duplicate detection
* Date conversion
* Revenue validation
* Platform-wise revenue analysis
* Product-wise revenue analysis
* Monthly revenue trend
* Product quantity analysis
* Platform-wise AOV analysis
* Country-wise revenue analysis
* Top customer analysis
* Discount vs revenue analysis

### SQL Analysis

SQL analysis includes:

* Total revenue
* Total orders
* Total quantity
* Platform performance
* Product performance
* Monthly revenue
* Top countries
* Average order value
* Revenue segmentation
* Subqueries
* CTEs
* Ranking functions
* Running totals
* Month-over-month growth
* Previous-month comparison
* Top products by platform
* Customer segmentation

### Power BI Dashboard

The Power BI report contains two pages:

#### 1. Sales Overview

* Total Revenue
* Total Orders
* Total Quantity
* Platform Revenue
* Monthly Revenue Trend
* Product-wise Revenue
* Platform slicer
* Product slicer
* Date slicer

#### 2. Detailed Analysis

* Top 10 Countries by Revenue
* Platform-wise Orders
* Product-wise Quantity Sold
* Top 10 Customers by Revenue
* Discount vs Revenue

## Key Insights

* **Amazon** generated the highest revenue among the three sales platforms.
* **Camera** generated the highest product revenue in the dataset.
* **Smartphone** had the highest quantity sold.
* Revenue showed month-to-month variation across the analyzed period.
* The discount and revenue relationship showed a **weak negative correlation**, so the relationship should not be interpreted as causation.
* The dataset contains one customer record per order, so meaningful repeat-customer retention analysis is not possible with this dataset.
* February 2025 contains only the first few days of data, so it should not be compared directly with complete months.

## Project Structure

```text
E-Commerce-Sales-Analytics/
│
├── dataset/
│   └── ecommerce_sales.csv
│
├── python/
│   └── ecommerce_eda.ipynb
│
├── sql/
│   └── ecommerce_analysis.sql
│
├── powerbi/
│   └── Ecommerce_Sales_Dashboard.pbix
│
├── images/
│   └── dashboard screenshots
│
└── README.md
```

## Business Objective

The main objective of this project is to transform raw e-commerce data into meaningful business insights that can help understand:

* Revenue performance
* Product demand
* Sales platform performance
* Geographic performance
* Customer contribution
* Sales trends
* Discount and revenue patterns

## Conclusion

This project demonstrates an end-to-end **Data Analyst workflow**:

**Raw Data → Python EDA → SQL Analysis → Power BI Dashboard → Business Insights**

The project showcases practical skills in **data cleaning, exploratory analysis, SQL, data visualization, dashboard development, and business intelligence**.
