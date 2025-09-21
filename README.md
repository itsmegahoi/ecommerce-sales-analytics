# E-Commerce Sales Analytics Pipeline

## Project Overview

This project demonstrates an end-to-end **e-commerce sales analytics pipeline** using a modern data stack.

The pipeline is designed to  **ingest, clean, transform, and analyze sales, product, and customer data** .

The project implements a **medallion architecture (bronze → silver → gold)** using  **Databricks, dbt, and Airflow** , with visualization in  **Power BI** .


## Data Sources

* **Sales data** : UCI Machine Learning Repository
* **Customer & product data** : Mockaroo (mock data generation)
* Data is stored in **Parquet format** for better performance and compatibility with dbt/Databricks.

---

## Pipeline Overview

1. **Bronze Layer**
   * Raw ingestion of sales, product, and customer datasets.
   * CSV/JSON → Parquet → Databricks bronze tables.
2. **Silver Layer**
   * Clean, standardized datasets.
   * Handle duplicates, inconsistent formats, and missing values.
   * Example: Customer cleaning includes resolving multiple emails, addresses, and names for a single `customer_id`.
3. **Gold Layer**
   * Aggregated analytics metrics and KPIs.
   * Examples include:
     * Total/active customers, repeat customers %, AOV, CLV
     * Product metrics: top products, revenue by category
     * Time metrics: daily/monthly sales trends, YoY growth
     * Geography metrics: revenue by region/city

---

## Customer Data Cleaning Strategy

* **Problem** : Some `customer_id`s have multiple emails, names, and addresses.
* **Solution** :
* Keep **one canonical record per customer_id** for analytics.
* Select the **most recent record** for first_name, last_name, and address.
* Concatenate **all unique emails and phone numbers** to preserve contact info.
* Prioritize `active` membership status over `inactive`.
* Store raw duplicates in a separate table for audit purposes.
