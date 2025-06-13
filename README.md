# 📊 Carbon Emissions SQL Analysis Project

![Banner Image](https://img.freepik.com/free-vector/flat-woman-analyzes-ways-reduce-co2-emissions-climate-impact-from-factories_387295953.htm)  
*A real-world data analytics case study using SQL*

---

## 🌍 About the Project

A comprehensive **SQL-based data analysis** project focused on global **carbon emissions**. This project includes structured queries for trend analysis, year-on-year emission growth, and international comparisons using advanced SQL functions like `JOIN`, `CASE`, and `LAG`.  
✅ Perfect for learning and showcasing **real-world data analytics** and **SQL portfolio skills**.

---

## 📁 Dataset Overview

- **Source**: Cleaned CSV dataset based on publicly available Kaggle CO₂ emissions data  
- **Columns**:
  - `entity`: Country or region name  
  - `code`: Country code (ISO format)  
  - `year`: Year of observation  
  - `annual_emissions_tonnes`: CO₂ emissions in tonnes  

---

## 🛠️ Tools & Technologies

- **Database**: MySQL 8.0  
- **Interface**: MySQL Workbench or Command Line  
- **Techniques Used**:
  - Aggregation (`SUM`, `AVG`)
  - Joins and Filters
  - Window Functions (`LAG`)
  - Conditional logic with `CASE`
  - File import using `LOAD DATA INFILE`

---

## 🎯 Project Objectives

- Analyze CO₂ emission trends globally and for individual countries  
- Identify highest emitters and reduction patterns  
- Calculate annual growth rates for selected regions  
- Practice real-world SQL queries on a structured dataset  

---

## 📌 SQL Tasks Performed

1. **Top Countries by Total CO₂ Emissions**  
2. **Global Emissions Trends (Year-wise)**  
3. **India's Annual Emissions Overview**  
4. **Countries with Decreasing Emissions (2012–2017)**  
5. **Average Annual Emissions by Country**  
6. **First Year of Emissions Data by Country**  
7. **Highest Emission Year by a Country**  
8. **Year-on-Year Growth for India** (JOIN + LAG)  
9. **Emissions Comparison: 1990 vs 2020**  
10. **Top 20 Emitting Countries of All Time**

> 📂 Each task is separated and documented within the SQL file.

---

## 🚀 How to Use

1. Download and open `emissions.sql` in MySQL Workbench  
2. Ensure your MySQL settings allow `LOAD DATA INFILE`  
3. Import the dataset file using:
```sql
LOAD DATA INFILE 'your_path/co2_emission.csv'
INTO TABLE emissions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
