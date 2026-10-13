LATAM Economic Pulse: Macroeconomic Indicators Dashboard (2000–2025)
Business & Technical Overview
An end-to-end data engineering and analytics solution designed to extract, model, and visualize macroeconomic metrics for 7 Latin American economies: Argentina, Brazil, Chile, Colombia, Mexico, Paraguay, and Peru.
This project demonstrates a full data pipeline, spanning from API data extraction in R to Star Schema relational modeling and advanced DAX measure engineering in Power BI.
Key KPIs & Metrics Tracked
GDP Growth (%): Annual GDP percentage changes across two decades.
Inflation Rate (%): Consumer price variations (handled with Logarithmic Scaling for hyperinflationary outliers like Argentina).
Unemployment Rate (%): National labor market dynamics.
Exchange Rate: Currency valuation against USD (1.97K–4.05K range scaling).
Architecture & Tech Stack
1. Data Engineering (R)
World Bank API Integration: Dynamic data retrieval via the WDI package.
ETL Process: Data cleaning, handling missing values, and indicator normalization using tidyverse.
2. Data Modeling (Power BI)
Star Schema Design: Fact table (dataset_macro_latam) connected via a 1:N relationship to a dedicated Date Dimension (Dim_Calendario 2000-2025).
3. Analytics & DAX Standards
Dedicated _Medidas table for clean measure isolation.
VAR/RETURN logic used for dynamic period filtering to target the most recent year (MAX(Dim_Calendario[Año])).
Re-scaled percentage calculations using DIVIDE functions to maintain strict scaling accuracy.
Repository Structure
─ assets/    --> Visual assets, screenshots, and exported PDF documentation
─ pbix/      --> Lightweight Power BI Template (.pbit)
─ scripts/   --> R scripts for automated data extraction
─ README.md  --> Project overview


How to Replicate
Run R Pipeline: Execute scripts/01_extraccion_datos.R to update the macroeconomic dataset directly from the World Bank API.
Open Dashboard: Load pbix/LATAM_Economic_Pulse.pbit in Power BI Desktop to inspect data models, relationships, and visual design layers.
