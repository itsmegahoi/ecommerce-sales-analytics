# E-Commerce Sales Analytics Pipeline

## 📌 Overview

This project demonstrates a **modern data engineering pipeline** for analyzing e-commerce sales data using  **Databricks, dbt, and Power BI** .

We follow the **Medallion Architecture** (Bronze → Silver → Gold) to structure data for scalable analytics and reporting.

## 🏗️ Architecture

1. **Bronze Layer (Raw Ingestion)**
   * Data ingested into Databricks tables from CSV/Parquet (customers, products, sales).
   * Minimal transformation applied, only type casting and renaming for consistency.
2. **Silver Layer (Cleansed & Modeled)**
   * Created  **Dimension Tables** :
     * `dim_customers` → cleansed customer details
     * `dim_products` → standardized product catalog
   * Created  **Fact Table** :
     * `fact_sales` → structured transactional data with `sales` and `returns`
3. **Gold Layer (Business Metrics)**
   * Business-ready tables for analytics & dashboards:
     * `customer_metrics` → CLV, AOV, return rate, lifespan
     * `customer_segmentation` → RFM (Recency, Frequency, Monetary) scoring
     * `product_performance` → top-selling products, returns, revenue
     * `sales_summary` → sales vs returns, revenue trends
     * `regional_sales` → geography-based revenue distribution

## Tools & Technologies

* **Databricks** → Data Lakehouse for scalable compute & storage
* **dbt (Data Build Tool)** → Data transformations, testing & documentation
* **dbt-docs** → Automated lineage & model documentation
* **Power BI (Upcoming)** → Business dashboards for insights

## ✅ Features Implemented

* ETL pipeline with **dbt + Databricks**
* **Data Quality Tests** (e.g., not null, uniqueness)
* **Revenue handling for returns** (negative revenue logic in `fact_sales`)
* **Gold layer metrics** for customers, products, and sales
* **dbt docs** generated for full lineage visualization

## 📊 Next Steps

1. Connect **Gold Layer tables** to **Power BI**
2. Build interactive dashboards:
   * Sales Overview
   * Customer Segmentation
   * Product Performance
   * Regional Revenue
3. Automate pipeline with **Airflow** (future scope)

## 📖 Documentation

Generate docs with:

<pre class="overflow-visible!" data-start="2692" data-end="2736"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>dbt docs generate
dbt docs serve</span></span></code></div></div></pre>
