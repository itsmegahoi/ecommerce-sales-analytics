# E-Commerce Sales Analytics Pipeline

## Project Overview

This project demonstrates an end-to-end **e-commerce sales analytics pipeline** using a modern data stack.

The pipeline is designed to  **ingest, clean, transform, and analyze sales, product, and customer data** .

The project implements a **medallion architecture (bronze → silver → gold)** using  **Databricks, dbt, and Airflow** , with visualization in  **Power BI** .

## Data Sources

* **Sales data** : UCI Machine Learning Repository
* **Customer & product data** : Mockaroo (mock data generation)
* Data is stored in **Parquet format** for better performance and compatibility with dbt/Databricks.
